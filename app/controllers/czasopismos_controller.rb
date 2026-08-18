class CzasopismosController < ApplicationController
  before_action :set_czasopismo, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @czasopismo = Czasopismo.new
  end

  def create
    @czasopismo = Czasopismo.new(czasopismo_params)
    @czasopismo.przeczytano_w = Date.today

    if @czasopismo.save
      redirect_to ksiazkas_path, notice: "Czasopismo zostało pomyślnie dodane!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @czasopismo.update(czasopismo_params)
      redirect_to @czasopismo, notice: "Czasopismo zostało zaktualizowane!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @czasopismo.destroy
    redirect_to ksiazkas_path, notice: "Czasopismo zostało usunięte."
  end

  private

  def set_czasopismo
    @czasopismo = Czasopismo.find(params[:id])
  end

  def czasopismo_params
    params.require(:czasopismo).permit(:tytul, :numer_wydania, :strony, :przeczytano_w)
  end
end