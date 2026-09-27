class UstawieniaController < ApplicationController
  def index
  end

  def eksport
    nazwa_pliku = "#{Rails.env}.sqlite3"
    
    sciezka_bazy = Rails.root.join("storage", nazwa_pliku)
    unless File.exist?(sciezka_bazy)
      sciezka_bazy = Rails.root.join("db", nazwa_pliku)
    end

    if File.exist?(sciezka_bazy)
      send_file sciezka_bazy,
                filename: "bookoteka_backup_#{Time.now.strftime('%Y%m%d_%H%M%S')}.sqlite3",
                type: "application/x-sqlite3",
                disposition: "attachment"
    else
      redirect_to ustawienia_path, alert: "Nie znaleziono pliku bazy danych."
    end
  end
end