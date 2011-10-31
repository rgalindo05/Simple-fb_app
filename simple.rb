require 'sinatra'
require 'omniauth/oauth'

enable :sessions

APP_ID ="297634950265812"
APP_SECRET = "593723ab2113384998cb317c172018ac"



###
require 'sinatra'
require 'omniauth/oauth'

enable :sessions

#Here you have to put your own Application ID and Secret
APP_ID = "153304591365687"
APP_SECRET = "7a7663099ccb62f180d985ba1252a3e2"

use OmniAuth::Builder do
  provider :facebook, APP_ID, APP_SECRET, { :scope => 'email, status_update, publish_stream' }
end

get '/' do
    @articles = []
    @articles << {:title => 'Ok, I guess I gotta do something here!', :url => 'http://docs.heroku.com/rack'}
    @articles << {:title => 'Well I\'m still working on Toward0', :url => 'http://www.toward0.com/'}

    erb :index
end

get '/auth/facebook/callback' do
  session['fb_auth'] = request.env['omniauth.auth']
  session['fb_token'] = session['fb_auth']['credentials']['token']
  session['fb_error'] = nil
  redirect '/'
end

get '/auth/failure' do
  clear_session
  session['fb_error'] = 'In order to use this site you must allow us access to your Facebook data<br />'
  redirect '/'
end

get '/logout' do
  clear_session
  redirect '/'
end

def clear_session
  session['fb_auth'] = nil
  session['fb_token'] = nil
  session['fb_error'] = nil
end

