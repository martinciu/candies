require 'spec_helper'

describe Candies::Server::Gif do
  include Rack::Test::Methods

  before do
    @redis = mock()
    Candies.stubs(:redis).returns(@redis)
  end

  after(:each) do
    Timecop.return
  end

  def app
    @app ||= Candies::Server.new
  end

  it "get /t.gif?id=info@example.com&foo=bar adds record" do
    now = Time.now
    Timecop.freeze(now)
    @redis.expects(:set).with(["t", "info@example.com", now.iso8601].join(":"), {:foo => "bar"}.to_json)
    get '/t.gif?id=info@example.com&foo=bar'
    last_response.status.must_equal 200
    last_response['Content-Type'].must_equal 'image/gif'
  end

  it "get /t.gif?&foo=bar is ignored" do
    now = Time.now
    Timecop.freeze(now)
    @redis.expects(:set).never
    get '/t.gif?&foo=bar'
    last_response.status.must_equal 200
    last_response['Content-Type'].must_equal 'image/gif'
  end

  it "get /t.gif?id=info@example.com adds record with empty payload" do
    now = Time.now
    Timecop.freeze(now)
    @redis.expects(:set).with(["tracker", "info@example.com", now.iso8601].join(":"), {}.to_json)
    get '/tracker.gif?id=info@example.com'
    last_response.status.must_equal 200
    last_response['Content-Type'].must_equal 'image/gif'
  end

end