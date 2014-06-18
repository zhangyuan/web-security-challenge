get '/administrator/signin' do
  erb :admin_login
end

post '/administrator/signin' do
  username = params[:username]
  password = params[:password]

  if (username.eql?("admin") && password.eql?("1qaz!QAZ"))
    session[:admin_auth_status] = true
    redirect '/administrator/center'
  else
    redirect '/administrator/signin'
  end
end

get '/administrator/center' do
  redirect '/administrator/signin' if session[:admin_auth_status].nil?

  session[:token_2] = (generate_token CHALLENGE_2) if session[:token_2].nil?

  erb :admin_dashboard
end

get '/administrator/signout' do
  session[:admin_auth_status] = nil
  session[:token_2] = nil

  redirect '/administrator/signin'
end