class Ksiazka < ApplicationRecord
  has_many :ksiazka_gatuneks, dependent: :destroy
  has_many :gatuneks, through: :ksiazka_gatuneks

  # Walidacje pól
  validates :tytul, presence: true
  validates :autor, presence: true
  validates :strony, presence: true, numericality: { greater_than: 0 }
  validates :ocena, presence: true
  validates :format_ksiazki, presence: true

  # Nazwa serii wymagana tylko gdy NIE JEST to jednotomówka
  validates :nazwa_serii, presence: true, unless: :jednotomowka?

  # Wymóg przynajmniej 1 gatunku
  validate :musi_posiadac_przynajmniej_jeden_gatunek

  before_validation :clear_nazwa_serii_if_jednotomowka

  # Funkcja zamiany nr miesiąca na słowo
  def zamien_miesiac_na_slowo
    case przeczytano_w&.month
    when 1
      "Styczeń"
    when 2
      "Luty"
    when 3
      "Marzec"
    when 4
      "Kwiecień"
    when 5
      "Maj"
    when 6
      "Czerwiec"
    when 7
      "Lipiec"
    when 8
      "Sierpień"
    when 9
      "Wrzesień"
    when 10
      "Październik"
    when 11
      "Listopad"
    when 12
      "Grudzień"
    else
      raise "Błąd alokacji miesiąca!"
    end
  end

  private

  def clear_nazwa_serii_if_jednotomowka
    self.nazwa_serii = nil if jednotomowka?
  end

  def musi_posiadac_przynajmniej_jeden_gatunek
    if gatunek_ids.reject(&:blank?).empty?
      errors.add(:base, "Musi być wybrany co najmniej jeden gatunek")
    end
  end
end