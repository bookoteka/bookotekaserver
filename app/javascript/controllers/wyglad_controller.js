import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["przycisk", "fajka"]

  connect() {
    const zapisanyId = localStorage.getItem("motyw_id") || "indigo"
    this.odswiezWybor(zapisanyId)
  }

  zmienKolor(event) {
    const przycisk = event.currentTarget
    const id = przycisk.dataset.kolorId
    const paleta = JSON.parse(przycisk.dataset.paleta)

    Object.keys(paleta).forEach(stopien => {
      document.documentElement.style.setProperty(`--p-${stopien}`, paleta[stopien])
    })

    localStorage.setItem("motyw_id", id)
    localStorage.setItem("motyw_paleta", JSON.stringify(paleta))

    this.odswiezWybor(id)
  }

  odswiezWybor(aktualnyId) {
    this.przyciskTargets.forEach((el, index) => {
      const jestWybrany = el.dataset.kolorId === aktualnyId
      const fajkaEl = this.fajkaTargets[index]

      if (jestWybrany) {
        el.classList.add("border-primary-600", "bg-primary-50/50", "ring-2", "ring-primary-600/30")
        el.classList.remove("border-slate-200", "bg-white")
        if (fajkaEl) fajkaEl.classList.remove("hidden")
      } else {
        el.classList.remove("border-primary-600", "bg-primary-50/50", "ring-2", "ring-primary-600/30")
        el.classList.add("border-slate-200", "bg-white")
        if (fajkaEl) fajkaEl.classList.add("hidden")
      }
    })
  }
}