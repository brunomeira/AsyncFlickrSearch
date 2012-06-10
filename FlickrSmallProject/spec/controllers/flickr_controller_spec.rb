require 'spec_helper'

describe FlickrController do
  describe "GET 'search'" do
    it "should recognize this route" do
      {:get=>"search"}.should be_routable
    end

    it "returns success" do
      get 'search', :format => :json
      response.should be_success
    #response.header['Content-Type'].should include('application/json')
    end

    it "returns json type" do
      get 'search', :format => :json
      response.header['Content-Type'].should include('application/json')
    end

    describe "No Search" do
      before(:each) do
        get 'search',:page=>1, :format => :json
        @responseObject = JSON(response.body)
      end

      it "returns an Array" do
        @responseObject.class.should == [].class
      end

      it "returns an Array" do
        @responseObject.class.should == [].class
      end

      it "returns to 2 elements in the array" do
        @responseObject.length.should == 2
      end

      it "should has title and url for each objects" do
        @responseObject.each do |object|
          object.has_key?("title").should be_true
          object.has_key?("url").should be_true
        end
      end

      it "should returns a JSON object even if no params are passed" do
        get 'search', :format => :json
        responseObject = JSON(response.body)
        JSON(response.body).class.should == [].class
      end
    end

    describe "Search" do
      before(:each) do
        get 'search',:page=>1,:q=>"vase", :format => :json
        @responseObject = JSON(response.body)
      end

      it "returns an Array" do
        @responseObject.class.should == [].class
      end

      it "returns to 2 elements in the array" do
        @responseObject.length.should == 2
      end

      it "should has title and url for each objects" do
        @responseObject.each do |object|
          object.has_key?("title").should be_true
          object.has_key?("url").should be_true
        end
      end

      it "should has title which contains what was retrieved" do
        @responseObject.each do |object|
          object["title"].downcase.should include("vase")
        end
      end

      it "should returns a JSON object even if no param page was passed" do
        get 'search',:q=>"vase", :format => :json
        responseObject = JSON(response.body)
        JSON(response.body).class.should == [].class
      end
    end
  end
end
