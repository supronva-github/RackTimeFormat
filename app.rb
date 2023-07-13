# frozen_string_literal: true

require_relative 'time_format'

class App
  def call(env)
    request = Rack::Request.new(env)
    return not_found unless request.get? && request.path == '/time'

    time_format = TimeFormat.new(request.params['format']&.split(','))

    if time_format.unknown_formats.empty?
      response(body: time_format.formatted_time)
    else
      bad_request("Unknown time format [#{time_format.unknown_formats.join(',')}]")
    end
  end

  private

  def not_found
    response(status: 404)
  end

  def bad_request(body)
    response(status: 400, body: body)
  end

  def response(status: 200, headers: {}, body: [])
    response = Rack::Response.new(body, status, headers)
    response.finish
  end
end
