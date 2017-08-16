class API::V1::GamesController < ApplicationController
  # GET /api/v1/games
  def index
    json_response(Game.last(50))
  end

  # POST /api/v1/games
  def create
    json_response(Game.create!(game_params), :created)
  end

  # GET /api/v1/games/:id
  def show
    json_response(scoreboard)
  end

  # PUT /api/v1/games/:id
  def update
    game.update(game_params)
    head :no_content
  end

  # DELETE /api/v1/games/:id
  def destroy
    game.destroy
    head :no_content
  end

  private

    def scoreboard
      {
        id: game.id,
        players: players_with_score
      }
    end

    def players_with_score
      game.players.map do |player|
        frames = player.frames
        { id: player.id, name: player.name, frames: (frames || []), total_score: (frames&.last&.score || 0) }
      end
    end

    def game_params
      params.permit(:created_by)
    end

    def game
      @game ||= Game.find(params[:id])
    end
end
