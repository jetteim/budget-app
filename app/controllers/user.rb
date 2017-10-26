Backend::BudgetApp.controllers :user do
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  get :index, map: '/users' do
    @users = User.all.to_json(relationships: { user_profile: {} })
  end

  get :user, :with => :username do
    @user = User.get(:username => :username).to_json(relationships: { user_profile: {} })
  end
  
  post :index, :with => :id do
    @users = User.first_or_create(:username => :username).update(params)
  end

end
