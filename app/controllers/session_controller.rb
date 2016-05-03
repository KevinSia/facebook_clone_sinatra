before do
  # non user accessible pages
  pages = %w(/login /signup /logout /)
  pass if logged_in? || pages.include?(request.path_info)
  redirect to '/login'
end

get '/login' do
  erb :'session/login'
end

post '/login' do
  @user = User.find_by(params[:user])
  if @user && @user.authenticate(params[:password])
    login @user
    redirect to '/'
  else
    @error_message = "Invalid email and password combination :( . Try again!"
    erb :'session/login'
  end
end

get '/signup' do
  erb :'session/signup'
end

post '/signup' do
  @user = User.new(params[:user])
  @user.save_password(params[:password])
  if @user.save
    login @user
    redirect to '/'
  else
    @error_message = "Ops. Something went wrong. Might wanna check your input again"
    erb :'session/signup'
  end
end

get '/logout' do
  logout
  erb :'session/login'
end