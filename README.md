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

Once an API connection has been made, the following commands can be executed with ease

1. Get most recent 20 tweets from people the user follows on twitter

    ```
    jitter.get_timeline()
    ```
    
2. Send tweet

    ```
    jitter.send_tweet("Tweeting from Jitter!!")
    ```
    
3. Watch your twitter timeline update in real time
 
    ```
    jitter.live_timeline()
    ```

4. Stream random tweets from the internet (still in development/ use at your own risk!)

    ```
    jitter.streamer() 
    ```


## Current dependencies
* Julia
  * PyCall
* Python
  * Twython


