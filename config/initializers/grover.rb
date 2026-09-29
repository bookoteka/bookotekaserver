Grover.configure do |config|
  config.options = {
    executable_path: ENV.fetch("GROVER_CHROMIUM_PATH", "/usr/bin/chromium"),
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