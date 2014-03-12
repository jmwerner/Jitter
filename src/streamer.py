# Python streaming script heavily based on streaming example 
# from twython documentation https://github.com/ryanmcgrath/twython

from twython import TwythonStreamer
import sys


class MyGeoStreamer(TwythonStreamer):
	
	def set_iterator(self, maximum_tweets):
		self.iterator=1
		self.max_tweets = maximum_tweets

	def on_success(self, data):
		if 'geo' in data:
			if data['lang'] == "en":
				if data['geo']:
					print  data['geo'], "\t", data['text'].encode('utf-8'), "\t"
					self.iterator = self.iterator + 1
					if self.iterator > self.max_tweets:
						self.disconnect()
					
	def on_error(self, status_code, data):
		print status_code
		self.disconnect()

class MyGeoFilterStreamer(TwythonStreamer):
	
	def set_iterator(self, maximum_tweets):
		self.iterator=1
		self.max_tweets = maximum_tweets

	def on_success(self, data):
		if 'text' in data:
			if data['lang'] == "en":
				if data['geo']:

					print data['text'].encode('utf-8'), "\t", data['created_at'], "\t", data['geo'], "\t"

					self.iterator = self.iterator + 1
					if self.iterator > self.max_tweets:
						self.disconnect()
					
	def on_error(self, status_code, data):
		print status_code
		self.disconnect()


class MyStreamer(TwythonStreamer):
	
	def set_iterator(self, maximum_tweets):
		self.iterator=1
		self.max_tweets = maximum_tweets

	def on_success(self, data):
		if 'text' in data:
			if data['lang'] == "en":

				print data['text'].encode('utf-8'), "\t", data['created_at'], "\t", data['geo'], "\t"

				self.iterator = self.iterator + 1
				if self.iterator > self.max_tweets:
					self.disconnect()
					
	def on_error(self, status_code, data):
		print status_code
		self.disconnect()


class MyStreamer_user(TwythonStreamer):
	def on_success(self, data):
		if 'text' in data:
			print "##########\nTweet: ", data['text'].encode('utf-8'), "\n"
			print "Tweeter: ", data['user']['name'], "(", data['user']['screen_name'], ")\n"
			print "Time: ", data['created_at'], "\n##########\n\n"

	def on_error(self, status_code, data):
		print status_code
		self.disconnect()



if sys.argv[1] == "geo":
	geostream = MyGeoStreamer(sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])
	geostream.set_iterator(int(sys.argv[6]))
	#geostream.statuses.sample() #Worldwide random sampling
	geostream.statuses.filter(locations='-130,26,-60,50') #Rough USA coordinates
elif sys.argv[1] == "geofilter":
	gfstream = MyGeoFilterStreamer(sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])
	gfstream.set_iterator(int(sys.argv[6]))
	gfstream.statuses.filter(track=sys.argv[7]) #Worldwide
elif sys.argv[1] == "stream":
	stream = MyStreamer(sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])
	stream.set_iterator(int(sys.argv[6]))
	#stream.statuses.sample() #Worldwide random sampling
	stream.statuses.filter(locations='-130,26,-60,50')
elif sys.argv[1] == "streamfilter":
	stream = MyStreamer(sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])
	stream.set_iterator(int(sys.argv[6]))
	stream.statuses.filter(track=sys.argv[7]) #Worldwide
elif sys.argv[1] == "user":
	stream = MyStreamer_user(sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])
	stream.user()
