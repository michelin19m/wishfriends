class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.profile_picture.attach(params[:user][:profile_picture]) if params[:user][:profile_picture].present?

    resource.save
    render_resource(resource)
  end
end
