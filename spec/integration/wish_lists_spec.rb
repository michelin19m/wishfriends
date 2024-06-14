require 'swagger_helper'

RSpec.describe 'Wish Lists API', type: :request do
  path '/wish_lists' do
    post 'Creates a wish list' do
      tags 'Wish Lists'
      consumes 'application/json'
      parameter name: :wish_list, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }

      response '201', 'wish list created' do
        let(:wish_list) { { name: 'My Wish List' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:wish_list) { { name: '' } }
        run_test!
      end
    end
  end
end
