require 'selenium-webdriver'
require 'nokogiri'
require 'pp'

WORKSPACE = ENV["WORKSPACE"]

ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36"

caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {binary: '/usr/bin/google-chrome-stable', args: ["--headless", "--disable-gpu", "--user-agent=#{ua}", "window-size=1280x800"]})
wd = Selenium::WebDriver.for :chrome, desired_capabilities: caps
wd.manage.timeouts.implicit_wait = 10

wd.get "https://www.google.co.jp"
wd.save_screenshot("#{WORKSPACE}/page.png")

wd.quit
