import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]

  przelacz(zdarzenie) {
    const nazwaZakladki = zdarzenie.currentTarget.dataset.zakladkaNazwa

    this.panelTargets.forEach(panel => panel.classList.add("hidden"))
    this.tabTargets.forEach(tab => {
      tab.classList.remove("bg-primary-600", "text-white")
      tab.classList.add("text-slate-700", "hover:bg-slate-100")
    })

    const wybranePole = this.panelTargets.find(panel => panel.dataset.zakladkaWybor === nazwaZakladki)
    if (wybranePole) {
      wybranePole.classList.remove("hidden")
    }

    zdarzenie.currentTarget.classList.remove("text-slate-700", "hover:bg-slate-100")
    zdarzenie.currentTarget.classList.add("bg-primary-600", "text-white")
  }
}