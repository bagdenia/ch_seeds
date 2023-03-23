require 'csv'
require 'digest'
require 'json'

CSV.open("./data/my_data.csv", "wb") do |csv|
  csv << ["client_id", "app_id", "session_id", "user_id", "method", "host", "path", "date_time", "status_code", "response_time", "user_ip", "custom_headers", "session_identifiers"]

  1_000_000.times do
    client_id = rand(1..1000)
    app_id = rand(1..1000)
    session_id = rand(1..1000)
    user_id = rand(1..1000)
    method = ['GET', 'POST', 'PUT', 'DELETE'].sample
    host = Digest::MD5.hexdigest(rand.to_s)[0..9] + '.com'
    path = '/' + Digest::MD5.hexdigest(rand.to_s)[0..9]
    date_time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
    status_code = rand(200..500).to_s
    response_time = rand(1..1000).to_s
    user_ip = (0..3).map { rand(256) }.join('.')
    custom_headers = "X-Header-#{rand(1..10)}: #{Digest::MD5.hexdigest(rand.to_s)[0..9]}"
    session_identifiers = (0..3).map { Digest::MD5.hexdigest(rand.to_s)[0..9] }.to_json

    csv << [client_id, app_id, session_id, user_id, method, host, path, date_time, status_code, response_time, user_ip, custom_headers, session_identifiers]
  end
end
