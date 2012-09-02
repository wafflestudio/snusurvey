class SurveyTemplate
  include Mongoid::Document
  include Mongoid::Timestamps

# fields
  field :title, type: String                  # 템플릿 제목
  field :description, type: String            # 템플릿 설명(optional)
  field :public, type: Boolean, :default => true # 공개 여부
  field :perpage, type: Integer, :default => 0 # 0이면 한번에 다 보여주기

# relations
  has_many :surveys, :dependent => :destroy # 설문

# validations
  validates :title, :presence => true, :uniqueness => true
end
