module Qiita
  class Qiita
    HOST = 'qiita.com'

    private

    def article_url(author: nil, item_id: nil)
      Addressable::URI.encode("#{url_prefix}/#{author}/items/#{item_id}")
    end

    def url_prefix
      "https://#{host}"
    end

    def host
      HOST
    end
  end
end
