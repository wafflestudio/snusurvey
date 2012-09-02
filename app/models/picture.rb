class Picture
  include Mongoid::Document

# fields
  has_mongoid_attached_file :attachment, # 수정필요
    :path           => Rails.root.to_s + "/public/system/question_attachment/:id/:style.:extension",
    :default_url    => "/system/question_attachment/default_:style.jpg",
    :url            => "/system/question_attachment/:id/:style.jpg",
    :styles         => {
    :original => ['1920x1680>', :jpg],
    :small    => ['100x100#',   :jpg],
    :medium   => ['250x250',    :jpg],
    :large    => ['500x500>',   :jpg]
  }

# relations
  belongs_to :picturable, :polymorphic => true # require picturable_type ex) picturable_type="Question"

# validations
  validates :picturable, :presence => true
end
