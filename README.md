jitter
======

Julia module for interfacing with the Twitter streaming API, posting tweets, reading tweets, or watching your friends tweet in real time.

--

To use this module in its current version, the user must have Python as well as they Twython module installed and have a registered [Twitter API](http://dev.twitter.com) account. Once registered, create a new "Twitter Application" and input your application's 'API key', 'API secret', 'Access token', and 'Access token secret' by running

    jitter.start()

and following the prompts, or executing

    jitter.start("<API key>","<API secret>","<Access token>", "<Access token secret>")

also, make sure your application is given read and write access in order for all features to work. Once an API connection has been made, the following commands can be executed with ease:

1. Watch your twitter timeline update in real time
 
    ```
    jitter.live_timeline()
    ```
    
2. Send tweet

    ```
    jitter.send_tweet("Tweeting from jitter!!")
    ```
    
3. Get most recent 20 tweets from people the user follows on twitter

    ```
    jitter.get_timeline()
    ```

4. Stream random public tweets from the internet (still in development/ use at your own risk!)

    ```
    jitter.streamer() 
    ```

##History
* Version 1 (2/21/14)
    * Notes
        * Streamer and get_timeline returns tweet(s) in raw form. Edit streamer.py to receive more than one tweet at a time
    * Dependencies
        * Julia
            * PyCall
        * Python
            * Twython
    * TO DO
        * Add a stripping function to strip raw tweets of information
        * Add an argument to the streamer() function to have it return a given number of tweets
        * Create a better organized data structure (on the Julia end) for receiving/manipulating tweets from all parts of the application

