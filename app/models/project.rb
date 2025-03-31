class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  def tasks_count_by_status
    tasks.group_by(&:completed).transform_values(&:count)
  end
end
