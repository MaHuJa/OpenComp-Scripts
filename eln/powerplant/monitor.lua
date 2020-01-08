return {
    {
        display = "Main Shaft",
        signalname = "CenterShaftRPS",
        unitname = "Rad/s",
        transform = function (value) return string.format("%.1f",value*1000) end,
    },
    {
        display = "Fuel Turbine Throttle",
        signalname = "GasTurbineSetting",
        unitname = '%',
        transform = function (value) return string.format("%.0f",value*100) end,
    },
    {
        display = "Steam Turbine Throttle",
        signalname = "SteamTurbineSetting",
        unitname = '%',
        transform = function (value) return string.format("%.0f",value*100) end,
    },
    {
        display = "Generator Line A Output",
        signalname = "Generators A output",
        unitname = 'W',
        transform = function (value) return string.format("%.0f",value*20000) end,
    },
    {
        display = "Generator Line B Output",
        signalname = "Generators A output",
        unitname = 'W',
        transform = function (value) return string.format("%.0f",value*20000) end,
    },
    
}
