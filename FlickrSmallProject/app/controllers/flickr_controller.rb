class FlickrController < ApplicationController
  require 'flickraw'

  def search
    FlickRaw.api_key="ca351878db84a6065d181084a279c5a8"
    FlickRaw.shared_secret="bfac42d276231fd9"
    if params[:q].nil? || params[:q] ==""
      if params[:page].nil?
        @list = flickr.photos.getRecent(:per_page=>2,:page=>1)
      else
        @list = flickr.photos.getRecent(:per_page=>2,:page=>params[:page])
      end
    else
      if params[:page].nil?
        @list = flickr.photos.search(:text=>params[:q],:per_page=>2,:page=>1)
      else  
        @list = flickr.photos.search(:text=>params[:q],:per_page=>2,:page=>params[:page])
      end
    end
    @elements = Array.new
    @list.each do |result|
      info = flickr.photos.getInfo :photo_id => result.id, :secret => result.secret
      flick = Flickr.new
      flick.title = info.title
      flick.url =  FlickRaw.url_m(info)
      flick.tags = info.tags.map {|t| t.raw}
      @elements << flick
    end
    respond_to do |format|
      format.json { render :json => @elements.to_json, :content_type => "application/json"}
    end
  end
end
