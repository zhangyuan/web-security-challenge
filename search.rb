
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

XSS_PATTERN_1 = /^.*"\s*\/>\s*<\s*script\s*>.*<\/script\s*>.*$/
XSS_PATTERN_2 = /^[\w ]*"\s*on(click|mouseover)\s*=\s*"\s*alert\(.*\)\s*.*/

def valid_xss? k
  return false if k.nil?

  match_result_1 = k.downcase.scan(XSS_PATTERN_1)
  match_result_2 = k.downcase.scan(XSS_PATTERN_2)

  return !match_result_1.empty? || !match_result_2.empty?
end