require 'nokogiri'
require 'open-uri'
require 'addressable/uri'
require 'pp'

class Scraping
  def initialize(url: nil)
    set_url(url: url)
  end

  def document(charset: nil)
    Nokogiri::HTML.parse(html, nil, charset)
  end

  def set_url(url: nil)
    @url = url
  end

  def self.url_parse(url)
    Addressable::URI.parse(url)
  end

  def self.url_encode(url)
    Addressable::URI.encode(url)
  end

  private

  def html
    open(@url) { |file| open_params(file) }
  end

  def open_params(file)
    charset = file.charset
    file.read
  end
end
