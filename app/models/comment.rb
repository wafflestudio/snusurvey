class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

# fields
  field :public, type: Boolean, :default => true      # 공개 여부
  field :content, type: String                        # 내용
  field :like_count, type: Integer, :default => 0     # 좋아요 숫자
  field :dislike_count, type: Integer, :default => 0  # 싫어요 숫자

# relations
  belongs_to :commentable, :polymorphic => true
  belongs_to :admin, :class_name => "User", :inverse_of => :comments                              # 글쓴이
  has_and_belongs_to_many :like_users, :class_name => "User", :inverse_of => :like_comments       # 좋아요한 사용자
  has_and_belongs_to_many :dislike_users, :class_name => "User", :inverse_of => :dislike_comments # 싫어요한 사용자

# validations
  validates :content, :presence => true

  validates :admin, :presence => true
  validates :commentable, :presence => true

# method
  def admin?(u)
    self.admin == u ? true : false
  end
end
