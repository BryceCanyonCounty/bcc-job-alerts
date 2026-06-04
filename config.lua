Config = {}
Config.Alerts = {
    {
        name = 'police', --The name of the alert
        command = 'alertpolice', -- the command, this is what players will use with /
        message = "Crime Reported!", -- Message to show to theh police
        alerterTitle = "Police Alert!", -- Notification-Title to show players they have alerted
        alerterNotification = "You have reported a crime!", -- Message to show players they have alerted
        messageTime = 40000, -- Time the message will stay on screen (miliseconds)
        jobs = {"police", "sheriff"}, -- Job the alert is for
        jobgrade =
        {
           police = {0,1,2,3},
           sheriff = {0,1,2,3},
        }, -- What grades the alert will effect
        icon = "star", -- The icon the alert will use
        color = 'COLOR_WHITE', -- The color of the icon / https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/colours
        texturedict = "generic_textures", --https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/textures/menu_textures
        hash = -1282792512, -- The radius blip
        radius = 40.0, -- The size of the radius blip
        blipTime = 60000, -- How long the blip will stay for the job (miliseconds)
        blipDelay = 5000, -- Delay time before the job is notified (miliseconds)
        originText = "Hang tight, the Sheriffs has been notified", -- Text displayed to the user who enacted the command
        originTime = 40000 --The time the origintext displays (miliseconds)
    },
    {
        name = 'medic',
        command = 'alertdoctor',
        message = "Injury Reported!",
        alerterTitle = "Medic Alert!", -- Notification-Title to show players they have alerted
        alerterNotification = "You have reported a Medical Issue!", -- Message to show players they have alerted
        messageTime = 40000,
        jobs = {"medic", "doctor"}, -- Job the alert is for
        jobgrade =
        {
           medic = {0,1,2,3},
           doctor = {0,1,2,3},
        }, -- What grades the alert will effect
        icon = "shield",
        color = 'COLOR_WHITE', -- The color of the icon / https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/colours
        texturedict = "generic_textures", --https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/textures/menu_textures
        hash = -1282792512,
        radius = 40.0,
        blipTime = 60000,
        blipDelay = 2000,
        originText = "Doctors have been notified",
        originTime = 40000,
    }
}
