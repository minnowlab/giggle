class User < ActiveRecord::Base

  has_secure_password

  has_many :evaluates
  has_many :messages
  has_many :user_pictures
  has_many :collectionships, foreign_key: "user_id", dependent: :destroy
  has_many :collections, through: :collectionships, source: :product
  has_many :likeships, foreign_key: "user_id", dependent: :destroy
  has_many :liks, through: :likeships, source: :likeable
  belongs_to :cover, class_name: "UserPicture", foreign_key: "cover_id"

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  ROLES = %w[admin manager user]

  attr_accessor :skip_password
  
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 50 }
  validates :password, length: { minimum: 6 }, unless: :skip_password
  validates :description, length: { maximum: 140 }

  def remember_token
    [id, Digest::SHA512.hexdigest(password_digest)].join('$')
  end

  def self.find_by_remember_token(token)
    user = User.find(token.split('$').first)
    (user && user.remember_token == token) ? user : nil
  end

  def feed
    UserPicture.where("user_id = ?", id)
  end

  #Collect
  def collecting?(product)
    collectionships.find_by(product_id: product.id)
  end

  def collect!(product)
    collectionships.create!(product: product)
  end

  def uncollect!(product)
    collectionships.find_by(product_id: product.id).destroy
  end

  def collectionship_product_ids
    collectionships.map(&:product_id)
  end

  #Role define
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  def self.user_search this_params
    user = User.all
    user = user.where("email LIKE ?", "%#{this_params[:email]}%") if this_params[:email].present?
    user = user.where("name LIKE ?", "%#{this_params[:user]}%") if this_params[:user].present?
    user
  end

end
