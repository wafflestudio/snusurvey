class QuestionTemplate
  include Mongoid::Document
  include Mongoid::Timestamps

# fields
  field :title                  # 템플릿 제목
  field :description            # 템플릿 설명(optional)

# relations
  has_many :questions, :dependent => :destroy # 질문

# validations
  validates :title, :presence => true, :uniqueness => true
end
