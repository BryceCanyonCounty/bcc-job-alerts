# BCC - Job Alerts

> A RedM  job based alert/ping system for Vorp 

## Features
1. Commands that players can utilize to alerts a job + jobgrade
2. Police and Doctor preconfigured (/alertdoctor /alertpolice)
3. Alerts are fully customizable
    - Alert Icon
    - Message
    - Timinig
    - Delays
4. Custom Alerts are supported via the config!

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
All configurations available in `/config.lua`, including custom alerts!

## TODO
- Region support

 ## Dependency
 - Vorp Core
