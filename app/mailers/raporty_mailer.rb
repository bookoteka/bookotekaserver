class RaportyMailer < ApplicationMailer
    default from: "System Czytelniczy <#{ENV['GMAIL_EMAIL']}>"
    def wyslij_maila(odbiorca, typ_raportu, nazwa_pliku, dane_pliku)
        attachments[nazwa_pliku] = dane_pliku
        @typ_raportu = typ_raportu
        @nazwa_pliku = nazwa_pliku

        mail(
            to: odbiorca,
            subject: "Podsumowanie #{@typ_raportu} - #{@nazwa_pliku}"
        )
    end
end
