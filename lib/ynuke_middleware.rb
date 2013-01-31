require "ynuke_middleware/version"

class YnukeMiddleware
  RED_FLAG = "!ruby/".freeze
  DEFAULT_MESSAGE = "Forbidden by middleware"

  def initialize(app, options = {})
    @app     = app
    @options = options
  end

  def call(env)
    self.dup._call(env)
  end

  def _call(env)
    if bad_yaml_attempt?(env)
      prevent_request
    else
      @app.call(env)
    end
  end

  private

  def bad_yaml_attempt?(env)
    req = Rack::Request.new(env)
    req.params.to_s.include? RED_FLAG
  end

  def prevent_request
    Rack::Response.new([], 403, {"Content-Type" => "text/plain"}).finish do |res|
      res.write(message)
    end
  end

  def message
    @options.fetch(:message, DEFAULT_MESSAGE)
  end
end
