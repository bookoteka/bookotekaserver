class Gatunek < ApplicationRecord
  has_many :ksiazka_gatuneks, dependent: :destroy
  has_many :ksiazkas, through: :ksiazka_gatuneks

  validates :nazwa, presence: true, uniqueness: true
end