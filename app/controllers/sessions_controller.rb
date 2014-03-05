class SessionsController < Devise::SessionsController
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    sign_in(resource_name, resource)
    render :json => {:success => true}
  end

  def failure
    render :json => {:success => false, :errors => ["Login failed."]}, :status => :unprocessable_entity
  end
end