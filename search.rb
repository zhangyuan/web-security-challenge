
get '/product/search' do
  erb :search
end

post '/product/search' do
  if (valid_xss? params[:k])
    erb :search_xss
  else
    erb :search, :locals => {:k => params[:k]}
  end
end

XSS_PATTERN = /^.*"\s*\/>\s*<\s*script\s*>.*<\/script\s*>.*$/

def valid_xss? k
  return false if k.nil?

  match_result = k.downcase.scan(XSS_PATTERN)
  return !match_result.empty?
end