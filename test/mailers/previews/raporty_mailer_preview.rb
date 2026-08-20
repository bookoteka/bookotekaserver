class RaportyMailerPreview < ActionMailer::Preview
  def wyslij_maila
    RaportyMailer.wyslij_maila(
      "test@example.com",
      "miesięczne",
      "podsumowanie_sierpien_2026.pdf",
      "Sztuczna treść załącznika do testów"
    )
  end
end