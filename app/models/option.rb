class Option < ApplicationRecord
  has_many :user_options
  has_many :users, through: :user_options
  validates :name, presence: true
end
