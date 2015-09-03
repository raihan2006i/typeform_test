require 'httparty'

class Problem
  include HTTParty
  base_uri 'aerial-valor-93012.appspot.com'

  def self.challenge
    response = get('/challenge')
    json = JSON.parse(response.body)
    return json['token'], json['values']
  end

  def self.solve(debug = false)
    debug_output $stdout if debug
    token, values = challenge
    sum = values.inject(:+)
    response = get("/challenge/#{token}/#{sum}")
    json = JSON.parse(response.body)
    json['answer']
  rescue Exception => e
    e.message
  end
end
