# SpotXM

An app to pull the now-playing data from Sirius XM and provide Spotify links for the songs.  It uses a Postgres database with Sphinx for searching.

## Development Notes

Thinking Sphinx must be running when running the app in development. 

To start Thinking Sphinx:

    rake ts:start

To stop TS (obviously):

    rake ts:stop

## Outstanding Issues / To Dos

* The timestamp call is currently not working from Heroku (and occasionally from local).  Not sure why.  For better testing, create a test page for doing the timestamp to see what's coming back
* Links to Echo Nest?
