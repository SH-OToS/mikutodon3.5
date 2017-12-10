def mstdn_fav(id, account) 
  toot = toot_test(id, account)

  if !(toot["body"] ["favourited"])
    uri = URI.parse("https://#{account[:host]}/api/v1/statuses/#{id}/favourite")
  else
    uri = URI.parse("https://#{account[:host]}/api/v1/statuses/#{id}/unfavourite")
  end

  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true

  req = Net::HTTP::Post.new(uri.request_uri)

  token = " Bearer " + account[:token]

  req["Authorization"] = token


  res = https.request(req)

  activity :system,  "#{res.code}\n#{res.message}"
end


def mstdn_reblog(id, account) 
  toot = toot_test(id, account)

  if !(toot["body"] ["reblogged"])
    uri = URI.parse("https://#{account[:host]}/api/v1/statuses/#{id}/reblog")
  else
    uri = URI.parse("https://#{account[:host]}/api/v1/statuses/#{id}/unreblog")
  end

  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true

  req = Net::HTTP::Post.new(uri.request_uri)

  token = " Bearer " + account[:token]

  req["Authorization"] = token


  res = https.request(req)

  activity :system,  "#{res.code}\n#{res.message}"
end

def toot_test(id, account)
  puts id
  uri = URI.parse("https://#{account[:host]}/api/v1/statuses/#{id}")
  token = " Bearer " + account[:token]

  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true

  req = Net::HTTP::Get.new(uri.path)
  req["Authorization"] = token

  res = https.request(req)

  return  ({'code' => res.code,
            'message' => res.message,
            'body' => JSON.parse(res.body)})

end