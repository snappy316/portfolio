class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
    @uploader = Project.new.image
    @uploader.success_action_redirect = new_project_url
  end

  def new
    @project = Project.new(key: params[:key])
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    authorize @project

    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project
    else
      flash.now[:error] = "Project could not be saved."
      render :new
    end
  end

  def show
    if request.path != project_path(@project)
      redirect_to @project, status: 301
    end
  end

  def edit
    authorize @project
  end

  def update
    authorize @project

    if @project.update_attributes(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @project

    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully destroyed.'
  end

  private

  def project_params
    params.require(:project).permit(:name, :slug, :technologies_used, :image, :key)
  end

  def set_project
    @project = Project.friendly.find(params[:id])
  end
end
