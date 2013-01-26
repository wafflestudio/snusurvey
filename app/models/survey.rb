class Survey
  include Mongoid::Document
  include Mongoid::Timestamps

# fields
  field :title, type: String                      # 설문지 제목
  field :description, type: String                # 설문지 설명(optional)

# relations
  belongs_to :survey_template, :class_name => "SurveyTemplate", :inverse_of => :surveys        # 설문 템플릿
  belongs_to :result_template, :class_name => "ResultTemplate", :inverse_of => :surveys # 결과 템플릿
  belongs_to :admin, :class_name => "User", :inverse_of => :surveys                     # 관리자
  has_many :questions, :dependent => :destroy                                           # 질문
  has_many :papers, :dependent => :destroy                                              # 설문지

# validations
  validates :title, :presence => true

  validates :survey_template, :presence => true
  validates :result_template, :presence => true
  validates :admin, :presence => true

# method
  def admin?(u)
    self.admin == u ? true : false
  end

  def is_entered?(u)
    self.papers.each do |p|
      return true if p.user == u && !p.completed
    end
    return false
  end

  def generate_paper(u)
    self.papers.each do |p|
      return p if p.user == u && !p.completed
    end
    return Paper.create(:user_id => u._id, :survey_id => self._id)
  end

  def self.to_csv(options={})
    CSV.generate(options) do |csv|
      all.each do |survey|
        csv << survey.title
      end
    end
  end
end
