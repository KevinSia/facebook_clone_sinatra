class Status < ActiveRecord::Base
	# associations
  belongs_to :user
  has_many :likes

  validates :content, presence: true, length: { maximum: 140 }
end
