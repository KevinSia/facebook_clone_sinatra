before '/users/*/edit' do
  check_authorization(params[:splat][0])
end

# show status feed (friend and current_user)
get '/home' do
  @statuses = current_user.feed
  # @error_message = params[:error_message]
  # params[:error_message] = nil
  erb :'user/homepage'
end

get '/users/index' do
  @users = User.all
  erb :'user/index'
end
# show current_user profile
get '/profile' do
  @user = current_user
  @statuses = @user.statuses
  erb :'user/profile'
end

# show a user's profile
get '/users/:id' do
  @user = User.find(params[:id])
  @statuses = @user.statuses
  erb :'user/profile'
end

# edit current_user
get '/users/:id/edit' do
  erb :'user/edit'
end

# update current user
post '/users/:id/edit' do
  @user = User.find(params[:id])
  @user.save_password(params[:password]) unless params[:password].empty?
  if @user.update(params[:user])
    redirect to '/profile'
  else
    @error_message = "Ops. Something went wrong. Might wanna check your input again"
    erb :'user/edit'
  end
end

