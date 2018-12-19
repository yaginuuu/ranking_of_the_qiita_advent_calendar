require './lib/qiita/advent_calendar_scraping'
require 'pp'

module Qiita
  module_function

  def ranking_in_advent_calendar_theme(advent_calendar_url)
    advent_calendar_scraping = AdventCalendarScraping.new(advent_calendar_url)

    {
      articles: advent_calendar_scraping.sort_articles,
      total_likes: advent_calendar_scraping.total_likes
    }
  end
end
