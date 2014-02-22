# jitter
# Julia module for Twitter integration

# Version 1 using Twython Python library 

#############
module jitter

using PyCall

@pyimport twython

user_info = Dict({"api_key","api_secret","access_token", "access_secret"},{"","","",""})


function start()
	print("Api key: ")
	user_info["api_key"] = chomp(readline())
	print("Api secret: ")
	user_info["api_secret"] = chomp(readline())
	print("Access token: ")
	user_info["access_token"] = chomp(readline())
	print("Access token secret: ")
	user_info["access_secret"] = chomp(readline())
	nothing
end


function start(access_token_in::String,access_secret_in::String, 
			   api_key_in::String, api_secret_in::String)
	user_info["access_token"] = access_token_in
	user_info["access_secret"] = access_secret_in
	user_info["api_key"] = api_key_in
	user_info["api_secret"] = api_secret_in
	nothing
end


function get_timeline()
	twitter_connection = twython.Twython(user_info["access_token"], user_info["access_secret"], user_info["api_key"], user_info["api_secret"])
	twitter_connection[:get_home_timeline]()
end


function send_tweet(tweet_text)
	twitter_connection = twython.Twython(user_info["access_token"], user_info["access_secret"], user_info["api_key"], user_info["api_secret"])
	twitter_connection[:update_status](status = tweet_text)
	"Tweet Sent!"
end


function streamer()
	command = `Python streamer.py $(user_info["access_token"]) $(user_info["access_secret"]) $(user_info["api_key"]) $(user_info["api_secret"])`
	rawtweet = readall(command)
end


function live_timeline()
	command = `Python user_streamer.py $(user_info["access_token"]) $(user_info["access_secret"]) $(user_info["api_key"]) $(user_info["api_secret"])`
	run(command)
	nothing
end


end # end jitter







