jitter
======


Julia module for interfacing with the Twitter streaming API, posting tweets, reading tweets, or watching your friends tweet in real time.

--

Version 1: Currently in development

--

To use this module in its current version, the user must have Python installed and have a registered [Twitter API](http://dev.twitter.com) account. Once registered, create a new "Twitter Application" and input your application's 'API key', 'API secret', 'Access token', and 'Access token secret' by running

    jitter.start()

and following the prompt, or executing

    jitter.start("<API key>","<API secret>","<Access token>", "<Access token secret>")

--
Current dependencies
*Python
	-Twython
*Julia
	-PyCall

