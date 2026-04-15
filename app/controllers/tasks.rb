# frozen_string_literal: true

TodoApp::App.controllers :tasks do
  before do
    @categories = Category.recent
  end

  after do
    logger.debug "Action completed: #{request.path_info} at #{Time.now.strftime('%H:%M:%S')}"
  end

  # GET /tasks — show list of tasks with filters and sorting
  get :index do
    @filter     = params[:filter]   || 'all'
    @sort       = params[:sort]     || 'newest'
    @query      = params[:query].to_s.strip
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

    @pending    = Task.pending.count
    @done       = Task.completed.count
    render 'tasks/index'
  end

  # GET /tasks/new — show form to create new task
  get :new do
    @task       = Task.new
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
  patch :update, with: :id do
    @task = Task.find(params[:id])
    @task.update(completed: !@task.completed)
    redirect url(:tasks, :index)
  end

  # DELETE /tasks/destroy/:id — delete task
  delete :destroy, with: :id do
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = 'Task successfully deleted!'
    redirect url(:tasks, :index)
  end
end
