class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  before_create :set_slug

  def tasks_count_by_status
    tasks.group_by(&:completed).transform_values(&:count)
  end

  private
  def set_slug
    self.slug = name.parameterize
  end
end
