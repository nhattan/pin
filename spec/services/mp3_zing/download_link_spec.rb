require "rails_helper"

RSpec.describe Mp3Zing::DownloadLink do
  describe ".extract_song_id" do
    it do
      uri = URI('http://mp3.zing.vn/bai-hat/Vo-Nguoi-Ta-Phan-Manh-Quynh/ZW7WBZBI.html')
      expect(Mp3Zing::DownloadLink.extract_song_id(uri)).to eq 'ZW7WBZBI'
    end
    it do
      uri = URI('http://mp3.zing.vn/bai-hat/Hello-Adele/ZW7WFWF8.html')
      expect(Mp3Zing::DownloadLink.extract_song_id(uri)).to eq 'ZW7WFWF8'
    end
  end

  describe ".get_song" do
    it do
      id = 'ZW7WBZBI'
      res = Mp3Zing::DownloadLink.get_song(id)
      expect(res).to be_kind_of Hash
      expect(res['response']['msgCode']).to eq 1
    end
    it do
      id = 'ZW7WFWF8'
      res = Mp3Zing::DownloadLink.get_song(id)
      expect(res).to be_kind_of Hash
      expect(res['response']['msgCode']).to eq 1
    end
    it do
      id = 'incorrect-id'
      res = Mp3Zing::DownloadLink.get_song(id)
      expect(res).to be_kind_of Hash
      expect(res['response']['is_error']).to eq true
    end
  end

  describe ".get_by" do
    it do
      url = 'http://mp3.zing.vn/album/Bang-Xep-Hang-Bai-Hat-Viet-Nam-Tuan-50-2015/ZWZCW0B0.html?st=5'
      res = Mp3Zing::DownloadLink.get_by(url)
      expect(res).to be_kind_of Hash
      expect(res['response']['msgCode']).to eq 1
    end
    it do
      url = 'http://mp3.zing.vn/bai-hat/Vo-Nguoi-Ta-Phan-Manh-Quynh/ZW7WBZBI.html'
      res = Mp3Zing::DownloadLink.get_by(url)
      expect(res).to be_kind_of Hash
      expect(res['response']['msgCode']).to eq 1
    end
    it do
      url = 'http://mp3.zing.vn/bai-hat/Hello-Adele/ZW7WFWF8.html'
      res = Mp3Zing::DownloadLink.get_by(url)
      expect(res).to be_kind_of Hash
      expect(res['response']['msgCode']).to eq 1
    end
    it do
      url = 'http://mp3.zing.vn/bai-hat/Hello-Adele/incorrect-id.html'
      res = Mp3Zing::DownloadLink.get_by(url)
      expect(res).to be_kind_of Hash
      expect(res['response']['is_error']).to eq true
    end
    it do
      url = 'http://mp3.zing.vn/bai-hat'
      res = Mp3Zing::DownloadLink.get_by(url)
      expect(res).to be_kind_of Hash
      expect(res['response']['is_error']).to eq true
    end
    it do
      url = 'http://mp3.zing.vn'
      res = Mp3Zing::DownloadLink.get_by(url)
      expect(res).to be_kind_of Hash
      expect(res['response']['msgCode']).to eq 1
      expect(res['numFound']).to eq 0
    end
    it do
      url = 'incorrect-url'
      res = Mp3Zing::DownloadLink.get_by(url)
      expect(res).to be_kind_of Hash
      expect(res['response']['is_error']).to eq true
    end
  end
end
