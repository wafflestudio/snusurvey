class Post
  include Mongoid::Document
  include Mongoid::Timesatmps

# feilds
  field :public, type: Boolean, :default => true        # 공개 여부
  field :title, type: String                            # 글 제목
  field :content, type: String                          # 글 내용(optional)
  field :like_count, type: Integer, :default => 0       # 좋아요 숫자
  field :dislike_count, type: Integer, :default => 0    # 싫어요 숫자

# relations
  belongs_to :admin, :class_name => "User", :inverse_of => :posts                           # 글쓴이
  belongs_to :board                                                                      # 소속 게시판 
  has_many :comments, :as => :commentable, :dependent => :destroy                           # 댓글
  has_and_belongs_to_many :like_users, :class_name => "User", :inverse_of => :like_posts    # 좋아요한 사용자
  has_and_belongs_to_many :dislike_users, :class_name => "User", :inverse_of => :like_posts # 싫어요한 사용자

# validations
  validates :title, :presence => true

  validates :admin, :presence => true
  validates :board, :presence => true

# method
  def admin?(u)
    self.admin == u ? true : false
  end
end
