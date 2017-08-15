class API::V1::PlayersController < ApplicationController
  # GET /game/:game_id/players
  def index
    json_response(game.players.last(50))
  end

  # POST /game/:game_id/players
  def create
    json_response(game.players.create!(player_params), :created)
  end

  # GET /game/:game_id/players/:id
  def show
    json_response(game: player.game, player: player, frames: player.frames)
  end

  # PUT /game/:game_id/players/:id
  def update
    player.update(player_params)
    head :no_content
  end

  # DELETE /game/:game_id/players/:id
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
