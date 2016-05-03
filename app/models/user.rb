class User < ActiveRecord::Base
  # associations
  has_many :statuses, dependent: :destroy
  has_many :likes, dependent: :destroy
  # user id on user_id column
  has_many :friendships
  has_many :friends, through: :friendships # will find association called (:friends) in friendship model

  # user id on friend_id column
  has_many :frienderships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :frienders, through: :frienderships, source: :user

  # libraries
  include BCrypt

  # validations
  validates :first_name, presence: true, length: { maximum: 15 }
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }

  # methods
  def password
    @password ||= Password.new(password_digest)
  end

  def authenticate(login_password)
    self.password == login_password
  end

  def save_password(new_password)
    # store hashed password in db
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def feed
    user_ids = friend_ids + friender_ids + [id]
    Status.where(user_id: user_ids).includes(:user).order(updated_at: :desc).includes(:likes)
  end

  def all_friends
    friends + frienders
  end

  def is_friend?(user)
    return true if self == user
    all_friends.include?(user)
  end

end
