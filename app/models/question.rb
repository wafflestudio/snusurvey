class Question
  include Mongoid::Document

# fields
  field :title, type: String                      # 질문 제목
  field :description, type: String                # 질문 설명(optional)
  field :example, type: Array, :default => []     # 보기
  field :order, type: Integer, :default => 0      # 질문 순서

# relations
  belongs_to :template, :class_name => "QuestionTemplate", :inverse_of => :questions  # 템플릿
  belongs_to :survey                                                                  # 설문
  has_many :replies, :dependent => :destroy                                           # 응답
  has_many :pictures, :dependent => :destroy                                          # 사진

# validations
  validates :title, :presence => true

  validates :template, :presence => true
  validates :survey, :presence => true
end
