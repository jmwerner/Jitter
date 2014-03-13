# jitter
# Julia module for Twitter integration
#############

module Jitter

using PyCall

@pyimport twython

user_info = [:api_key => "",:api_secret => "",:access_token => "",:access_secret => ""]


function start()
	print("Api key: ")
	user_info[:api_key] = chomp(readline())
	print("Api secret: ")
	user_info[:api_secret] = chomp(readline())
	print("Access token: ")
	user_info[:access_token] = chomp(readline())
	print("Access token secret: ")
	user_info[:access_secret] = chomp(readline())
	nothing
end


function start(access_token_in::String,access_secret_in::String, 
			   api_key_in::String, api_secret_in::String)
	user_info[:access_token] = access_token_in
	user_info[:access_secret] = access_secret_in
	user_info[:api_key] = api_key_in
	user_info[:api_secret] = api_secret_in
	nothing
end


function get_timeline()
	twitter_connection = twython.Twython(user_info[:access_token], user_info[:access_secret], user_info[:api_key], user_info[:api_secret])
	twitter_connection[:get_home_timeline]()
end


function send_tweet(tweet_text)
	twitter_connection = twython.Twython(user_info[:access_token], user_info[:access_secret], user_info[:api_key], user_info[:api_secret])
	twitter_connection[:update_status](status = tweet_text)
	"Tweet Sent!"
end


function live_timeline()
	command = `Python streamer.py user $(user_info[:access_token]) $(user_info[:access_secret]) $(user_info[:api_key]) $(user_info[:api_secret])`
	run(command)
	nothing
end


function filter_streamer(tweet_number::Int, keywords::String)
	command = `Python streamer.py streamfilter $(user_info[:access_token]) $(user_info[:access_secret]) $(user_info[:api_key]) $(user_info[:api_secret]) $tweet_number $keywords`
	rawtweet = readall(command)
	tweet_stripper(rawtweet, tweet_number)
end


function streamer(tweet_number::Int)
	command = `Python streamer.py stream $(user_info[:access_token]) $(user_info[:access_secret]) $(user_info[:api_key]) $(user_info[:api_secret]) $tweet_number`
	rawtweet = readall(command)
	tweet_stripper(rawtweet, tweet_number)
end


function geo_streamer(tweet_number::Int)
	command = `Python streamer.py geo $(user_info[:access_token]) $(user_info[:access_secret]) $(user_info[:api_key]) $(user_info[:api_secret]) $tweet_number`
	rawtweet = readall(command)
	tweet_stripper(rawtweet, tweet_number)
end


function filter_geo_streamer(tweet_number::Int, keywords::String)
	command = `Python streamer.py geofilter $(user_info[:access_token]) $(user_info[:access_secret]) $(user_info[:api_key]) $(user_info[:api_secret]) $tweet_number $keywords`
	rawtweet = readall(command)
	tweet_stripper(rawtweet, tweet_number)
end


function tweet_stripper(input::String, number::Int)
	posts = split(input, "\t\n")
	filter!(x->!isempty(x), posts)
	tweets = Array(String, 0)
	timestamp = Array(String, 0)
	geos = Array(Array{Float64, 1}, 0)
	for iter in posts
		twt  = split(iter, "\t")
		push!(tweets, twt[1])
		push!(timestamp, twt[2])
		geor = match(r"-?\d+\.?\d*,\s?-?\d+\.?\d*", twt[3])
		if geor != nothing
			push!(geos, geor.match |> x-> split(x, ',') |> float)
		else 
			push!(geos, [NaN, NaN])
		end
	end
	[:coordinates => geos, :time => timestamp, :tweet => tweets]
end


end # end jitter

