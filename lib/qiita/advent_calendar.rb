require './lib/qiita/qiita'

module Qiita
  class AdventCalendar < Qiita

    def initialize(advent_calendar_url)
      @advent_calendar_url = advent_calendar_url
    end

    private

    def calendar_url
      url_prefix + @advent_calendar_url
    end
  end
end
