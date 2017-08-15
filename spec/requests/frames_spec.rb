require 'rails_helper'

RSpec.describe 'Frames API', type: :request do
  let!(:game) { create(:game) }
  let(:game_id) { game.id }
  let!(:players) { create_list(:player, 8, game_id: game.id) }
  let(:player_id) { players.first.id }
  let(:frame_number) { 1 }
  let(:id) { 1 } # is frame id

  # Create action
  describe 'POST /games/:game_id/players/:player_id/frames' do
    let(:valid_attributes) do
      {
        ball_one_pins: 3,
        ball_two_pins: 7,
        ball_three_pins: 0
      }
    end

    context 'when request attributes are valid' do
      before { post api_v1_game_player_frames_path(game_id, player_id), params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns status code 201' do
        expected_response = valid_attributes.merge(
          player_id: player_id,
          frame_number: 1
        )
        expect(json_body).to include(expected_response)
      end
    end
  end

  # Update action
  describe 'PUT /games/:game_id/players/:player_id/frames/:counter' do
    let(:valid_attributes) { { ball_two_pins: 1 } }
    let(:frame) { create(:frame, frame_number: 2, player: players.first, ball_two_pins: 2) }

    def call_update(_game: game, _player: players.first, frame_number: 2)
      put api_v1_game_player_frame_path(_game, _player, frame_number), params: valid_attributes
    end

    context 'when the frame exists' do
      it 'returns status code 200' do
        call_update(frame_number: frame.frame_number)
        expect(response).to have_http_status(200)
      end

      it 'updates the frame' do
        expect{ call_update(frame_number: frame.frame_number) }.to change { frame.reload.ball_two_pins }.from(2).to(valid_attributes[:ball_two_pins])
      end
    end

    context 'when the frame does not exist' do
      it 'returns status code 404' do
        call_update(frame_number: 0)
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        call_update(frame_number: 0)
        expect(response.body).to match(/Couldn't find Frame/)
      end
    end
  end
end
