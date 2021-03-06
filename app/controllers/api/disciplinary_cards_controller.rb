class Api::DisciplinaryCardsController < ApplicationController
  before_filter :authenticate

  def index
    @disciplinary_cards = DisciplinaryCard.all
    respond_to do |format|
      format.json
      format.xls
      format.csv { send_data @disciplinary_cards.to_csv  }
    end
  end

  def show
    @disciplinary_card = DisciplinaryCard.find(params[:id])
  end

  def create
    @disciplinary_card = DisciplinaryCard.new(safe_params)
    if @disciplinary_card.save
      render :show, id: @disciplinary_card.id, status: 201
    else
      render :json => { :errors => @disciplinary_card.errors }, status: 400
    end
  end

  def update
    @disciplinary_card = DisciplinaryCard.find(safe_params)
    if @disciplinary_card.update_attributes(params[:user])
      render :show, id: @disciplinary_card.id, status: 201
    else
      render :json => { :errors => @disciplinary_card.errors }, status: 400
    end
  end

  def destroy
    DisciplinaryCard.find(params[:id]).destroy
    render nothing: true, status: 204
  end

private
  def safe_params
    params.require(:disciplinary_card).permit(:user_id, :reason, :location, :colour) unless params[:disciplinary_card].blank?
  end
end
