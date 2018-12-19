require 'pp'

require './lib/qiita/qiita'
require './lib/scraping'
require './lib/qiita/advent_calendar'

module Qiita
  class AdventCalendarScraping < AdventCalendar
    attr_reader :articles, :total_likes

    def initialize(advent_calendar_url)
      super

      @scraping    = Scraping.new(url: calendar_url)
      @articles    = []
      @total_likes = 0

      set_articles
    end

    def sort_articles
      @articles.sort_by { |article| article[:likes] }.reverse
    end

    private

    def set_articles
      calendar_date_path = '//*[@class="adventCalendarCalendar_day"]'

      @scraping.document.xpath(calendar_date_path).each do |node|
        begin
          author  = node.css(".adventCalendarCalendar_author")
          comment = node.css('.adventCalendarCalendar_comment')
          item_link = Scraping.url_parse(comment.css('a').first[:href])

          article = {
            author: { name: author.inner_text, link: author.css('a').first[:href] },
            comment: { title: comment.inner_text, link: item_link },
            item_id: item_link.path.split('/').last,
            likes: 0
          }

          @articles << article
        rescue
          next
        end
      end

      set_likes
    end

    def set_likes
      @articles.each do |article|
        next unless article[:comment][:link].host.include?(host)

        url = article_url(author: article[:author][:name], item_id: article[:item_id])
        @scraping.set_url(url: url)
        likes = @scraping.document.css('.it-Actions_likeCount').inner_text.to_i

        article[:likes] = likes
        @total_likes   += likes
      end
    end
  end
end
