Jitter
======

Julia module for interfacing with the Twitter streaming API, posting tweets, reading tweets, or watching your friends tweet in real time. Jitter functions as a wrapper for the [twython](https://github.com/ryanmcgrath/twython) Python module. View the [twython](https://github.com/ryanmcgrath/twython) module's GitHub page for installation information and the [Python](https://www.python.org/) project's page for installation information. 

--

To use this module in its current version, the user must have Python as well as they [twython](https://github.com/ryanmcgrath/twython) module installed and have a registered [Twitter API](http://dev.twitter.com) account. Once registered, create a new "Twitter Application" and input your application's 'API key', 'API secret', 'Access token', and 'Access token secret' by running

    Jitter.start()

and following the prompts, or executing

    Jitter.start("<API key>","<API secret>","<Access token>", "<Access token secret>")

also, make sure your application is given read and write access in order for all features to work. Once an API connection has been made, the following example commands can be executed with ease. It should be noted that all tweets are pre-filtered to only include tweets from users who are registered with English as their primary language. 

### Commands

1. Watch your twitter timeline update in real time
 
    ```
    Jitter.live_timeline()
    ```
    
2. Send tweet

    ```
    Jitter.send_tweet("<tweet text>")
    ```
    
3. Get most recent 20 tweets from people the user follows on twitter. Returns them in an array of raw dictionaries

    ```
    Jitter.get_timeline()
    ```

4. Stream a given number of random public tweets from the internet. Returns Julia dictionary of tweets, time, and GPS coordinates (if available)

    ```
    Jitter.streamer(<integer number of tweets>) 
    ```

5. Stream a given number of random public tweets from the internet that are filtered by the given keyword. Returns Julia dictionary of tweets, time, and GPS coordinates (if available)

    ```
    Jitter.filter_streamer(<integer number of tweets>, "<keyword argument>") 
    ```
    
6. Stream a given number of random public tweets from the internet that are guaranteed to have GPS coordinates. Returns Julia dictionary of tweets and GPS coordinates

    ```
    Jitter.geo_streamer(<integer number of tweets>) 
    ```


##History
* Version 1.0 (2/21/14)
    * Notes
        * Streamer and get_timeline returns tweet(s) in raw form. Edit streamer.py to receive more than one tweet at a time
    * Dependencies
        * Julia
            * PyCall
        * Python
            * Twython
    * ~~TO DO~~
        * ~~Add a stripping function to strip raw tweets of information~~
        * ~~Add an argument to the streamer() function to have it return a given number of tweets~~
        * ~~Create a better organized data structure (on the Julia end) for receiving/manipulating tweets from all parts of the application~~

* Version 1.1 (3/10/14)
    * Notes
        * Works fairly well, all functions appear to be stable
    * Dependencies
        * Julia
            * PyCall
        * Python
            * Twython
    * TO DO
        * Select more tweet entities to return (or leave as option for user's needs)
        * ~~Add time to the return dictionary for the geo_streamer~~
        * ~~Condense stripper functions into one flexible function that handles all types of streaming~~
