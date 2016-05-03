get '/' do
  if logged_in?
    redirect to '/home'
 else
    erb :'session/login'
  end
end

get '/make_friend/:friend_id' do
  @friend = User.find(params[:friend_id])
  erb :'static/make_friend'
end