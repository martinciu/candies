require 'spec_helper'

describe Candies::Helper do

  class View
    include Candies::Helper
  end
  
  Candies.url = "http://example.com"

  before do
    @view = View.new
    @args = mock()
    @args.stubs(:to_query).returns("a=10&c=foo")
  end 
  
  describe "#candies_image_tag" do
    it "call image_tag with tracker param" do
      @args.expects(:fetch).with(:tracker).returns("custom")
      @view.expects(:image_tag).with("http://example.com/custom.gif?a=10&c=foo", :alt => "", :width => 1, :height => 1)
      @view.candies_image_tag(@args)
    end

  end
end