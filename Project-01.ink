/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/


VAR health = 5
VAR friend_name = ""
VAR weapons = 0
VAR bat_strength = 0
VAR knife_strength = 0
VAR gun_strength = 0
VAR weapon_type = ""
VAR keys = 0
VAR bravery = 0
VAR money = 0
VAR time = 0 // 0 Morning, 1 Noon, 2 Night


-> memory

== memory == 
As you stand in front of the school, you wish your best friend was with you now. The abandoned school might be less scary then. What is your best friend's name?

*[Lilah] 
~ friend_name = "Lilah"
-> school_entrance
*[Dex]
~ friend_name = "Dex"
-> school_entrance
*[Moxxie]
~ friend_name = "Moxxie"
-> school_entrance

-> school_entrance

== function advance_time == 
    ~ time = time + 1
    
    { 
        - time > 2:
            ~time = 0
    }
     
    {
    - time == 0:
            ~ return "Morning"
        - time == 1:
            ~ return "Noon"
        - time == 2:
            ~ return "Night"
    }
    
    ~return time




== school_entrance ==
You are at the entrance to an abandoned school. {not key_pickup:There is a key on the floor.} You also have a phone with a flashlight. The school has hallways that extends to the north, south, east and west.{keys ==0:You also have the choice to go back home before its too late... }

It is {advance_time()}
If only {friend_name} was here...

You have {keys} keys
{keys == 1: Since you have 1 key, you can now unlock the east hallway door!}
{keys == 2: Since you have 2 keys, you can now unlock the north hallway door!}
{keys == 3: Since you have 3 keys, you can now unlock the south hallway door!}
{keys == 4: Since you have 4 keys, you can now unlock the west hallway door!}
{keys == 5: Since you have 5 keys, you can now unlock the gym doors!}
+[Take the east hallway] -> east_hallway
+[Take the west hallway] -> west_hallway
+[Take the north hallway] -> north_hallway
+[Take the south hallway] -> south_hallway
*{keys == 0}[Go home] -> home
+{keys ==5} [Go to the gym] -> gym_entrance
*[Pick up the key] -> key_pickup

== east_hallway ==
You are in the east hallway. It is very dark, you can't see anything.
+[Light hallway] -> east_hallway_lit
+ [Go Back] -> school_entrance
-> END

== west_hallway ==
You are in the west hallway. It is very dark, you can't see anything.
+[Light hallway] -> west_hallway_lit
+ [Go Back] -> school_entrance
-> END

== north_hallway ==
You are in the north hallway. It is very dark, you can't see anything.
+[Light hallway] -> north_hallway_lit
+ [Go Back] -> school_entrance
-> END

== south_hallway ==
You are in the south hallway.It is very dark, you can't see anything.
+[Light hallway] -> south_hallway_lit
+ [Go Back] -> school_entrance
-> END

==home==
You go back home and decided to go back to sleep!!!
-> END

=== key_pickup ===
~ keys = keys + 1
You now have a key. May it open locked doors!
+[Go Back] ->school_entrance
+{keys ==6} [Go back to gym entrace] -> gym_entrance
-> END

