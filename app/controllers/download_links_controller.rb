class DownloadLinksController < ApplicationController

  def index
    @song = Mp3Zing::DownloadLink.get_by params[:song_url]
    respond_to do |format|
      format.html
      format.json
    end
  end
end
