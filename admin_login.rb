get '/administrator/signin' do
  erb :admin_login
end

post '/administrator/signin' do
  username = params[:username]
  password = params[:password]

  if (username.eql?("admin") && password.eql?("1qaz!QAZ"))
    redirect '/administrator/center'
  else
    redirect '/administrator/signin'
  end
end

get '/administrator/center' do
  erb :admin_dashboard
end

get '/administrator/signout' do
  session[:admin_auth_status] = nil
  redirect '/administrator/signin'
end