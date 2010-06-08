require 'json'
require 'net/http'

module Geocode
  URL = 'http://maps.google.com/maps/api/geocode/json' unless const_defined?('URL')

  def state(lat, lng)
    url = "#{URL}?latlng=#{lat},#{lng}&sensor=false"
    response = Net::HTTP.get_response(URI.parse(url))

    case response
    when Net::HTTPSuccess
      result = JSON.parse(response.body)
    else
      return nil
    end

    return nil if result['status'] != 'OK'

    addresses = result['results'] && result['results'].first && result['results'].first['address_components']
    return nil unless addresses

    state = addresses.find { |val| val['types'] && val['types'].respond_to?(:first) && val['types'].first == 'administrative_area_level_1' }

    return state['short_name'] if state
  rescue Timeout::Error => error
    return nil
  end

end
