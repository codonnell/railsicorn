# README

## Description

Railsicorn is a difficulty estimator for [Torn](https://www.torn.com). It is meant to be used with the included userscript Tornicorn4.user.js and its public companion script [Profile Info](https://greasyfork.org/en/scripts/33347-profile-info). It exposes a `users` endpoint for users to register their API keys and a `players` endpoint where users can request the difficulties of a set of players.

## Deployment

Railsicorn set up to be deployed to Heroku. In order to deploy your own copy, you will need to login to Heroku with `heroku login`. To deploy, simply run `heroku create` followed by `git push heroku master`. The project is set up to send stats to New Relic; you will likely see some errors without the New Relic APM installed as a Heroku addon.
