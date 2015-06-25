require 'json'
require 'sinatra'
require './config/environments'

before do
	content_type 'application/json'

	puts '[Params]'
  	p params
end

helpers do
	def request_headers
		env.inject({}){|acc, (k,v)| acc[k] = v; acc}
	end

	def protected!
		unless authorized?
			response['WWW-Authenticate'] = %(Basic realm="Restricted Area")

			throw(:halt, [401, "Not authorized\n"])
		end
	end

	def authorized?
		auth ||=  Rack::Auth::Basic::Request.new(request.env)

		auth.provided? && auth.basic? && auth.credentials
	end
end

get "/" do
	"Welcome To Sinatra Project Template!".to_json
end

get '/env' do
	protected!

	content_type 'text/plain'

	ENV.inspect
end
