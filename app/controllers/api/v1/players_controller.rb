class API::V1::PlayersController < ApplicationController
  # GET /api/v1/game/:game_id/players
  def index
    json_response(game.players.last(50))
  end

  # POST /api/v1/game/:game_id/players
  def create
    json_response(game.players.create!(player_params), :created)
  end

  # GET /api/v1/game/:game_id/players/:id
  def show
    json_response(game: player.game, player: player, frames: player.frames)
  end

  # PUT /api/v1/game/:game_id/players/:id
  def update
    player.update(player_params)
    head :no_content
  end

  # DELETE /api/v1/game/:game_id/players/:id
  def destroy
    player.destroy
    head :no_content
  end

  private

    def player_params
      params.permit(:name)
    end

    def game
      @game ||= Game.find(params[:game_id])
    end

    def player
      @player ||= game&.players.find(params[:id])
    end
end
