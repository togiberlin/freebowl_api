class API::V1::FramesController < ApplicationController
  # POST /api/v1/games/:game_id/players/:player_id/frames
  def create
    json_response(player.frames.create!(frame_params).reload, :created)
  end

  # PUT /api/v1/games/:game_id/players/:player_id/frames/:id
  def update
    frame.update!(frame_params)
    json_response(frame.reload)
  end

  private

    def player
      @player ||= Player.find_by!(id: params[:player_id], game_id: params[:game_id])
    end

    def frame
      @frame ||= Frame.find_by!(frame_number: params[:frame_number], player: player)
    end

    def frame_params
      params.permit(:ball_one_pins, :ball_two_pins, :ball_three_pins)
    end
end
