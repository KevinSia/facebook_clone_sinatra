get '/' do
  if logged_in?
    redirect to '/home'
 else
    erb :'session/login'
  end
end