# Python streaming script heavily based on streaming example 
# from twython documentation https://github.com/ryanmcgrath/twython

from twython import TwythonStreamer
import sys



class MyStreamer(TwythonStreamer):
	def on_success(self, data):
		if 'text' in data:
			print "##########\nTweet: ", data['text'].encode('utf-8'), "\n"
			print "Tweeter: ", data['user']['name'], "(", data['user']['screen_name'], ")\n"
			print "Time: ", data['created_at'], "\n##########\n\n"

	def on_error(self, status_code, data):
		print status_code

        # Will stop on error
		self.disconnect()

#Command line argument check
#print sys.argv

#First command line argument (index 0) is name of script

stream = MyStreamer(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])


stream.user()
