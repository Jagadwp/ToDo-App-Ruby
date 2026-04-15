# frozen_string_literal: true

TodoApp::App.controllers :tasks do
  # runs for all actions — load categories
  before do
    @categories = Category.recent
  end

  # runs before :update and :destroy — find task first
  # if not found, redirect with error before action runs
  before :update, :destroy do
    @task = Task.find_by(id: params[:id])
    unless @task
      flash[:error] = 'Task not found.'
      redirect url(:tasks, :index)
    end
  end

  # runs before :create — log attempt
  before :create do
    logger.debug "Attempting to create task with title: '#{params[:title]}'"
  end

  # runs before :new and :create — log categories count
  before :new, :create do
    logger.debug "Categories available: #{@categories.count}"
  end

  after do
    logger.debug "Action completed: #{request.path_info} at #{Time.now.strftime('%H:%M:%S')}"
  end

  # GET /tasks — show list of tasks with filters and sorting
  get :index do
    @filter      = params[:filter]      || 'all'
    @sort        = params[:sort]        || 'newest'
    @query       = params[:query].to_s.strip
    @category_id = params[:category_id].to_s.strip

    @tasks = case @filter
             when 'completed' then Task.completed
             when 'pending'   then Task.pending
             else                  Task.all
             end

    @tasks = @tasks.by_category(@category_id) unless @category_id.empty?
    @tasks = @tasks.search(@query)            unless @query.empty?

    @tasks = case @sort
             when 'oldest' then @tasks.order(created_at: :asc)
             when 'a_to_z' then @tasks.order(title: :asc)
             when 'z_to_a' then @tasks.order(title: :desc)
             else               @tasks.order(created_at: :desc)
             end

    @pending = Task.pending.count
    @done    = Task.completed.count
    render 'tasks/index'
  end

  # GET /tasks/new — show form to create new task
  get :new do
    @task = Task.new
    render 'tasks/new'
  end

  # POST /tasks/create — create new task
  post :create do
    if params[:title].to_s.strip.empty?
      flash[:error] = "Title can't be blank"
      redirect url(:tasks, :new)
    else
      @task = Task.new(
        title: params[:title].to_s.strip,
        category_id: params[:category_id].presence
      )

      if @task.save
        flash[:success] = 'Task successfully added!'
        redirect url(:tasks, :index)
      else
        flash[:error] = @task.errors.full_messages.join(', ')
        redirect url(:tasks, :new)
      end
    end
  end

  # PATCH /tasks/update/:id — toggle completed
  # @task already loaded by before filter
  patch :update, with: :id do
    @task.update(completed: !@task.completed)
    redirect url(:tasks, :index)
  end

  # DELETE /tasks/destroy/:id — delete task
  # @task already loaded by before filter
  delete :destroy, with: :id do
    @task.destroy
    flash[:success] = 'Task successfully deleted!'
    redirect url(:tasks, :index)
  end
end
