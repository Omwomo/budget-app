class Group < ApplicationRecord
  belongs_to :user
  has_many :deals

  validates :name, presence: true
  validates :icon, presence: true
end
