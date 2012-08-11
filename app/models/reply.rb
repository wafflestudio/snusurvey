class Reply
  include Mongoid::Document
  include Mongoid::Timestamps

# fields
  field :selected, type: Array, :default => [] # 선택한 보기

# relations
  belongs_to :question      # 질문
  belongs_to :paper         # 설문지

# validations
  validates :question, :presence => true
  validates :paper, :presence => true
end
