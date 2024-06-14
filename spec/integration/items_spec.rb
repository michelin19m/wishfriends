require 'swagger_helper'

RSpec.describe 'Item Creation API', type: :request do
  path '/wish_lists/{wish_list_id}/items' do
    post 'Creates a new item with images' do
      tags 'Items'
      consumes 'multipart/form-data'
      parameter name: :wish_list_id, in: :path, type: :string
      parameter name: :item, in: :formData, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          images: { type: :array, items: { type: :string, format: :binary } }
        },
        required: %w[name description]
      }

      response '201', 'item created' do
        let(:wish_list_id) { create(:wish_list).id }
        let(:item) { { name: 'Test Item', description: 'This is a test item', images: [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/item_image1.jpg'), 'image/jpeg'), Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/item_image2.jpg'), 'image/jpeg')] } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:wish_list_id) { create(:wish_list).id }
        let(:item) { { name: '' } }
        run_test!
      end
    end
  end
end
