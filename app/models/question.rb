class Question
  include Mongoid::Document

# fields
  field :title, type: String                      # 질문 제목
  field :description, type: String                # 질문 설명(optional)

# relations
  belongs_to :question_template, :class_name => "QuestionTemplate", :inverse_of => :questions  # 템플릿
  belongs_to :survey                                                                  # 설문
  has_many :replies, :dependent => :destroy                                           # 응답
  has_many :pictures, :as => :picturable, :dependent => :destroy                                          # 사진
  has_many :examples, :dependent => :destroy

# validations
  validates :title, :presence => true

  validates :template, :presence => true
  validates :survey, :presence => true
end
