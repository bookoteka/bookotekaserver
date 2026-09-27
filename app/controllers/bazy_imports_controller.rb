class BazyImportsController < ApplicationController
  def create
    plik = params[:baza_plik]

    if plik.blank?
      redirect_to ustawienia_path, alert: "Proszę wybrać plik bazy danych."
      return
    end

    sciezka_bazy = Rails.root.join("storage", "#{Rails.env}.sqlite3")

    begin
      ActiveRecord::Base.connection_pool.disconnect!

      wal_file = Rails.root.join("storage", "#{Rails.env}.sqlite3-wal")
      shm_file = Rails.root.join("storage", "#{Rails.env}.sqlite3-shm")
      File.delete(wal_file) if File.exist?(wal_file)
      File.delete(shm_file) if File.exist?(shm_file)

      FileUtils.cp(plik.tempfile.path, sciezka_bazy)

      ActiveRecord::Base.establish_connection

      redirect_to ustawienia_path, notice: "Baza danych została pomyślnie zaimportowana!"
    rescue StandardError => e
      ActiveRecord::Base.establish_connection
      redirect_to ustawienia_path, alert: "Błąd podczas importu bazy: #{e.message}"
    end
  end
end