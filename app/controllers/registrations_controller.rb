class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)
    p sign_up_params
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
      if sign_up_params[:email].nil? || sign_up_params[:email] !~ /@\w+\.\w+/
        flash[:notice] << "You must enter a valid email address"
      end

      if sign_up_params[:password].nil? || sign_up_params[:password].length < 8
        flash[:notice] = "You must enter a valid password"
      end

      if sign_up_params[:password] != sign_up_params[:password_confirmation]
        flash[:notice] = "Passwords do not match"
      end
      p flash
      render json: sign_up_params
    end
  end
end