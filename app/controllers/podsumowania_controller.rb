class PodsumowaniaController < ApplicationController
  SLOWNIK_MIESIECY = {
    1 => "Styczeń", 2 => "Luty", 3 => "Marzec", 4 => "Kwiecień",
    5 => "Maj", 6 => "Czerwiec", 7 => "Lipiec", 8 => "Sierpień",
    9 => "Wrzesień", 10 => "Październik", 11 => "Listopad", 12 => "Grudzień"
  }.freeze

  def index
    sciezki = Dir.glob(Rails.root.join("storage", "raporty", "*.pdf"))
    @pliki = sciezki.map { |sciezka| File.basename(sciezka) }.sort
  end

  def new
    @typ = params[:typ] || "miesieczne"
  end

  def create
    typ = params[:typ]
    rok = params[:rok].to_i
    miesiac = params[:miesiac].to_i

    if typ == "roczne"
      przygotuj_dane_roczne(rok)
      html_zawartosc = render_to_string(template: "podsumowania/szablony/rok", layout: false)
      nazwa_pliku = "#{rok}.pdf"
    else
      przygotuj_dane_miesieczne(rok, miesiac)
      html_zawartosc = render_to_string(template: "podsumowania/szablony/miesiac", layout: false)
      nazwa_miesiaca = SLOWNIK_MIESIECY[miesiac]
      nazwa_pliku = "#{nazwa_miesiaca} #{rok}.pdf"
    end

    katalog_raportow = Rails.root.join("storage", "raporty")
    FileUtils.mkdir_p(katalog_raportow)
    sciezka_zapisu = katalog_raportow.join(nazwa_pliku)

    html_zawartosc = html_zawartosc.force_encoding("UTF-8")
    zawartosc_pdf = Grover.new(html_zawartosc).to_pdf

    File.binwrite(sciezka_zapisu, zawartosc_pdf)

    redirect_to podsumowanie_index_path, notice: "Wygenerowano raport: #{nazwa_pliku}"
  end

  def show
    nazwa_pliku = "#{params[:id]}.pdf"
    @sciezka_pliku = Rails.root.join("storage", "raporty", nazwa_pliku)

    unless File.exist?(@sciezka_pliku)
      redirect_to podsumowania_path, alert: "Nie znaleziono wskazanego raportu."
    end
  end

  def pobierz
    nazwa_pliku = "#{params[:nazwa]}.pdf"
    sciezka = Rails.root.join("storage", "raporty", nazwa_pliku)

    if File.exist?(sciezka)
      send_file sciezka, type: "application/pdf", disposition: "attachment"
    else
      redirect_to podsumowania_path, alert: "Plik nie istnieje."
    end
  end

  def plik
    nazwa_pliku = "#{params[:id]}.pdf"
    sciezka = Rails.root.join("storage", "raporty", nazwa_pliku)

    if File.exist?(sciezka)
      send_file sciezka, type: "application/pdf", disposition: "inline"
    else
      head :not_found
    end
  end

  def wyslij_email
    nazwa_pliku = "#{params[:nazwa]}.pdf"
    sciezka_do_pliku = Rails.root.join('storage', 'raporty', nazwa_pliku)

    if File.exist?(sciezka_do_pliku)
      dane_pliku = File.read(sciezka_do_pliku)
      odbiorca = ENV['KACPER_EMAIL']

      RaportyMailer.wyslij_maila(
        odbiorca,
        "miesięczne",
        nazwa_pliku,
        dane_pliku
      ).deliver_now

      redirect_to podsumowanie_path(params[:nazwa]), notice: "E-mail z raportem został wysłany!"
    else
      redirect_to podsumowanie_path(params[:nazwa]), alert: "Nie znaleziono pliku raportu do wysyłki."
    end
  end

  private

  def przygotuj_dane_miesieczne(rok, miesiac)
    poczatek_miesiaca = Date.new(rok, miesiac, 1)
    koniec_miesiaca = poczatek_miesiaca.end_of_month

    @nazwa_miesiaca = SLOWNIK_MIESIECY[miesiac]
    @rok = rok

    ksiazki_query = Ksiazka.includes(:gatuneks).where(przeczytano_w: poczatek_miesiaca..koniec_miesiaca)
    czasopisma_query = Czasopismo.where(przeczytano_w: poczatek_miesiaca..koniec_miesiaca)

    @lacznie_ksiazek = ksiazki_query.count
    @lacznie_stron = ksiazki_query.sum(:strony) + czasopisma_query.sum(:strony)

    @rozklad_formatow = ksiazki_query.group(:format_ksiazki).count
    @rozklad_ocen = ksiazki_query.group(:ocena).count

    @statystyki_gatunkow = Gatunek.joins(:ksiazkas)
                                  .where(ksiazkas: { przeczytano_w: poczatek_miesiaca..koniec_miesiaca })
                                  .group("gatuneks.nazwa")
                                  .count

    @ksiazki = ksiazki_query.map do |k|
      {
        tytul: k.tytul,
        autor: k.autor,
        seria: k.nazwa_serii,
        format: k.format_ksiazki,
        ocena: k.ocena,
        gatunki: k.gatuneks.map(&:nazwa),
        strony: k.strony
      }
    end

    @czasopisma = czasopisma_query.map do |c|
      {
        nazwa: c.tytul,
        numer: c.numer_wydania,
        strony: c.strony
      }
    end
  end

  def przygotuj_dane_roczne(rok)
    poczatek_roku = Date.new(rok, 1, 1)
    koniec_roku = poczatek_roku.end_of_year

    @rok = rok

    ksiazki_query = Ksiazka.includes(:gatuneks).where(przeczytano_w: poczatek_roku..koniec_roku)
    czasopisma_query = Czasopismo.where(przeczytano_w: poczatek_roku..koniec_roku)

    @lacznie_ksiazek = ksiazki_query.count
    @lacznie_stron = ksiazki_query.sum(:strony) + czasopisma_query.sum(:strony)

    @rozklad_formatow = ksiazki_query.group(:format_ksiazki).count
    @rozklad_ocen = ksiazki_query.group(:ocena).count

    @statystyki_gatunkow = Gatunek.joins(:ksiazkas)
                                  .where(ksiazkas: { przeczytano_w: poczatek_roku..koniec_roku })
                                  .group("gatuneks.nazwa")
                                  .count

    @ksiazki = ksiazki_query.map do |k|
      {
        tytul: k.tytul,
        autor: k.autor,
        seria: k.nazwa_serii,
        format: k.format_ksiazki,
        ocena: k.ocena,
        gatunki: k.gatuneks.map(&:nazwa),
        miesiac: k.zamien_miesiac_na_slowo,
        strony: k.strony
      }
    end

    @czasopisma = czasopisma_query.map do |c|
      {
        nazwa: c.tytul,
        numer: c.numer_wydania,
        miesiac: c.zamien_miesiac_na_slowo,
        strony: c.strony
      }
    end
  end
end