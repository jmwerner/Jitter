# jitter
# Julia module for Twitter integration
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


function live_timeline()
	command = `Python streamer.py user $(user_info["access_token"]) $(user_info["access_secret"]) $(user_info["api_key"]) $(user_info["api_secret"])`
	run(command)
	nothing
end


function filter_streamer(tweet_number::Int, keywords::String)
	command = `Python streamer.py streamfilter $(user_info["access_token"]) $(user_info["access_secret"]) $(user_info["api_key"]) $(user_info["api_secret"]) $tweet_number $keywords`
	rawtweet = readall(command)
	plain_stripper(rawtweet, tweet_number)
end


function streamer(tweet_number::Int)
	command = `Python streamer.py stream $(user_info["access_token"]) $(user_info["access_secret"]) $(user_info["api_key"]) $(user_info["api_secret"]) $tweet_number`
	rawtweet = readall(command)
	plain_stripper(rawtweet, tweet_number)
end


function geo_streamer(tweet_number::Int)
	command = `Python streamer.py geo $(user_info["access_token"]) $(user_info["access_secret"]) $(user_info["api_key"]) $(user_info["api_secret"]) $tweet_number`
	rawtweet = readall(command)
	geo_stripper(rawtweet, tweet_number)
end


function geo_stripper(input::String, number::Int)
	array = split(input, "\t\n")
	array_in = array[!map(isempty,array)]
	
	split_array = map(x -> split(x, "\t"), array_in)

	tweets = [try split_array[k][2] end for k=1:number]
	geos = [try split_array[k][1] end for k=1:number]

	geos_stripped = map(float, map(x->split(match(r"-?\d+\.?\d*,\s?-?\d+\.?\d*", x).match, ","), geos))
	Dict({"coordinates","tweet"},{geos_stripped, tweets})
end


function plain_stripper(input::String, number::Int)
	array = split(input, "\t\n")
	array_in = array[!map(isempty,array)]
	list = map(x -> split(chomp(string(x)), "\t"), array_in)

	geos = [try list[k][3] end for k=1:number]
	geos_stripped = Array(Any,number)
	for i in 1:number
		if(!(geos[i] == "None "))
			geos_stripped[i] = map(float, split(match(r"-?\d+\.?\d*,\s?-?\d+\.?\d*", geos[i]).match, ","))
		else
			geos_stripped[i] = None
		end
	end

	times = [try list[k][2] end for k=1:number]
	tweets = [try list[k][1] end for k=1:number]

	Dict({"tweet", "time", "coordinates"}, {tweets, times, geos_stripped})
end



end # end jitter







