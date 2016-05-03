class Like < ActiveRecord::Base
	belongs_to :user
  belongs_to :status

  validates :status_id, uniqueness: { scope: :user_id }
end
