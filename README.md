# BCC - Job Alerts

> A RedM Self contained job/role based alert/ping system for Vorp 

## Installation
1. Download this repo/codebase
2. Extract and place `bcc-alerts` into your `resources` folder
3. Add `ensure bcc-alerts` to your `server.cfg` file
4. Restart your server (unless you have nightly restarts)

## How-to-use

### Medic/Doctor
1. You die, type `/alertdoctor` into chat
2. All users with the roll `medic` get alerted and a 30 second map blip appears where `/alertdoctor` was called

### Police
1. You are getting held up! Oh no, type `/alertpolice` into chat
2. All users with the roll `police` get alerted and a 30 second map blip appears where `/alertpolice` was called

## How-to-configure
All configurations available in `/config.lua`


## Disclaimers and Credits
I utilized Roids-Dev's [twptp_policealert](https://github.com/Roids-Dev/twprp_policealert) codebase, but made it more self contained to that it can be used as-is. This codebase has not been touch in 2 years, so this was another main reason for me to make this new one.

## TODO
- Add better config variables
- Add configurable delay before alert shows.

 ## Dependency
 - Vorp Core
