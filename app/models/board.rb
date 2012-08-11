class Board
  include Mongoid::Document

# fields
  field :title, type: String                      # 게시판 이름 ex) 자유게시판
  field :description, type: String                # 게시판 설명
  field :order, type: Integer, :default => 0      # 게시판 순서
  field :public, type: Boolean, :default => true  # false : 익명

# relations
  has_many :posts, :dependent => :destroy # 글

# validations
  validates :title, :presence => true, :uniqueness => true
end
