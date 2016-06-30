class CopyprojectController < ApplicationController
 
  before_filter :find_project, :authorize, :only =>  :index 

  def index    
    @issue_custom_fields = IssueCustomField.sorted.to_a
    @trackers = Tracker.sorted.to_a
    @source_project = Project.find(params[:project_id])
    if request.get?
      @project = Project.copy_from(@source_project)
      @project.identifier = Project.next_identifier if Setting.sequential_project_identifiers?      
    end
    rescue ActiveRecord::RecordNotFound
    render_404
  end

  def copy
    @source_project = Project.find(params[:id])
    if request.post?
      Mailer.with_deliveries(params[:notifications] == '1') do
        @project = Project.new
        @project.safe_attributes = params[:project]
        test = @project.copy(@source_project, :only => params[:only])
        if test
          flash[:notice] = l(:notice_project_copied)
          redirect_to project_path(@project)
        else
          flash[:error] = l(:error_project_already_exists)
          redirect_to controller: 'copyproject', action: 'index', project_id: @source_project.id
        end
      end
    end
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
