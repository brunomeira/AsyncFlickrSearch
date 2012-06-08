class FlickrController < ApplicationController
  require 'flickraw'

  def search
    FlickRaw.api_key="ca351878db84a6065d181084a279c5a8"
    FlickRaw.shared_secret="bfac42d276231fd9"
    
    if params[:q].nil? || params[:q] ==""
      @list = flickr.photos.getRecent(:per_page=>10,:page=>params[:page])
    else
      if params[:page].nil?
        @list = flickr.photos.search(:text=>params[:q],:per_page=>10,:page=>1)
      else
        @list = flickr.photos.search(:text=>params[:q],:per_page=>10,:page=>params[:page])
      end
    end
    @elements = Array.new
    @list.each do |result|
      info = flickr.photos.getInfo :photo_id => result.id, :secret => result.secret
      flick = Flickr.new
      flick.title = info.title
      flick.url =  FlickRaw.url_m(info)
      @elements << flick
    end
    respond_to do |format|
      format.json { render :json => @elements.to_json}
    end
  end
end
