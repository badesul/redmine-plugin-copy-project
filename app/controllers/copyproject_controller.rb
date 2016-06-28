class CopyprojectController < ProjectsController
  unloadable

  before_filter :find_project, :authorize, :only => :index
  
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

  private
  
  def find_project
    @project = Project.find(params[:project_id])
  end

end
