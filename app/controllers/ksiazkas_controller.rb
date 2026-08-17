class KsiazkasController < ApplicationController
  before_action :set_ksiazka, only: [:show, :edit, :update, :destroy]

  def index
    @ksiazkas = Ksiazka.all
  end

  def show
  end

  def new
    @ksiazka = Ksiazka.new
    @gatunki = Gatunek.all
  end

  def create
    @ksiazka = Ksiazka.new(ksiazka_params)
    @ksiazka.przeczytano_w = Date.today

    if @ksiazka.save
      redirect_to @ksiazka, notice: "Książka została pomyślnie dodana!"
    else
      @gatunki = Gatunek.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @gatunki = Gatunek.all
  end

  def update
    if @ksiazka.update(ksiazka_params)
      redirect_to @ksiazka, notice: "Książka została zaktualizowana!"
    else
      @gatunki = Gatunek.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ksiazka.destroy
    redirect_to ksiazkas_path, notice: "Książka została usunięta."
  end

  private

  def set_ksiazka
    @ksiazka = Ksiazka.find(params[:id])
  end

  def ksiazka_params
    params.require(:ksiazka).permit(
      :tytul, :autor, :nazwa_serii, :jednotomowka, :strony, 
      :ocena, :format_ksiazki, :przeczytano_w, :dnf, 
      gatunek_ids: []
    )
  end
end