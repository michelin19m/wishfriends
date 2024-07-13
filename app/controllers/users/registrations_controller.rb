class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.profile_picture.attach(sign_up_params[:profile_picture]) if sign_up_params[:profile_picture].present?

    resource.save
    render_resource(resource)
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :profile_picture)
  end
end
