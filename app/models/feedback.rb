class Feedback
  include Mongoid::Document
  include Mongoid::Timestamps::Created

# fields
  field :content, :type => String                       # 내용
  field :password, :type => String, :default => "0000"  # 비회원 삭제 비밀번호

# relations
  belongs_to :users

# validations
  validates :content, :presence => true

# callback

# method
  def user?(u)
    self.user == u ? true : false
  end
  private
  def self.encrypt_password(password)
    Digest::SHA256.hexdigest(password)
  end
end
