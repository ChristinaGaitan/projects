class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = @project.tasks
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = @project.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_path(@project), notice: "Task was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_tasks_path(@project), notice: "Task was successfully updated." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to project_tasks_path(@project), status: :see_other, notice: "Task was successfully destroyed." }
    end
  end

  private
    def set_task
      @task = Task.find(params.expect(:id))
    end

    def task_params
      params.expect(task: [ :title, :completed, :project_id ])
    end

    def set_project
      @project = Project.find_by!(slug: params[:id]) # Looks up by slug instead of ID
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, alert: "Project not found"
    end
end
