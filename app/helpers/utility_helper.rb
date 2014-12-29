module UtilityHelper
  def timeago(time, **options)
    options[:class] ||= 'timeago'
    content_tag(:abbr, time.to_s, options.merge(title: time.getutc.iso8601)) if time
  end

  def qrcode(data='', **options)
    # Google API: https://google-developers.appspot.com/chart/infographics/docs/qr_codes
    width = pop_value(:width, options, '200')
    output_encoding = pop_value(:output_encoding, options)
    error_correction_level = pop_value(:error_correction_level, options)
    margin = pop_value(:margin, options)

    qrcode_url = 'https://chart.googleapis.com/chart?cht=qr'
    qrcode_url += "&chl=#{data}"
    qrcode_url += "&chs=#{width}x#{width}"
    qrcode_url += "&choe=#{output_encoding}" unless output_encoding.nil?
    if error_correction_level.nil? or margin.nil?
      qrcode_url += %(&chld=#{error_correction_level}) unless error_correction_level.nil?
      qrcode_url += %(&chld=|#{margin}) unless margin.nil?
    else
      qrcode_url += %(&chld=#{error_correction_level}|#{margin})
    end
    image_tag(qrcode_url, alt: data)
  end
end
