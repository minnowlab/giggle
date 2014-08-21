class User < ActiveRecord::Base
  has_secure_password

  has_many :evaluates
  has_many :messages
  has_many :user_pictures
  has_many :collectionships, foreign_key: "user_id", dependent: :destroy
  has_many :collections, through: :collectionships, source: :product
  has_many :likeships, foreign_key: "user_id", dependent: :destroy
  has_many :likes, through: :likeships, source: :likeable
  has_many :notifications
  belongs_to :cover, class_name: "UserPicture", foreign_key: "cover_id"

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  ROLES = %w[admin manager user]
  ROLES_CN = %w[超级管理员 管理员 用户]
  ROLES_CHECKBOX = [['admin', '超级管理员'], ['manager', '管理员'], ['user', '用户']]
  attr_accessor :skip_password
  
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, unless: :skip_password
  validates :description, length: { maximum: 140 }

  def remember_token
    [id, Digest::SHA512.hexdigest(password_digest)].join('$')
  end

  def self.find_by_remember_token(token)
    user = User.find(token.split('$').first)
    (user && user.remember_token == token) ? user : nil
  end

  #Notifiction
  def unread_notifications_count
    notifications.where(read: false).count
  end

  #Collect
  def collect!(product)
    collectionships.create!(product: product)
  end

  def uncollect!(product)
    collectionships.find_by(product_id: product.id).destroy
  end

  def collectionship_product_ids
    collectionships.map(&:product_id)
  end

  #Like
  def liking?(likeable)
    likeships.find_by(likeable)
  end

  def like!(type, id)
    likeships.create!(likeable_type: type, likeable_id: id)
  end  

  def unlike!(type, id)
    likeships.find_by(likeable_type: type, likeable_id: id).destroy
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

  def roles_cn
    ROLES_CN.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES_CN.index(r)).zero?
    end.join(',')
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  def self.user_search this_params
    user = User.all
    user = user.where("email LIKE ?", "%#{this_params[:email]}%") if this_params[:email].present?
    user = user.where("name LIKE ?", "%#{this_params[:name]}%") if this_params[:name].present?
    user.paginate(page: this_params[:page])
  end

end
