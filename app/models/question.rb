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
  #validates :title, :presence => true

  validates :question_template, :presence => true
  validates :survey, :presence => true

# callback
  before_save :check_example_length
  after_create :create_examples

# methods
  def create_examples
    if self.question_template.type == QuestionTemplate::TEXTFIELD
      example = self.examples.new
      example.save
    end
  end

  def check_example_length
    if self.question_template.type == QuestionTemplate::TEXTFIELD
      if self.examples.length > 1
        self.examples = [self.examples.first]
      end
    end
  end
end
