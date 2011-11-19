require 'spec_helper'

describe Candies::Server do
  include Rack::Test::Methods

  before do
    @redis = mock()
    Candies.stubs(:redis).returns(@redis)
  end

  def app
    @app ||= Candies::Server.new
  end

  it "get /t.json returns all records for t metric" do
    values = [:foo, :bar]
    @redis.expects(:get).with(:foo).returns("baz")
    @redis.expects(:get).with(:bar).returns("foo")

    @redis.expects(:keys).with("t*").returns(values)
    get '/t.json'
    last_response.status.must_equal 200
    last_response['Content-Type'].must_equal 'application/json'
  end

  it "get /t.gif?&id=foo returns records for id=foo" do
    values = [:foo, :bar]
    @redis.expects(:get).with(:foo).returns("baz")
    @redis.expects(:get).with(:bar).returns("foo")

    @redis.expects(:keys).with("t:foo*").returns(values)
    get '/t.json?&id=foo'
    last_response.status.must_equal 200
    last_response['Content-Type'].must_equal 'application/json'
  end

end