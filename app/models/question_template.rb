class QuestionTemplate
  include Mongoid::Document
  include Mongoid::Timestamps

  TEXTFIELD=0

  CHECKBOX=1
  RADIOBUTTON=2

# ...

# fields
  field :title, type: String                  # 템플릿 제목
  field :description, type: String            # 템플릿 설명(optional)
  field :type, type: Integer, :default => TEXTFIELD
  field :duplicated, type: Boolean, :default => false # 중복선택가능

# relations
  has_many :questions, :dependent => :destroy # 질문

# validations
  validates :title, :presence => true, :uniqueness => true
  validates :type, :numericality => true, :uniqueness => true # 반드시 우리가 정한 포맷을 의미하는 숫자
end
