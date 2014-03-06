class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(params[:sign_up_params])
    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
      end
    else
      flash[:notice] = []
      if params[:sign_up_params][:email].nil? || params[:sign_up_params][:email] !~ /@\w+\.\w+/
        flash[:notice] << "You must enter a valid email address"
      end

      if params[:sign_up_params][:password].nil? || params[:sign_up_params][:password].length < 8
        flash[:notice] << "You must enter a valid password"
      end

      if params[:sign_up_params][:password] != params[:sign_up_params][:password_confirmation]
        flash[:notice] << "Passwords do not match"
      end

      if !User.find_by_email(params[:sign_up_params][:email]).nil? && params[:sign_up_params][:email] == User.find_by_email(params[:sign_up_params][:email]).email
        flash[:notice] << "Email is already taken"
      end
      render json: flash[:notice], status: :unprocessable_entity
    end
  end
end