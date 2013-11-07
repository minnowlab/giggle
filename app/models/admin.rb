class Admin < ActiveRecord::Base
  before_save { self.name = name.downcase }
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  has_secure_password
  validate :password, length: { minimum: 6 }

  def Admin.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Admin.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    
    def create_remember_token
      self.remember_token = Admin.encrypt(Admin.new_remember_token)
    end
end
