class UstawieniaController < ApplicationController
  def index
  end

  def eksport
    nazwa_pliku = "#{Rails.env}.sqlite3"
    sciezka_bazy = Rails.root.join("db", nazwa_pliku)

    if File.exist?(sciezka_bazy)
      send_file sciezka_bazy,
                filename: nazwa_pliku,
                type: "application/octet-stream",
                disposition: "attachment"
    else
      redirect_to ustawienia_path, alert: "Nie znaleziono pliku bazy danych."
    end
  end
end