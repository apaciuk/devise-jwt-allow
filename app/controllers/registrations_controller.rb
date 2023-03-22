class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # POST /users
  # Specs No
  def create
    build_resource(sign_up_params)

    resource.save
    if resource.persisted?
      render json: { message: I18n.t('controllers.registrations.success') }, status: 201, location: after_sign_up_path_for(resource), data: resource
      #mail = UserMailer.with(user: resource).welcome_email, deliver_now
    else
      render json: resource.errors, status: 401
    end
  end
end
