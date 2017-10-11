require 'encrypted_coder'

class UserOption < ApplicationRecord
  serialize :value, EncryptedCoder.new
  belongs_to :user
  belongs_to :option
  validates :option, uniqueness: { scope: :user }
  validates :value, presence: true
end
