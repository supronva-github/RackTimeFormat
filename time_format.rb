# frozen_string_literal: true

class TimeFormat
  FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(formats)
    @formats = formats || []
  end

  def valid_formats
    @formats.select { |format| FORMATS.include?(format) }
  end

  def unknown_formats
    @formats - FORMATS.keys
  end

  def formatted_time
    valid_formats.map { |format| Time.now.strftime(FORMATS[format]) }.join('-')
  end
end
