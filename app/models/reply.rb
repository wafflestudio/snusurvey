class Reply
  include Mongoid::Document
  include Mongoid::Timestamps

# fields
  field :content, type: String, :default => ""

# relations
  belongs_to :question      # 질문
  belongs_to :paper         # 설문지
  has_and_belongs_to_many :examples         # OR belongs_to :example

# validations
  validates :question, :presence => true
  validates :paper, :presence => true
end
