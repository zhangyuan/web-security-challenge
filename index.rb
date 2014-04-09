require 'sinatra'
require 'erubis'

require './injection'
require './admin_login'
require './search'

enable :sessions

set :bind, "0.0.0.0"

get '/' do
  erb :challenges
end

get '/customer/login' do
  erb :login
end

post '/customer/login' do
  if (injection_login?(params[:username], params[:password]))
    session[:message] = nil
    session[:auth_status] = "logged in"
    redirect "/customer/dashboard"
  else
    if (normal_login?(params[:username], params[:password]))
      session[:tom_auth_status] = "logged in"
      redirect "/customer/myProfile"
    else
      session[:message] = "Invalid username or password"
      redirect "/customer/login"
    end
  end
end

get '/customer/dashboard' do
  redirect '/customer/login' if session[:auth_status].nil?
  erb :dashboard
end

get '/customer/myProfile' do
  redirect '/customer/login' if session[:tom_auth_status].nil?
  erb :profile, :locals => {:name => "Tom Cat", :role => "Developer"}
end

post '/customer/myProfile' do
  if (!params[:uid].nil?) && (!params[:uid].eql?("47290"))
    erb :profile, :locals => {:success => true, :name => "Jerry", :role => "QA"}
  else
    erb :profile, :locals => {:message => "Profile refreshed at #{Time.now}", :name => "Tom Cat", :role => "Developer"}
  end
end

get '/customer/logout' do
  session[:auth_status] = nil
  session[:tom_auth_status] = nil

  redirect '/customer/login'
end

def normal_login? usr, pwd
  usr.eql?("tom") && pwd.eql?("cat")
end

not_found do
  'Oops, 404! Page Not Found'
end

error do
  'Sorry, an error was happen.'
end