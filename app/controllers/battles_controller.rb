class BattlesController < ApplicationController
  def index
    @blank_battles = Battle.blank_games
    @ongoing_battles = []
  end

  def new
    names = ["Battle Of The Eternal Day",
             "Attack Of Frozen Fires",
             "War Of Eternal Suffering",
             "Assault Of The True King",
             "Siege Of New Hope",
             "War Of Blind Justice",
             "Siege Of The Apocalypse",
             "Assault Of The Last Stand"]

    @battle = BattleConfiguration.first.battles.new(:battle_name => names.sample)
  end

  def create
    @battle = Battle.new(battle_params)

    unless @battle.valid?
      render 'new' and return
    end

    unless verify_recaptcha(model: @battle)
      flash.now[:error] = "Are you a human?"
      render 'new' and return
    end

    @battle.creator_uuid = session[:player_uuid]

    unless @battle.save
      render 'new' and return
    end

    redirect_to battle_path(@battle)
  end

  def show
    @battle = Battle.find(params[:id])
    if @battle.ongoing?
      if @battle.player? session[:player_uuid]
        show_ongoing_player
      else
        show_ongoing_guest
      end
    else
      if @battle.creator_uuid == session[:player_uuid]
        show_blank_creator
      else
        show_blank_joiner
      end
    end
  end

  def update
  end

private

  def battle_params
    params.require(:battle).permit(:battle_name, :battle_configuration_id)
  end

  def show_blank_creator
    render "show_blank_creator"
  end

  def show_blank_joiner
    render "show_blank_joiner"
  end

  def show_ongoing_player
    render "show_ongoing_player"
  end

  def show_ongoing_guest
    render "show_ongoing_guest"
  end
end
