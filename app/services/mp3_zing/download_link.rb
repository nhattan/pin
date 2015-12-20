module Mp3Zing
  class DownloadLink
    def self.get_by url
      raise "URL is blank" if url.blank?
      uri = URI(url)
      song_id = extract_song_id(uri)
      song = get_song song_id
    end

    def self.get_song id
      url = "#{Settings.get_song_info_endpoint}?requestdata={\"id\":\"#{id}\"}"
      uri = URI(url)
      res = Net::HTTP.get_response(uri)
      song = JSON.parse res.body
    end

    def self.extract_song_id uri
      uri.path.split('/').last.split('.').first if uri.path.present?
    end
  end
end
