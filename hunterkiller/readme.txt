The hunter-killer system

I believe this to be the most effective way to keep an area clear of enemies, in particular creepers, using opencomputers.
This is a substep for a computerized cattle farm.

The "hunter" detects and tracks the target, directing the "killer" onto it.
The killer leashes it, and the default mode of operation is to loft it so fall damage does the job. Alternatively it can signal for some other machinery (robot, wireless redstone activated contraption, etc) to take over after bringing it.

This system will use the motion sensor to detect enemies.
(The computronics radar could be a better choice, but is a no-go due to an infinite power draw bug.)

Network messages:

Hunter: 'target',x,y,z  -- target coordinates (+1y) relative to killer. 
Killer will go there, and when it arrives it will try to leash target.

Killer: 'captured'
At this point killer will do its routine, and then reset.

Killer: 'nothing'
I didn't catch anything, target probably moved on, need an update. At this point, hunter will know to hand out more target instructions.

Hunter: 'reset'
Lost track of target, killer should return to the starting position (usually near a charger)

Hunter: 'range', r
Directs the killer to sets its transmission range. This serves both to conserve power and to lessen how far the network traffic goes.

Killer: 'charging'
Killer has detected a low charge situation, meaning it has not gotten enough time in the reset position.

Hunter will wait for motion events, then pick a target. It will direct the killer drone to the target, then listen for more events. Targets of a different type will be ignored as will targets outside a given range of the previous detection. It will also keep track of where the killer has gone to. (Motion or summing the orders?) When it receives the 'nothing' message, it will then give the vector difference between the two targets, to send the drone chasing the target.



