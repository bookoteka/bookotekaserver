Grover.configure do |config|
  config.options = {
    format: "A4",
    print_background: true,
    prefer_css_page_size: true,
    margin: {
      top: "12mm",
      bottom: "0px",
      left: "12mm",
      right: "12mm"
    },
    launch_args: [
      "--no-sandbox",
      "--disable-setuid-sandbox",
      "--disable-dev-shm-usage",
      "--disable-gpu"
    ]
  }
end
sciezka_globalnych_modulow = `npm root -g`.strip
ENV["NODE_PATH"] = sciezka_globalnych_modulow if sciezka_globalnych_modulow.present?