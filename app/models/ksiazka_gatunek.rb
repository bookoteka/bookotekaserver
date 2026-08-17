class KsiazkaGatunek < ApplicationRecord
  belongs_to :ksiazka
  belongs_to :gatunek
end