return 
{
    {   category = 'motor',
        {   name = 'Engage',
            signal = 'sw motor engage'
        },
        {   name = 'Power',
            signal = 'sw motor power'
            -- do not power without engage!
        },
        {   name = 'Brake',
            signal = 'sw motor brake'
        },
    },
    {  category = 'Generator A',
        {   name = 'Engage',
            signal = 'sw generators A engage'
        },
        {   name = 'Connect',
            signal = 'sw generators A connect'
        },
    },
    {  category = 'Generator B',
        {   name = 'Engage',
            signal = 'sw generators B engage'
        },
        {   name = 'Connect',
            signal = 'sw generators B connect'
        },
    },
    {  category = 'Steam turbine',
        {   name = 'Engage',
            signal = 'sw steam turbine engage'
        },
        {   name = 'Enable',
            signal = 'sw steam turbine enable'
        },
    },
    {  category = 'Fuel Turbine',
        {   name = 'Engage',
            signal = 'sw fuel turbine engage'
        },
        {   name = 'Enable',
            signal = 'sw fuel turbine enable'
        },
    },
    {  category = 'Flywheels',
        {   name = 'Engage',
            signal = 'sw flywheels engage'
        },
    },
}
