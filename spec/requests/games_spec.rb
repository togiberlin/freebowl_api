require 'rails_helper'

RSpec.describe 'Games API', type: :request do
  let!(:games) { create_list(:game, 10) }
  let(:id) { games.first.id }

  # Index action
  describe 'GET /api/v1/games' do
    before { get api_v1_games_path }

    it 'returns games' do
      expect(json_body).not_to be_empty
      expect(json_body.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Create action
  describe 'POST /api/v1/games' do
    let(:valid_attributes) { { created_by: 'Bowling Shop Owner' } }

    context 'when the request is valid' do
      before { post api_v1_games_path, params: valid_attributes }

      it 'creates a todo' do
        expect(json_body['created_by']).to eq('Bowling Shop Owner')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post api_v1_games_path, params: { foo: 'bar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Show action
  describe 'GET /api/v1/games/:id' do
    before { get api_v1_game_path(id) }

    context 'when record exists' do
      it 'returns the game' do
        expect(json_body).not_to be_empty
        expect(json_body['id']).to eq(id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when record does not exist' do
      let(:id) { 4000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Game/)
      end
    end
  end

  # Update action
  describe 'PUT /api/v1/games/:id' do
    let(:valid_attributes) { { created_by: 'The Second Bowling Admin' } }

    context 'when the record exists' do
      before { put api_v1_game_path(id), params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Destroy action
  describe 'DELETE /api/v1/games/:id' do
    before { delete api_v1_game_path(id) }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
