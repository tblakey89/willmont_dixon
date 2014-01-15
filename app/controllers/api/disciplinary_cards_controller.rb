class Api::DisciplinaryCardsController < ApplicationController
  before_filter :authenticate

  def index
    @disciplinary_cards = DisciplinaryCard.all
  end

  def show
    @disciplinary_card = DisciplinaryCard.find(params[:id])
  end

  def create
    @disciplinary_card = DisciplinaryCard.new(params[:disciplinary_card])
    if @disciplinary_card.save
      render :show, id: @disciplinary_card.id, status: 201
    else
      render nothing: true, status: 400
    end
  end

  def update
    @disciplinary_card = DisciplinaryCard.find(params[:id])
    if @disciplinary_card.update_attributes(params[:user])
      render :show, id: @disciplinary_card.id, status: 201
    else
      render nothing: true, status: 400
    end
  rescue
    render nothing: true, status: 400
  end

  def destroy
    DisciplinaryCard.find(params[:id]).destroy
    render nothing: true, status: 204
  rescue
    render nothing: true, status: 400
  end
end
