class User < ActiveRecord::Base

  has_secure_password
  validates :name, presence: true
  validates :lastName, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: {minimum: 4}
  validates :password_confirmation, presence: true
  validates_uniqueness_of :email, :case_sensitive => false


  def self.authenticate_with_credentials (email, password)
    userEmail = email.downcase
    @user = User.find_by_email(userEmail)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end 
  end
end
