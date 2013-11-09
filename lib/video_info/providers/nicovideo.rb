require "rexml/document"

class VideoInfo
  module Providers
    class Nicovideo < Provider

      def self.usable?(url)
        url =~ /(nicovideo\.jp)|(nico\.ms)/
      end

      def provider
        'Nicovideo'
      end

      def title
        _video_entry.elements['title'].text
      end

      %w[title description].each do |method|
        define_method(method) { _video_entry.elements["#{method}"].text }
      end

      %w[width height embed_url keywords].each do |method|
        define_method(method) { nil }
      end

      def duration
        str = _video_entry.elements['length'].text
        ary = str.split(':').map(&:to_i)
        (ary[0] * 60) + ary[1]
      end

      def date
        Time.parse(_video_entry.elements['first_retrieve'].text, Time.now.utc)
      end

      def thumbnail_small
        _video_entry.elements['thumbnail_url'].text
      end

      def thumbnail_medium
        "#{_video_entry.elements['thumbnail_url'].text}"
      end

      def thumbnail_large
        "#{_video_entry.elements['thumbnail_url'].text}"
      end

      def view_count
        _video_entry.elements['view_counter'].text.to_i
      end

      def embed_code
        %(<script type="text/javascript" src="http://ext.nicovideo.jp/thumb_watch/#{video_id}"></script><noscript><a href="http://www.nicovideo.jp/watch/#{video_id}">#{title}</a></noscript>)
      end

      private

      def _url_regex
        /(?:nicovideo\.jp\/watch\/(sm[\d]+)|nico\.ms\/(sm[\d]+))/
      end

      def _api_url
        "http://ext.nicovideo.jp/api/getthumbinfo/#{video_id}"
      end

      def _set_data_from_api
        uri = open(_api_url, options)
        REXML::Document.new(uri.read)
      end

      def _video_entry
        data.elements['nicovideo_thumb_response/thumb']
      end

    end
  end
end
