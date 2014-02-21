# Python streaming script heavily based on streaming example 
# from twython documentation https://github.com/ryanmcgrath/twython

from twython import TwythonStreamer
import sys



class MyStreamer(TwythonStreamer):
	def set_iterator(self, maximum_tweets):
		self.iterator=1
		self.max_tweets = maximum_tweets
	def on_success(self, data):
		if 'text' in data:
			print data
			self.iterator = self.iterator + 1
			if self.iterator > self.max_tweets:
				self.disconnect()
	def on_error(self, status_code, data):
		print status_code

        # Will stop on error
		self.disconnect()

#Command line argument check
#print sys.argv

#First command line argument (index 0) is name of script

stream = MyStreamer(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])
stream.set_iterator(1)
stream.statuses.filter(track='twitter')
