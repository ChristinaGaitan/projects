class Task < ApplicationRecord
  belongs_to :project
  has_one :user, through: :project
  validates :title, presence: true

  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
end
