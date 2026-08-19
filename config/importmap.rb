# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "Chart.bundle", to: "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.js"
pin "chartkick", to: "https://ga.jspm.io/npm:chartkick@5.0.1/dist/chartkick.js"