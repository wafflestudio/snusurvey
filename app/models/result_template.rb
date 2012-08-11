class ResultTemplate
  include Mongoid::Document
  include Mongoid::Timestamps

# fields
  field :title                  # 템플릿 제목
  field :description            # 템플릿 설명(optional)

# relations
  has_many :surveys, :dependent => :destroy # 설문

# validations
  validates :title, :presence => true, :uniqueness => true
end
