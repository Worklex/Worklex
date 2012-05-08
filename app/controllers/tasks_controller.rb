class TasksController < ApplicationController
  before_filter :authenticate_with_api_key, :if => lambda { |controller| controller.request.format.atom? }
  before_filter :redirect_to_root, :unless => :signed_in?

  def index
    @tasks = Task.by_user(current_user).paginate(:page => params[:page],
      :order => 'created_at DESC', :per_page => 5)
    render :index
  end

  def show
     @task = Task.find(params[:id])
     @json = @task.to_gmaps4rails
  end

  def search
    if params[:text].nil? or params[:text].blank?
      @tasks = nil
    else
      @tasks = Task.search_by(params[:text]).paginate(:page => params[:page],
        :order => 'created_at DESC', :per_page => 5)
    end
    render :search
  end

  def new
    @task = Task.new
    @json = @task.to_gmaps4rails
  end

  def create
    @task = Task.new(params[:task])
    @task.owner_id = current_user.id
    if @task.save
      flash[:success] = "Your task was created."
      redirect_to tasks_path
    else
      flash[:notice] = "Could not save task."
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
    @json = @task.to_gmaps4rails
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
        flash[:success] = "Task was successfully updated."
        redirect_to @task
      else
        flash[:notice] = "Could not save task."
        render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "Task was deleted."
    redirect_to tasks_path
  end

  private

  def set_marker(task)
    @json = task.to_gmaps4rails do |task, marker|
      #marker.infowindow render_to_string(:partial => "task", :locals => { :object => task}).gsub(/\n/, '').gsub(/"/, '\"')
#      marker.picture({
#                      :picture => "http://www.blankdots.com/img/github-32x32.png",
#                      :width   => "32",
#                      :height  => "32"
#                     })
      marker.title   "i'm the title"
      marker.sidebar "i'm the sidebar"
      marker.json    "\"id\": #{task.id}"
    end
  end

end
