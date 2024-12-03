# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Photos', type: :request do
  describe 'GET /index' do
    let(:user) { create(:user) }

    let(:photo_data) do
      [
        {
          'id' => 1,
          'latitude' => 35.6762,
          'longitude' => 139.6503,
          'localDateTime' => '2024-01-01T00:00:00.000Z',
          'originalFileName' => 'photo1.jpg',
          'city' => 'Tokyo',
          'state' => 'Tokyo',
          'country' => 'Japan',
          'type' => 'photo',
          'source' => 'photoprism'
        },
        {
          'id' => 2,
          'latitude' => 40.7128,
          'longitude' => -74.0060,
          'localDateTime' => '2024-01-02T00:00:00.000Z',
          'originalFileName' => 'photo2.jpg',
          'city' => 'New York',
          'state' => 'New York',
          'country' => 'USA',
          'type' => 'photo',
          'source' => 'immich'
        }
      ]
    end

    context 'when the request is successful' do
      before do
        allow_any_instance_of(Photos::Request).to receive(:call).and_return(photo_data)

        get '/api/v1/photos', params: { api_key: user.api_key }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns photos data as JSON' do
        expect(JSON.parse(response.body)).to eq(photo_data)
      end
    end
  end
end
