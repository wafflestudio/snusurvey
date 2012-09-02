class Example
  include Mongoid::Document

# fields
  field :content
  
# relations
  belongs_to :question
  has_and_belongs_to_many :replies
  has_many :pictures, :as => :picturable, :dependent => :destroy                                          # 사진

# validations
  validates :question, :presence => true
end
