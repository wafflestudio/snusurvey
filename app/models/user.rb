class User
  include Mongoid::Document
  include Mongoid::Timestamps

# fields
  field :fbid, type: String                             # 페이스북 ID
  field :name, type: String                             # 사이트 아이디
  field :password, type: String                         # 비밀번호
  attr_accessor :password_confirmation                  # 비밀번호 확인
  field :salt, type: String, :default => "!$tantara.me!"# SALT

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
  has_many :posts, :class_name => "Post", :inverse_of => :admin                                 # 쓴 글
  has_and_belongs_to_many :like_posts, :class_name => "Post", :inverse_of => :like_uesrs                            # 좋아요 글
  has_and_belongs_to_many :dislike_posts, :class_name => "Post", :inverse_of => :dislike_uesrs                         # 싫어요 글 
  has_many :comments, :class_name => "Comment", :inverse_of => :admin                              # 댓글 
  has_and_belongs_to_many :like_comments, :class_name => "Comment", :inverse_of => :like_users                         # 좋아요 댓글
  has_and_belongs_to_many :dislike_comments, :class_name => "Comment", :inverse_of => :dislike_users                      # 싫어요 댓글
  has_many :feedbacks                             # 피드백 글

# validations
  validates :fbid, :presence => true, :uniqueness => true
  #validates :name, :presence => true, :uniqueness => true
  #validates :password, :length => {:minimum => 8}

# callback
  #before_save :encrypt_password
  #after_create :send_auth_key

# method
  def generate_auth_key
    name = "fasdfadf"
    puts self.name
    puts name
  end

  # email
  def send_auth_key
    #UserMailer.send_auth_key(u)
  end

  private
  def generate_salt
    self.salt = "!$tantara.me!"
  end
  def generate_auth_key
    self.auth_key = Digest::SHA512.hexdigest(self.name + Time.now.to_s + "!$tantara.me!")
  end
  def encrypt_password
    if self.password == self.password_confirmation
      self.password = User.encrypted_password(self.password)
      true
    else
      false
    end
  end
  def self.encrypted_password(p)
    Digest::SHA512.hexdigest(Time.now.to_s + p + "!$tantara!")
  end
  def self.authenticate(name, password)
    user = User.where(:name => name, :password => User.encrypted_password(password)).first
  end
  def self.authenticate_with_salt(id, salt)
    user = User.where(:_id => id, :salt => salt).first
  end
end
