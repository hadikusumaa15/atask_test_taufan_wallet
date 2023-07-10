module ApplicationHelper
  def active_tab(endpoints)
    (endpoints.include? request.fullpath.to_s) ? "nav-link active" : "nav-link"
  end
end
