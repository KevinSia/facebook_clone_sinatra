# show a particular status
get '/statuses/:id' do
  @status = Status.find(params[:id])
  check_friendship(@status)
  erb :'status/show'
end

# create new status
post '/statuses/new' do
  @status = current_user.statuses.build(params[:status])
  unless @status.save
    # not working
    redirect to "/home?error=1"
  end
  redirect to '/home'
end

# edit page
get '/statuses/:id/edit' do
  @status = Status.find(params[:id])
  erb :'status/edit'
end

post '/statuses/:id' do
  @status = Status.find(params[:id])
  if @status.update(params[:status])
    redirect to "/statuses/#{params[:id]}"
  else
    @error_message = "Something went wrong :( . Might wanna check your input"
    erb :'status/edit'
  end
end

get '/statuses/:id/delete' do
  @status = Status.find(params[:id])
  @status.destroy if @status
  redirect '/home'
end