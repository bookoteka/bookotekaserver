import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]

  connect() {
    const urlParams = new URLSearchParams(window.location.search)
    const zakladkaZParametry = urlParams.get("zakladka")
    const zakladkaZHasha = window.location.hash.replace("#", "")

    const wybranaZakladka = zakladkaZParametry || zakladkaZHasha

    if (wybranaZakladka) {
      this.aktywujZakladke(wybranaZakladka)
    }
  }

  przelacz(zdarzenie) {
    const nazwaZakladki = zdarzenie.currentTarget.dataset.zakladkaNazwa
    this.aktywujZakladke(nazwaZakladki)
  }

  aktywujZakladke(nazwaZakladki) {
    const wybranyTab = this.tabTargets.find(tab => tab.dataset.zakladkaNazwa === nazwaZakladki)
    const wybranyPanel = this.panelTargets.find(panel => panel.dataset.zakladkaWybor === nazwaZakladki)

    if (!wybranyTab || !wybranyPanel) return

    this.panelTargets.forEach(panel => panel.classList.add("hidden"))
    this.tabTargets.forEach(tab => {
      tab.classList.remove("bg-primary-600", "text-white")
      tab.classList.add("text-slate-700", "hover:bg-slate-100")
    })

    wybranyPanel.classList.remove("hidden")
    wybranyTab.classList.remove("text-slate-700", "hover:bg-slate-100")
    wybranyTab.classList.add("bg-primary-600", "text-white")
  }
}