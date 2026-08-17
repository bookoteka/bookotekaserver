gatunki = [
  "Science-fiction",
  "Fantastyka",
  "Przygodowa",
  "Komedia",
  "Kryminał",
  "Romans",
  "Obyczaj",
  "Inne"
]

gatunki.each do |nazwa_gatunku|
  Gatunek.find_or_create_by!(nazwa: nazwa_gatunku)
end