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
  has_many :user_options, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :user_options, allow_destroy: true,
                                reject_if: ->(attrs) { attrs['value'].blank? }
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

  def first_name_if_exist
    # return first_name if exist and different of username
    return first_name unless username == first_name
  end

  def last_name_if_exist
    # return last_name if exist and different of username
    return last_name unless username == last_name
  end

  def options_values
    options_values = {}
    options.each do |option|
      options_values[option.name] = UserOption.find_by(user_id: self.id, option_id: option.id).value
    end
    options_values
  end
end
