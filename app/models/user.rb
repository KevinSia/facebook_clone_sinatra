class User < ActiveRecord::Base
  # associations
  has_many :statuses, dependent: :destroy

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

  def save_password=(new_password)
    # store hashed password in db
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
