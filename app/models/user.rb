class User < ApplicationRecord
  ransack_alias :user, :username_or_first_name_or_last_name
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, :recoverable, :rememberable
  devise :database_authenticatable, :trackable, :validatable, :timeoutable
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  before_validation(on: :create) do
    self.email = "#{self.username}@pbna.intra" if self.email.blank? || self.email == 'ennov@bordeauxnord.com'
  end
  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }
  validates_format_of :username, with: /^[^@]*$/, :multiline => true
  validate :validate_username
  has_many :user_options
  has_many :options, through: :user_options


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

end
