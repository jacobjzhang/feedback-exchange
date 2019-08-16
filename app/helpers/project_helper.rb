module ProjectHelper
  def handle_project_signup
    handle_session_categories
    # save project
    @project = current_user.projects.create(session[:project])
    # clear session
    session[:project] = nil

    #redirect
    flash[:notice] = "You're now logged in. Nice project, btw :)"
    project_path(@project)
  end

  def handle_params_categories
    handle_categories(params[:project])
  end

  def handle_session_categories
    handle_categories(session['project'])
  end

  def handle_categories(project_hash)
    if project_hash['categories']
      categories = project_hash['categories'].compact
      project_hash['category_list'] = categories.join(', ')
      project_hash.delete('categories')
    end
  end
end