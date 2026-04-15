# frozen_string_literal: true

module Middleware
  class RequestLogger
    def initialize(app)
      @app = app
    end

    def call(env)
      start_time = Time.now
      status, headers, body = @app.call(env)
      duration = ((Time.now - start_time) * 1000).round(2)

      puts "[#{Time.now.strftime('%H:%M:%S')}] #{env['REQUEST_METHOD']} #{env['PATH_INFO']} — #{status} (#{duration}ms)"

      [status, headers, body]
    end
  end
end
