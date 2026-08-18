class Czasopismo < ApplicationRecord
  validates :tytul, presence: true
  validates :numer_wydania, presence: true
  validates :strony, presence: true, numericality: { greater_than: 0 }

  def zamien_miesiac_na_slowo
    case przeczytano_w&.month
    when 1  then "Styczeń"
    when 2  then "Luty"
    when 3  then "Marzec"
    when 4  then "Kwiecień"
    when 5  then "Maj"
    when 6  then "Czerwiec"
    when 7  then "Lipiec"
    when 8  then "Sierpień"
    when 9  then "Wrzesień"
    when 10 then "Październik"
    when 11 then "Listopad"
    when 12 then "Grudzień"
    else raise "Błąd alokacji miesiąca!"
    end
  end
end