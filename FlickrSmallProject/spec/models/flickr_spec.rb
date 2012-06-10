require 'spec_helper'

describe Flickr do
  before(:each) do
    @flickr = Flickr.new
  end

  describe "has attributes" do
    it "should has title attribute" do
      @flickr.should respond_to(:title)
    end

    it "should has url attribute" do
      @flickr.should respond_to(:url)
    end
    
     it "should has tags attribute" do
      @flickr.should respond_to(:tags)
    end
  end
end
