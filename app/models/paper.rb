class Paper
  include Mongoid::Document
  include Mongoid::Timestamps

# fields
  field :completed, type: Boolean, :default => false      # 설문 완료 여부

# relations
  belongs_to :user                                        # 사용자
  belongs_to :survey                                      # 소속 설문
  has_many :replies, :dependent => true                   # 응답

# validations
  validates :user, :presence => true
  validates :survey, :presence => true

# method
  def user?(u)
    self.user == u ? true : false
  end
end
