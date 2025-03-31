class UpdateExistingProjectsWithSlug < ActiveRecord::Migration[8.0]
  def up
    Project.all.each do |project|
      project.slug = project.name.parameterize
      project.save!
    end
  end

  def down
    Project.all.each do |project|
      project.slug = nil
      project.save!
    end
  end
end
