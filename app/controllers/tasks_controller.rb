class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_found
    end
  end

  def new
    @task = Task.new
  end

  def create
    filtered_task_params = task_params()
    @task = Task.new(filtered_task_params)

    is_successful_save = @task.save

    if is_successful_save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def mark_complete
    task = Task.find_by(id: params[:id])
    task.update(completion_date: 'Complete')
    redirect_to tasks_path
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end


  def update
    task = Task.find(params[:id])
    task.update(task_params)
    redirect_to task_path
  end



  def destroy
    task = Task.find_by(id: params[:id])

    task.destroy
    redirect_to tasks_path
  end

  private

  def task_params
    # only take in these params. Lesson attacks on site
    return params.require(:task).permit(
      :action,
      :description,
      :completion_date
    )
  end

end
