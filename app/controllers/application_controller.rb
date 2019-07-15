class ApplicationController < Sinatra::Base
  require 'securerandom'

  register Sinatra::ActiveRecordExtension

  configure do
  	set :views, "app/views"
    set :public_dir, "public"
    #enables sessions as per Sinatra's docs. Session_secret is meant to encript the session id so that users cannot create a fake session_id to hack into your site without logging in. 
    enable :sessions
    set :session_secret, "secret"
  end

  # Renders the home or index page
  get '/' do
    @urls = Urls.all
    erb :home
  end

  post '/shorten' do
    Urls.create(link: params["link"], short: SecureRandom.urlsafe_base64(7))
    redirect '/'
  end

  get '/:short' do
    redirect Urls.find_by(short: params[:short]).link
  end

end
