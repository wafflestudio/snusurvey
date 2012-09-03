class ResultTemplate
  include Mongoid::Document
  include Mongoid::Timestamps

  STICK=1
  CIRCLE=2
# ...

# fields
  field :title                  # 템플릿 제목
  field :description            # 템플릿 설명(optional)
  field :type, type: Integer, :default => STICK

# relations
  has_many :surveys, :dependent => :destroy # 설문

# validations
  validates :title, :presence => true, :uniqueness => true
  validates :type, :numericality => true, :uniqueness => true
end
