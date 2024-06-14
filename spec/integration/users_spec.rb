require 'swagger_helper'

RSpec.describe 'User Registration API', type: :request do
  path '/users' do
    post 'Registers a new user with profile picture' do
      tags 'Users'
      consumes 'multipart/form-data'
      parameter name: :user, in: :formData, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string },
          profile_picture: { type: :string, format: :binary }
        },
        required: %w[email password password_confirmation]
      }

      response '201', 'user created' do
        let(:user) { { email: 'user@example.com', password: 'password', password_confirmation: 'password', profile_picture: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/profile_picture.jpg'), 'image/jpeg') } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { email: 'user@example.com' } }
        run_test!
      end
    end
  end
end
