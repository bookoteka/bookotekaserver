class GatunkiController < ApplicationController
  def create
    @gatunek = Gatunek.new(gatunek_params)

    if @gatunek.save
      redirect_to "/ustawienia?zakladka=gatunki", notice: "Dodano gatunek."
    else
      redirect_to "/ustawienia?zakladka=gatunki", alert: "Nie udało się dodać gatunku."
    end
  end

  def destroy
    @gatunek = Gatunek.find(params[:id])
    @gatunek.destroy

    redirect_to "/ustawienia?zakladka=gatunki", notice: "Usunięto gatunek."
  end

  private

  def gatunek_params
    params.require(:gatunek).permit(:nazwa)
  end
end