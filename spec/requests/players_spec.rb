require 'rails_helper'

RSpec.describe 'Players API', type: :request do
  let!(:game) { create(:game) }
  let!(:players) { create_list(:player, 8, game_id: game.id) }
  let(:game_id) { game.id }
  let(:id) { players.first.id }

  # Index action
  describe 'GET /api/v1/games/:game_id/players' do
    before { get api_v1_game_players_path(game_id) }

    context 'when a game exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all players' do
        expect(json_body.size).to eq(8)
      end
    end

    context 'when a game does not exist' do
      let(:game_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Game/)
      end
    end
  end

  # Create action
  describe 'POST /api/v1/games/:game_id/players' do
    let(:valid_attributes) { { name: 'Peter Griffin'} }

    context 'when request attributes are valid' do
      before { post api_v1_game_players_path(game_id), params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post api_v1_game_players_path(game_id), params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Show action
  describe 'GET /api/v1/games/:game_id/players/:id' do
    before { get api_v1_game_player_path(game_id, id) }

    context 'when a player exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns a player' do
        expect(json_body.dig(:player, :id)).to eq(id)
      end
    end

    context 'when a game player does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Player/)
      end
    end
  end

  # Update action
  describe 'PUT /api/v1/games/:game_id/players/:id' do
    let(:valid_attributes) { { name: 'Lois Griffin' } }

    before { put api_v1_game_player_path(game_id, id), params: valid_attributes }

    context 'when the player exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the player' do
        updated_player = Player.find(id)
        expect(updated_player.name).to match(/Lois Griffin/)
      end
    end

    context 'when the player does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Player/)
      end
    end
  end

  # Destroy action
  describe 'DELETE /api/v1/games/:game_id/players/:id' do
    before { delete api_v1_game_player_path(game_id, id) }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