==east_hallway_lit ==
The light reveals a door. {not east_door_open: The door is locked.}
{not keys >=1:  You can't open this door. Maybe you need to find a key somewhere...}
+{keys >= 1} [Open door] -> east_door_open
+[Go Back] ->school_entrance



== east_door_open == 
The room reveals a bunch of dead bodies. {not key_pickup: There is also a key on the floor.}
{ friend_name == "Dex": Dex would have been so scared if they were here|}
+{keys ==1}[Pick up the key] -> key_pickup
+[Go Back] ->school_entrance
-> END


==west_hallway_lit ==
The light reveals a door. {not west_door_open: The door is locked.}
{not keys ==4:  You can't open this door. Maybe you need to find a key or key(s) somewhere...}
+{keys >= 4} [Open door] -> west_door_open
+[Go Back] ->school_entrance



== west_door_open == 
The room reveals a bunch of spiders.{not key_pickup:There is a key on the floor.} Do you go in?
{ friend_name == "Lilah": Man Lilah would have had an heart attack if they were here|}
*[Run] -> run
+{keys >=3}[Pick up the key] -> key_pickup
+[Go Back] ->school_entrance
-> END


==north_hallway_lit ==
The light reveals a door.{not north_door_open: The door is locked.} {not knife_pickup: There is also a knife on the floor.}
{keys !=2:  You can't open this door. Maybe you need to find another key or keys somewhere...}
+{keys == 2} [Open door] ->north_door_open
*[Pick up the knife] -> knife_pickup
+ [Go Back] -> school_entrance

== knife_pickup ==
~ weapons = weapons + 1
You now have a knife. May it protect you from whatever lurks in the dark..
+[Go Back] -> north_hallway_lit

==north_door_open ==
The room reveals a bunch of monsters!! What will you do?
+{weapons == 1} [attack]-> attack
*[Talk to them] -> talk_to_monsters
*[Run] -> run


== attack ==
~ weapons = weapons -1
You have {weapons} weapons left
~ bravery = bravery + 10
You have {bravery} bravery!
~ money = money + 100
You have $ {money} !

The monsters died from the knife! You survived the attack. {not key_pickup: You also found another key! Maybe this can open a locked door in one of the hallways..}
+{keys > 0}[Pick up the key] -> key_pickup
+[Go Back] ->school_entrance
-> END

== attack_gym ==
The monsters died from your fists! You survived the attack. 
You have {weapons} weapons left
~ bravery = bravery + 10
You have {bravery} bravery!
~ money = money + 50
You have $ {money} !
+[Go back to concession stand] -> concession_stand


==run==
~health = health - 1
The monsters attacked you and you lost some health. rip.
You have {health} health left
~ bravery = bravery - 10
You also lost 10 bravery.
You now have {bravery} bravery
+[Go Back to the school entrance] ->school_entrance

->END

== talk_to_monsters ==
You try talking to the monsters in hopes they would not hurt you. You were wrong and they still attacked you, but you did gain 10 bravery! 
~health = health - 1
~ bravery = bravery + 10
You have {health} health left
You now have {bravery} bravery
+[Go back] -> school_entrance

== south_hallway_lit ==
The light reveals a door. { keys !=3: The door is locked. Maybe you need to find another key or keys somewhere...}
*{keys == 3} [Open door] -> south_door_open
+[Go Back to the school entrance] ->school_entrance


== south_door_open ==
The door reveals {friend_name} ! why are they here...
{not knife_pickup2:There is also a knife on the ground.}
{friend_name} says they know a way out.. do you trust them? This choice will have major consequences!
*[Pick up the knife] -> knife_pickup2

//Major choice!
*[Yes] -> trust_friend
*[no] -> dont_trust_friend
->END

== knife_pickup2 ==
~ weapons = weapons + 1
You now have a knife. May it protect you from whatever lurks in the dark..
+[Go Back] -> south_door_open

== trust_friend ==
~health = health - 5
{friend_name} turned out to be a monster and attacked you and you were met with death. rip.
-> END

== dont_trust_friend == 
{friend_name} turned out to be a monster! What will you do?
*{weapons == 1} [attack]-> attack
*[Run] -> run
-> END

== gym_entrance ==
You are in the gym
+{time == 0} [go towards the sunlight] -> sunlight
+{time == 1} [go towards the sunlight] -> sunlight
+{time == 2} [go towards the moonlight] -> moonlight
+ [Go towards the concession stand] -> concession_stand
+{keys ==6} [Fight the final monster] -> Boss_fight
+[Go back] -> school_entrance

== sunlight ==
You stand under spot that has sun light. {not key_pickup: you see a key}
*[Pick up the key] -> key_pickup
+[Go back to gym entrace] -> gym_entrance
+[Go back to school entrance] -> school_entrance


== moonlight ==
*[Pick up the key] -> key_pickup
You stand under spot that has moon light. {not key_pickup: you see a key}
+[Go back to gym entrace] -> gym_entrance
+[Go back to school entrance] -> school_entrance

== concession_stand==
You have the opportunity to increase your bravery and buy/upgrade weapons! What would you like to do?
+{not gun_bought}[see gun] -> gun
+{not knife_bought}[see sharp knife] -> knife
+{not bat_bought}[see bat]-> bat
+[fight monster] -> attack_gym
+[Go back to gym entrance] ->gym_entrance

== gun ==
The gun costs $100, it also costs $100 to upgrade, what you like to do?
{not money >=100:  You can't buy the gun. Maybe you needed to fight monsters somewhere...}
+{money >= 100}[buy gun]-> gun_bought
+[go back to concession stand] -> concession_stand

== knife ==
The gun costs $50, it also costs $50 to upgrade, what you like to do?
{not money >=50:  You can't buy the knife. Maybe you needed to fight monsters somewhere...}
+{money >= 50}[buy knife] -> knife_bought
+[go back to concession stand] -> concession_stand

== bat ==
The bat costs $25, it also costs $25 to upgrade, what you like to do?
{not money >=25:  You can't buy the bat. Maybe you needed to fight monsters somewhere...}
+{money >= 25}[buy bat]-> bat_bought
+[go back to concession stand] -> concession_stand

== gun_bought ==
~ weapons = weapons + 1
~ weapon_type = "gun" 
You bought the gun! would you like to do with it?
+{money >= 100}[upgrade]-> gun_upgrade
{not money >=25:  You can't upgrade the bat. Maybe you needed to fight monsters somewhere...}
+[Go back to gym entrance] ->gym_entrance

== knife_bought ==
~ weapons = weapons + 1
~ weapon_type = "knife" 
You bought the knife! would you like to do with it?
+{money >= 50}[upgrade]->  knife_upgrade
{not money >=50:  You can't upgrade the knife. Maybe you needed to fight monsters somewhere...}
+[Go back to gym entrance] ->gym_entrance

== bat_bought ==
~ weapons = weapons + 1
~ weapon_type = "bat" 
You bought the bat! would you like to do with it?
+{money >= 25}[upgrade]->  bat_upgrade
{not money >=25:  You can't upgrade the bat. Maybe you needed to fight monsters somewhere...}
+[Go back to gym entrance] ->gym_entrance


== gun_upgrade ==
~ gun_strength = gun_strength + 8
Your gun gained {gun_strength} strength!
+[Go back to gym entrance] -> gym_entrance


== knife_upgrade ==
~ knife_strength = knife_strength + 5
Your knife gained {knife_strength} strength!
+[Go back to gym entrance] -> gym_entrance



== bat_upgrade ==
~ bat_strength = bat_strength + 2
Your bat gained {bat_strength} strength!
+[Go back to gym entrance] -> gym_entrance

==Boss_fight==
You have made it to the final battle. There is no turning back once you enter. What will you do?
+[Fight the boss] -> fight
+[Go back to gym entrance] ->gym_entrance

== fight == 
You are in front of a huge monster ! What will you do?
*{weapon_type == "gun"}[Attack with gun] -> monster_death
*{weapon_type == "knife"}[Attack with knife] -> monster_death
*{weapon_type == "bat"}[Attack with bat] -> monster_death
*{bravery >= 20}[Attack with fists] -> monster_death
*[Run] -> death
-> END

== monster_death ==
The monster died! You were able to escape the school!
->END

==death ==
You got scared and ran away, but you werent quick enough and the monster killed you !
-> END

