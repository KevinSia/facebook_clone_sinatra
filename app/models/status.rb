class Status < ActiveRecord::Base
	# associations
  belongs_to :user
  has_many :likes

  validates :content, presence: true, length: { maximum: 140 }

  def liked_by?(user)
    likes.find_by(status_id: id, user_id: user)
  end
end
