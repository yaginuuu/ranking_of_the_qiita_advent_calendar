require './lib/qiita/ranking_of_advent_calendar_theme'
require './lib/chatwork'
require './lib/scraping'

require 'pp'

include Qiita

CHATWORK_TOKEN         = '#chatwork_token#'
CHATWORK_ROOM_ID       = '#chatwork_room_id#'
CALENDAR_PATH          = '# ex. /advent-calendar/2018/hamee#'
CHATWORK_MESSAGE_TITLE = '# ex. Hameeのアドベントカレンダーランキング#2018#'

advent_calendar_contents = ranking_in_advent_calendar_theme(CALENDAR_PATH)

chatwork = Chatwork::Client.new(CHATWORK_TOKEN)
contents = "総いいね数: #{advent_calendar_contents[:total_likes]}\n"

advent_calendar_contents[:articles].each do |article|
  contents += "[info]いいね数: #{article[:likes]}\n"
  contents += "#{article[:comment][:title]}  by#{article[:author][:name]}\n"
  contents += "#{Scraping.url_encode(article[:comment][:link])}[/info]"
end

message  = "[info][title]#{CHATWORK_MESSAGE_TITLE}[/title]#{contents}[/info]"

chatwork.post(CHATWORK_ROOM_ID, message)
