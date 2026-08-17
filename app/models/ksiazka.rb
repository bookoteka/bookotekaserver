class Ksiazka < ApplicationRecord
  has_many :ksiazka_gatuneks, dependent: :destroy
  has_many :gatuneks, through: :ksiazka_gatuneks

  before_validation :clear_nazwa_serii_if_jednotomowka

  private

  def clear_nazwa_serii_if_jednotomowka
    self.nazwa_serii = nil if jednotomowka?
  end
end