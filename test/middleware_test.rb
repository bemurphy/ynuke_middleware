require_relative "../lib/ynuke_middleware"
require "rack/test"
require "minitest/unit"
require "minitest/autorun"

class MiddlewareTestCase < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      use YnukeMiddleware
      run lambda { |env| [200, {'Content-Type' => "text/html"}, [env["PATH_INFO"]]]}
    end
  end
end

class MiddlewarePassthruCase < MiddlewareTestCase
  def test_passes_through
    get "/hello"
    assert_equal "/hello", last_response.body
    assert_equal "text/html", last_response.headers["Content-Type"]
    assert_equal "6", last_response.headers["Content-Length"]
    assert_equal 200, last_response.status
  end

  def test_passes_through_extensions
    get "/hello.html"
    assert_equal "/hello.html", last_response.body
    assert_equal "text/html", last_response.headers["Content-Type"]
    assert_equal "11", last_response.headers["Content-Length"]
    assert_equal 200, last_response.status
  end
end

class MiddlewareBlockingCase < MiddlewareTestCase
  def test_prevents_ruby_yaml_input
    post "/hello", {foo: "!ruby/object:OpenStruct"}
    assert_equal "Forbidden by middleware", last_response.body
    assert_equal 403, last_response.status
  end

  def test_permits_near_but_not_matching
    post "/hello", {foo: "!ruby hrm!"}
    assert_equal 200, last_response.status
    assert_equal "/hello", last_response.body
  end
end

class MiddlewareOptionsCase < MiddlewareTestCase
  def app
    Rack::Builder.new do
      use YnukeMiddleware, message: "Blocking test"
      run lambda { |env| [200, {'Content-Type' => "text/html"}, [env["PATH_INFO"]]]}
    end
  end

  def test_prevents_ruby_yaml_input
    post "/hello", {foo: "!ruby/object:OpenStruct"}
    assert_equal "Blocking test", last_response.body
    assert_equal 403, last_response.status
  end
end
