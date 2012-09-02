class User
  include Mongoid::Document
  include Mongoid::Timestamps

# fields
  field :name, type: String                             # 마이스누 아이디
  field :password, type: String                         # 비밀번호
  attr_accessor :password_confirmation                  # 비밀번호 확인
  field :salt, type: String                             # SALT
  field :nickname, type: String, :default => self.name  # 닉네임

  # 인증정보
  field :auth, type: Boolean, :default => true    # 인증 여부
  field :expire_time, type: DateTime              # 인증 허용 날짜 ex) expire_time을 넘어가면 해당 인증키로는 인증이 안됨
  field :auth_key, type: String                   # 인증키

  # 신상정보
  field :gender, type: Boolean, :default => true  # 성별 true : 남성, false : 여성
  field :age, type: Integer, :default => 21       # 나이

  # 학사정보
  field :college, type: String                    # 대학 ex) 공과대학
  field :department, type: String                 # 학부 ex) 컴퓨터공학부

# relations
  has_many :surveys                               # 설문
  has_many :papers                                # 설문지
  has_many :posts                                 # 쓴 글
  has_many :like_posts                            # 좋아요 글
  has_many :dislike_posts                         # 싫어요 글 
  has_many :comments                              # 댓글 
  has_many :like_comments                         # 좋아요 댓글
  has_many :dislike_comments                      # 싫어요 댓글
  has_many :feedbacks                             # 피드백 글

# validations
  validates :name, :presence => true, :uniqueness => true
  validates :password, :length => {:minimum => 8}
  validates :nickname, :presence => true, :uniqueness => true

# callback
  before_create :assign_nickname
  before_save :encrypt_password

# method
  def generate_auth_key
    name = "fasdfadf"
    puts self.name
    puts name
  end

  def assign_nickname
    self.nickname = Time.now + self.mysnu
  end

  # email
  def send_auth_key
    #UserMailer.send_auth_key(u)
  end

  def encrypt_password                  # 암호화된 비밀번호 할당
    if !self.password_confirmation.nil? && self.password == self.password_confirmation
      self.password = User.encrypted_password(self.password)
    end
  end
  def self.encrypted_password(password) # 비밀번호 암호화
  end
end
