
include('augments.lua')


-- request_client_switch.lua (inside your plugin)
-- target_client = 1, 2, 3, etc.
function request_client_switch(target_client)
    local switch_file = windower.dir('data') .. 'client_switch.txt'
    local file = io.open(switch_file, 'w')
    if file then
        file:write(target_client)
        file:close()
    end
end

request_client_switch(2)

packets = require('packets')
function update_pet_tp(id,data) 
	
	  -- player_tp = packets.parse('incoming', data)["TP"]
	 --if player_tp ~= nil then
		
	--	if autoWS and player_tp > 999 then
	--	windower.send_command('lua c gearswap c autoWeaponSkill ')
	--	end+
	
	-- end
    if pet.status== "Engaged" and  (id == 0x068 or id == 0x067) then
	 pet_tp = packets.parse('incoming', data)["Pet TP"]
		if pet_tp ~= nil and pet_tp > 999  then	
		
			if sets.Pet.WS[pet.frame]  ~= nil then					
				windower.send_command('lua c gearswap equip sets.Pet.WS[\'' .. pet.frame.. '\']')
			elseif sets.Pet.WS  ~= nil then
				windower.send_command('lua c gearswap equip sets.Pet.WS')		
			end
			
		end
	end
	
end
currWS = "Victory Smite"
currTP =999
trustSet='set1'
function update_tp(newTp, old)
    
	if newTp > currTP and  player.status == "Engaged"    then
		--windower.send_command('lua c gearswap c ' .. currWS)
		send_command('input / '.. currWS ..' <t>')	
		--add_to_chat(122, "autoWS")
	end
	
end

--Event Ids
petWsId =0
wsId= 0
--wsId= 0;

function checkStuff()
local mob =  windower.ffxi.get_mob_by_target("t")
	if mob ~= nil then
	 add_to_chat(122, "mob entity" .. mob.entity_type)
	 add_to_chat(122, "mob type " .. mob.spawn_type)
	 add_to_chat(122, "mob id " .. mob.id)
	 add_to_chat(122, "mob index " .. mob.index)
	  add_to_chat(122, "claim id " .. mob.claim_id)
	end
	local leader =  windower.ffxi.get_mob_by_id(windower.ffxi.get_party().party1_leader)
	if leader ~= nil then
	 add_to_chat(122, "leader " .. leader.id )
	 add_to_chat(122, "leader target " .. leader.target_index) 
	end

end

autoStuff = function ()
	if auto then
		--add_to_chat(122, "autoStuff" )
		
		if trusts and player.status =='Idle' and player.target.type ~= "MONSTER" and windower.ffxi.get_party().p5 == nil then
			windower.ffxi.run(false)
			send_command('wait 1 ;input //tru ' .. trustSet)
			coroutine.schedule(autoStuff, 12)
			return
		end
		if bottin then
			bot()
		end
		if assist then
			assistBot()
		end
		if player.main_job == "PUP" then 
			pupStuff()
		end
		if player.sub_job == "COR" or player.main_job == "COR" then 
			corStuff()
		end
		if player.main_job == "MNK" then
			mnkStuff()
		end
		if player.sub_job == "WAR" or player.main_job == "WAR" then 
			warStuff()
		end
		if player.sub_job == "SAM" or player.main_job == "SAM" then 
			samStuff()
		end
		if  player.main_job == "DRG" then 
			drgStuff()
		end
		if player.main_job == "RUN" then 
			runStuff()
		end
		if autoRA then
			autoRange()
		end
		if autoItem then
			autoItemUse()
		end
		if autoMagic then
			if autoMagicCast == nil
				then include('autoMagic.lua')
			end
			autoMagicCast()
			
		end
		if autoWS and player.tp >  currTP and  player.status == "Engaged"  then 
			send_command('input / '.. currWS ..' <t>')	
		end	
		
		--/
			coroutine.schedule(autoStuff, 2)
			
	end
	
	
end


--------------------------------------------------------------------autoRange function for automatic range attacks---------------------------------------------------------------
	
	function autoRange()
		if player.in_combat and player.target ~= nil then
			send_command('input /ra  <t>')
		end
		
	end
	
	function setAutoWS(wsName)
		currWS = wsName		
		add_to_chat(122,currWS)
	end
	function setWSTP(tp)
		currTP = tonumber(tp)		
		add_to_chat(122,currTP)
	end
	
	

	currItem = 'Frayed Sack (Fer)'
	function autoItemUse()
	
		send_command('input /item "' .. currItem .. '" <me>')
			
	end

maneuver1 = 'Light Maneuver'
maneuver2 = 'Fire Maneuver'
maneuver3 = 'Wind Maneuver'

function pupStuff()
	if  pet.isvalid == false and activate then
			send_command('input /ja activate <me>')
			send_command('input /ja deus ex automata <me>')
	end
	if deploy and player.status =="Engaged" and  pet.status ~= "Engaged"  then
			send_command('input /ja deploy <t>')
	end
	if automaneuver2 and pet.isvalid then
		if  buffactive[maneuver1] == nil then
			send_command(maneuver1)
		end		
		if  maneuver2  and  buffactive[maneuver2] == nil then
			send_command(maneuver2)		
		end
		if  maneuver3  and  buffactive[maneuver3] == nil then
			send_command(maneuver3)		
		end
			
	end
		
end

function drgStuff()
	if  pet.isvalid == false and wyvern then
			send_command('input /ja Call Wyvern <me>')
			
	end
end


function mnkStuff()
	
	if mnkRecast and   player.status =="Engaged"   then
		if buffactive['Impetus'] == nil then
				send_command('input /ja  Impetus  <me>')
		end
					
	end
		
end

function samStuff()
	
	if player.status =="Engaged" and samRecast and buffactive['Hasso'] == nil then
		
			send_command('input /ja  Hasso  <me>')
					
	end
		
end

function warStuff()
	if warRecast  then
		if player.status =="Engaged" and buffactive['Berserk'] == nil then
			
				send_command('input /ja  Berserk  <me>')
						
		end
	end
end

rune1 = 'Tellus'
rune2 = 'Flabra'
rune3 = 'Ignis'

function runStuff()
	if runRecast and player.status == "Engaged" then
		if buffactive['Battuta'] == nil then
			send_command('input /ja Battuta <me>')
		end
		if buffactive['Vallation'] == nil then
			send_command('input /ja Vallation <me>')
		end
		if buffactive['Pflug'] == nil then
			send_command('input /ja Pflug <me>')
		end
	end
	if autoRunes and not windower.ffxi.get_player().moving then
		if buffactive[rune1] == nil then
			send_command('input /ma ' .. rune1 .. ' <me>')
		end
		if rune2 and buffactive[rune2] == nil then
			send_command('input /ma ' .. rune2 .. ' <me>')
		end
		if rune3 and buffactive[rune3] == nil then
			send_command('input /ma ' .. rune3 .. ' <me>')
		end
	end
	if runSpells and not windower.ffxi.get_player().moving then
		if buffactive['Temper'] == nil then
			send_command('input /ma Temper <me>')
		end
		if buffactive['Phalanx'] == nil then
			send_command('input /ma Phalanx <me>')
		end
		if buffactive['Stoneskin'] == nil then
			send_command('input /ma Stoneskin <me>')
		end
		if buffactive['Aquaveil'] == nil then
			send_command('input /ma Aquaveil <me>')
		end
	end
end

roll1 = "Corsair's Roll"
roll2 = 'Samurai Roll'
function corStuff()
		if autoRoll then
		if  buffactive[roll1] == nil  then
			send_command('input /ja  ' .. roll1 ..'  <me>')
		end		
		if    buffactive[roll2]  == nil and player.main_job == "COR"    then
			send_command('input /ja  ' .. roll2 ..'  <me>')
		end		
	end
		
end

---
index=0
mobNum = 2000
passes = 0
maxDistance = 50

    badMobs = S{"Soul Pyre", "Logging Point", "Snipper", "Lobo", "Emblazoned Reliquary", "Ethereal Ingress #5", "Lentic Toad",  "Erupting Geyser", "Staumarth"}

function isValidMob(currMob)

return  currMob~= nil and currMob.hpp > 0 and badMobs[currMob.name] == nil and (  currMob.claim_id == 0 or windower.ffxi.get_mob_by_id(currMob.claim_id).in_party) and currMob.spawn_type == 16

end

function onCooldown(spell)
	local recasts = TableConcat(windower.ffxi.get_ability_recasts(), windower.ffxi.get_spell_recasts())
	
	--add_to_chat(122, recasts[spell.id])
    if recasts[spell.id] and recasts[spell.id] > 0 then
        return true
    else
        return false
    end
end

function TableConcat(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

function moveToMob(mob)
	
		--add_to_chat(122, math.sqrt(mob.distance))
	--add_to_chat(122, mob.index .. ' '.. mob.claim_id)
   		 local player = windower.ffxi.get_player()  
		local target = mob
            local self_vector = windower.ffxi.get_mob_by_index(player.index or 0)
            local angle = (math.atan2((target.y - self_vector.y), (target.x - self_vector.x))*180/math.pi)*-1
		windower.ffxi.turn((angle):radian()) 
        if  math.sqrt(mob.distance) > 2   then       --Turn and run to quetz
            
            windower.ffxi.run(true)
		end
end
function engageMob(mob)
--add_to_chat(122, mob.name)
	--add_to_chat(122, player.status)
        if player.status == 'Idle' then           --If not engaged then engage
            engage = packets.new('outgoing', 0x01A, {
                ['Target'] = mob.id,
                ['Target Index'] = mob.index,
                ['Category'] = 0x02,
            })		
            packets.inject(engage)		
          	--add_to_chat(122, "engaging")
		end
	moveToMob(mob)

end	
function targetMob(mob)
--add_to_chat(122, mob.name)
	--add_to_chat(122, player.status)
        if player.status == 'Idle' then           --If not engaged then engage
            target = packets.new('outgoing', 0x01A, {
                ['Target'] = mob.id,
                ['Target Index'] = mob.index,
                ['Category'] = 0x0F,
            })		
            packets.inject(target)		
          	--add_to_chat(122, "engaging")
		end
	

end	


function disengage()
	
        
           local disengagePacket = packets.new('outgoing', 0x01A, {
                     ['Category'] = 0x04,
            })		
            packets.inject(disengagePacket)
			
		--add_to_chat(122, "disengage")
          	
		
	

end	

assistTarget = nil -- Set to player name to assist specific person

function assistBot()
	local leader
	if assistTarget then
		leader = windower.ffxi.get_mob_by_name(assistTarget)
	else
		leader = windower.ffxi.get_mob_by_id(windower.ffxi.get_party().party1_leader)
	end
	
	if leader == nil or leader.target_index == nil then
		return false
	end
	
	local mob = windower.ffxi.get_mob_by_index(leader.target_index)
	if isValidMob(mob) and mob.claim_id == leader.id then
		engageMob(mob)
		moveToMob(mob)
	elseif player.status=="Engaged" and not isValidMob(mob) then
		disengage()
	end
	windower.ffxi.follow(leader.index)
end
claimJA = "Provoke"
prevMob = nil

function bot()
	windower.ffxi.run(false)	
	if bottin ~= true then
		return
	end	
	
		local mob =  windower.ffxi.get_mob_by_target("t")
	
	if isValidMob(mob) == false or  player.target.type ~= "MONSTER"    then 
		if player.status=="Engaged"  then
			disengage()
			windower.ffxi.run(false)
		end
		local i =0
		local lowestDistance = 999
		lowestIndex = -1
		--while mob == nil or math.sqrt(mob.distance) > 50 or mob.hpp <= 0  do
		while i <= mobNum do
			currMob = windower.ffxi.get_mob_by_index(i)
			
			if currMob ~= nil and currMob.distance < lowestDistance and isValidMob(currMob) then
				lowestDistance = currMob.distance
				lowestIndex = i
			end
				i = i +1		
		end	
		
		passes = 0		
		mob = windower.ffxi.get_mob_by_index(lowestIndex)
		
		if mob == nil then
			--add_to_chat(122, "noMob")
			return
		end
		add_to_chat(122, mob.name)
	else	
		passes = passes+1
		
	
	end
	
	engageMob(mob)
	if mob ~= nil
	and mob.claim_id == 0 and autoClaim then
		send_command('input /' .. claimJA)
	end
	
	moveToMob(mob)
	mob = prevMob
	
end
	--turn auto on and wait a few seconds for it to activate
	--send_command('wait 8 ;input //gs c auto')
	
	send_command('bind f9 gs c equipTP')
    send_command('bind f10 gs c equipDT')
    send_command('bind f11 gs c equipIdle')
    send_command('bind ` swf next')

	send_command('bind ^f9 gs c tpMode')
    send_command('bind ^f10 gs c dtMode')
    send_command('bind ^f11 gs c idleMode')
   
	
	send_command('bind !f9 gs c customTP')
    send_command('bind !f10 gs c customDT')
    send_command('bind !f11 gs c customIdle')
	
   
   if player.main_job == "PUP" then
		
		send_command('bind !f12 gs c customPet')
		send_command('bind ^f12 gs c petMode')
		send_command('bind f12 gs c equipPet')
	elseif player.main_job == "RUN"  then
		send_command('bind ^f12 gs c tankMode')
		send_command('bind !f12 gs c customTank')	
		send_command('bind f12 gs c equipTank')
	elseif player.main_job == "COR" then
		send_command('bind ^f12 gs c rangeMode')
		send_command('bind !f12 gs c customRange')	
		send_command('bind f12 gs c equipRange')
	else 
		send_command('bind !f12 gs c customElemental')
		send_command('bind ^f12 gs c elementalMode')
		send_command('bind f12 gs c equipElemental')
	
	end
	
	if player.name == "Quadav" then
		send_command('send set Snipper')
	end
      function file_unload()
     
 
        send_command('unbind ^f9')
        send_command('unbind ^f10')
        send_command('unbind ^f11')
        send_command('unbind ^f12')
       
        send_command('unbind !f9')
        send_command('unbind !f10')
        send_command('unbind !f11')
        send_command('unbind !f12')
 
        send_command('unbind f9')
        send_command('unbind f10')
        send_command('unbind f11')
        send_command('unbind f12')
 
       
 
    end
    
	----------------------------------------------------Commands---------------------------------------------------------------------------------------------------
	--------------booleans--------------------------------
	-----------When used these will switch on if they're off, and off if they're on
	
	---- //gs c deploy 
	-- makes it so automaton will automatically deploy when you engage
	---- //gs c automaneuver 
	-- makes it so manuevers will be used as they wear off
	---- //gs c cap
	-- equips capacity back, you have to set the back in the self_command function under cap
	-- //gs c magicburst
	-- sets elemental set to magicburst set
	--//gs c petWS
	-- equips petWS set, will be switched out of after a cast
	--//gs c autocast
	-- sets magic to cast automatically accordding to the spells in automagic
	--//gs c rest
	-- toggles rest during auto cast off or on, starts on
	
	--------------EquipSets---------------------------------------
	--these will equip the current mode of a set
	--called by calling the name of the set 
	-- currently defined are: equipTP, equipDT, equipIdle, equipPet, equipPet/Nuke, equip
	--------------Mode switches-----------------------------------
	---These will cylce through the modes if they're configured correctly
	-- already configured are tp, pet, nuke, dt, and idle sets.
	-- calling the prefix followed by "Mode" will change the current mode, ex //gs c dtMode will cycle through the dtModes
	-- 
	----------------------------------------------------Hot Keys----------------------------------------------------------
	--These hotkeys are only set with my windower init file 
	
	--f9 is bound to equip current tpset
	--Crtl f9 is bound to change tp modes
	-- alt f9 sets up a custom tp mode, which will be equiped under customTP
	
	--f10 is bound to equip current  dtset
	--Crtl f10 is bound to change tp modes
	--alt f10 sets WS mode
	
	--f11 is bound to equip current Idleset
	--Crtl f11 is bound to change idle modes
	
	
	--f12 is bound to equip current Pet set when on pup, nuking set when on anything else
	--Crtl f12 is bound to change pet mode when on pup, and nuking set on anything else
	----------------------------------------------------------------------------------------------------
	--------------------------------------------------------Set for stuff--------------------------------------------------------------------------------
    petWeaponskills = S{"Slapstick", "Knockout", 
    "Chimera Ripper", "String Clipper",  "Cannibal Blade", "Bone Crusher", "String Shredder",
    "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}
	
	   rolls = {
        ["Corsair's Roll"]   = "lucky=5, unlucky=9, bonus=Experience Points",
        ["Ninja Roll"]       = "lucky=4, unlucky=8, bonus=Evasion",
        ["Hunter's Roll"]    = "lucky=4, unlucky=8, bonus=Accuracy",
        ["Chaos Roll"]       = "lucky=4, unlucky=8, bonus=Attack",
        ["Magus's Roll"]     = "lucky=2, unlucky=6, bonus=Magic Defense",
        ["Healer's Roll"]    = "lucky=3, unlucky=7, bonus=Cure Potency Received",
        ["Puppet Roll"]      = "lucky=4, unlucky=8, bonus=Pet Magic Accuracy/Attack",
        ["Choral Roll"]      = "lucky=2, unlucky=6, bonus=Spell Interruption Rate",
        ["Monk's Roll"]      = "lucky=3, unlucky=7, bonus=Subtle Blow",
        ["Beast Roll"]       = "lucky=4, unlucky=8, bonus=Pet Attack",
        ["Samurai Roll"]     = "lucky=2, unlucky=6, bonus=Store TP",
        ["Evoker's Roll"]    = "lucky=5, unlucky=9, bonus=Refresh",
        ["Rogue's Roll"]     = "lucky=5, unlucky=9, bonus=Critical Hit Rate",
        ["Warlock's Roll"]   = "lucky=4, unlucky=8, bonus=Magic Accuracy",
        ["Fighter's Roll"]   = "lucky=5, unlucky=9, bonus=Double Attack Rate",
        ["Drachen Roll"]     = "lucky=3, unlucky=7, bonus=Pet Accuracy",
        ["Gallant's Roll"]   = "lucky=3, unlucky=7, bonus=Defense",
        ["Wizard's Roll"]    = "lucky=5, unlucky=9, bonus=Magic Attack",
        ["Dancer's Roll"]    = "lucky=3, unlucky=7, bonus=Regen",
        ["Scholar's Roll"]   = "lucky=2, unlucky=6, bonus=Conserve MP",
        ["Bolter's Roll"]    = "lucky=3, unlucky=9, bonus=Movement Speed",
        ["Caster's Roll"]    = "lucky=2, unlucky=7, bonus=Fast Cast",
        ["Courser's Roll"]   = "lucky=3, unlucky=9, bonus=Snapshot",
        ["Blitzer's Roll"]   = "lucky=4, unlucky=9, bonus=Attack Delay",
        ["Tactician's Roll"] = "lucky=5, unlucky=8, bonus=Regain",
        ["Allies's Roll"]    = "lucky=3, unlucky=10, bonus=Skillchain Damage",
        ["Miser's Roll"]     = "lucky=5, unlucky=7, bonus=Save TP",
        ["Companion's Roll"] = "lucky=2, unlucky=10, bonus=Pet Regain and Regen",
        ["Avenger's Roll"]   = "lucky=4, unlucky=8, bonus=Counter Rate",
		["Runeist's Roll"]     = "lucky=4, unlucky=8, bonus=Magic Evasion"
	}
	
	quickDraw  = {	
	["Light Shot"] = {}, 
	["Dark Shot"] = {},
	["Fire Shot"] = {},
	["Water Shot"] = {},
	["Thunder Shot"] = {},
	["Earth Shot"] = {},
	["Wind Shot"]= {},
	["Ice Shot"] = {}
	}
	
	maneuvers  = {	
	["Light Maneuer"] = light, 
	["Dark Maneuver"] = dark,
	["Fire Maneuver"] = fire,
	["Water Maneuver"] = water,
	["Thunder Maneuver"] = thunder,
	["Earth Maneuver"] = earth,
	["Wind Maneuver"]= wind,
	["Ice Maneuver"] = ice
	}
	
	waltz = {	
	["Curing Waltz"] = {}, 
	["Curing Waltz II"] = {},
	["Curing Waltz III"] = {},
	["Curing Waltz IV"] = {},
	["Curing Waltz V"] = {},
	["Divine Waltz"] = {},
	["Divine Waltz II"]= {},
	["Healing Waltz"] = {}
	}
	
	magicSkills = {
        ["Elemental Magic"]   	= "Elemental",
        ["Healing Magic"]    	= "Healing",
        ["Enfeebling Magic"]    = "Enfeebling",
        ["Geomancy"]       		= "Geomancy",
        ["Singing"]       = "Song",
		["String"]       = "Song",
		["Wind"]       = "Song",
        ["Blue Magic"]    		= "Blue",
        ["Dark Magic"]     		= "Darkness",
        ["Enhancing Magic"]     = "Enhancing",
        ["Ninjutsu"]       		= "Ninjutsu",
        ["Summoning Magic"]     = "Summoning",
        ["Divine Magic"]      	= "Divine"
    
    }
	
	sets.obi = {
		Fire = {waist="Karin Obi"},
		Earth = {waist="Dorin Obi"},
		Water = {waist="Suirin Obi"},
		Wind = {waist="Furin Obi"},
		Ice = {waist="Hyorin Obi"},
		Lightning = {waist="Rairin Obi"},
		Light = {waist="Korin Obi"},
		Dark = {waist="Anrin Obi"},
    }
	storms = {
		Fire = "Firestorm",
		Earth = "Sandstorm",
		Water = "Rainstorm",
		Wind = "Windstorm",
		Ice = "Hailstorm",
		Lightning = "Thunderstorm",
		Dark = "Voidstorm",
		Light = "Aurorastorm"
	}
		runes = S{"Tellus", "Flabra"}
	
	---------------------------------------------------------Sets for blu spells----------------------------------------------
	blueMagic = S{} --spells that will equip sets.Blue.Magic[nukeMode]
	bluePhysical = S{} -- spells that will equip sets.Blue.Physical
	blueDebuff = S{} -- spells that will equip sets.Blue.Debuff
	blueBuff = S{} -- spells that will equip sets.Blue.Buff
	blueCure = S{}-- spells that will equip sets.Blue.Cure
	-----------------------------------------------------------------------------------------------------------------------------
	
	----------------------------------------------------------------Modes--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	--To create a mode you have to do the following:
	
	
	
	----------------------------------------------------------List of catagories-----------------------------------------------------------

	modeSets = {
		["tpMode"] =	 	{num = 1, suffix = "TP", 			tpType = 1, idleType = 0, midcastType = 0, precastType = 0, setModes = tpModes},
		["dtMode"] = 		{num = 1, suffix = "DT", 			tpType = 1,	idleType = 1, midcastType = 0, precastType = 0, setModes = dtModes},
		["petMode"] = 		{num = 1, suffix = "Pet",			tpType = 1, idleType = 1, midcastType = 0, precastType = 0, setModes = petModes},
		["wsMode"] = 		{num = 1, suffix = "WS", 			tpType = 0, idleType = 0, midcastType = 0, precastType = 1, setModes = wsModes}, 
		["elementalMode"]= 	{num = 1, suffix = "Elemental",	 	tpType = 0, idleType = 0, midcastType = 1, precastType = 0,	setModes = elementalModes},
		["idleMode"] = 		{num = 1, suffix = "Idle", 			tpType = 0, idleType = 1, midcastType = 0, precastType = 0, setModes = idleModes},
		["rangeMode"] = 	{num = 1, suffix = "Ranged", 		tpType = 0, idleType = 0, midcastType = 1, precastType = 1, setModes = rangeModes},
		["tankMode"] = 		{num = 1, suffix = "Tank", 		tpType = 1, idleType = 0, midcastType = 0, precastType = 0, setModes = tankModes},
		["darknessMode"]= 	{num = 1, suffix = "Darkness",	 	tpType = 0, idleType = 0, midcastType = 0, precastType = 1,	setModes = darknessModes}}, 
		{"num", "suffix", "tpType","idleType", "midcastType", "precastType", "setModes"}
	
	--- list of commands for equiping a set
	equipSets = {
		["equipTP"] =	 		"tpMode",
		["equipDT"] = 			"dtMode",
		["equipPet"] = 			"petMode",
		["equipIdle"] = 		"idleMode",
		["equipRange"] = 		"rangeMode",
		["equipElemental"] = 	"elementalMode",
		["equipTank"] = 		"tankMode",
	}
	
	customSets = {
		["customTP"] =	 		"tpMode",
		["customDT"] = 			"dtMode",
		["customPet"] = 			"petMode",
		["customIdle"] = 		"idleMode",
		["customRange"] = 		"rangeMode",
		["customElemental"] = 	"elementalMode",
	}
	
	curagas = {
		["Curaga"] =	 		"",
		["Curaga II"] = 			"",
		["Curaga III"] = 			"",
		["Curaga IV"] = 		"",
		["Curaga V"] = 		"",
	}
	cures = {
		["Cure"] =	 		"",
		["Cure II"] = 			"",
		["Cure III"] = 			"",
		["Cure IV"] = 		"",
		["Cure V"] = 		"",
		["Cure VI"] = 	"",
	}
	
----------------------------------------------------------------------------------------------Booleans----------------------------------------------------------------------------------------------------------------------------------------------
	--These are booleans 
	
	booleans = S{"magicburst", "deploy","rest", "automaneuver", "rune",  "autoHaste" ,"autoRoll","autoMagic", "provoke",  "swaps", "fire", "thunder", "water", "light", "dark", "wind", "earth", "activate", "mnkRecast", "warRecast", "samRecast", "runRecast", "autoRunes", "runSpells", "automaneuver2", "autoRA", "bottin", "assist", "autoItem", "trusts", "wyvern", "autoClaim"} --booleans
	
	auto = true -- main auto loop bool
	if auto then
		autoStuff()
	end
	bottin = false
	autoRA = false
	autoItem = false	
	assist = false
	trusts = false
	autoMagic = false
	rest = true
	cap = false
	autoClaim = true
	
	--job auto casts part of main auto loop
	automaneuver2 = false
	autoRoll = false	
	wyvern = false
	activate = false
	mnkRecast = false
	warRecast = false
	samRecast=false
	runRecast = false
	autoRunes = false
	runSpells = false
	
	--triggered on mid cast
	magicburst = false
	--triggered on buff wearing
	automaneuver = true
	rune = false	
	autoHaste = false
	--trigger on engaging
	provoke = false
	deploy = false
	-- toggles off gear swaps
	swaps = true
	
	
	
	
	
	-- these have events registered to them
	autoWS = false
	petWS = false
	
	
	
	
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------Buff Change function--------------------------------------
-- looks for buff changes
-- automaneuver is set to true, it will put maneuvers back up when they wear
-- if runes it set to true, it will put up any runes that of within the runes set as they wear off
function buff_change(name, gain)
	if not gain and automaneuver   and string.find(name,'Maneuver') then --maneuver auto put back up if automaneuver is true
			add_to_chat(122,name)
			send_command(name)		
	
	end
	--if not gain and autoRoll and string.find(name,'Roll') then --roll auto put back up if autoRoll is true
		--	add_to_chat(122,name)
		--	send_command(name)		
	
--	end
	if not gain and rune and  runes:contains(name) then
		add_to_chat(122,name)
		send_command(name)
	end
	if not gain and autoHaste and  name == "Haste" then
		add_to_chat(122,name)
		send_command('send haste 2 ' .. player.name)
	end
	if not gain  and (player.status =="Engaged") and  name == "Hasso" then
		add_to_chat(122,name)
		send_command(name)
	end
end

------------------------------------------------------------------------Precast Function---------------------------------------------------------------------------------------------------------------
-- if a sets.precast["spell name"] exists it will equip that.
-- if magic it will equip sets.precast.magic
-- if healing it will equip sets.precast.Magic.Healing if it exists
-- if a job ability, it will equip sets.precast.JA["spell name"] if it exists
-- if weapon skill it will equip sets.precast.WS
-- if sets.WS["WS name"] exists it will equip that
-- if sets.WS["WS name"]."Ws mode" exists it will equip that
-- if sets.precast.maneuver is set it will equip that set when any maneuver is used
-- if sets.precast.Waltz is set, it will equip that set when any maneuver is used
function precast(spell)	
	if onCooldown(spell) then
		--add_to_chat(122, spell .. "on cooldown")
		return false
	end
	
	if swaps == false then
		add_to_chat(122, "swaps disabled")
	
	elseif sets.precast[spell.english] then	
        equip(sets.precast[spell.english])
	elseif cures[spell.english] and sets.precast.Cure then
		equip(sets.precast.Cure)
	elseif curagas[spell.english] and sets.precast.Curaga then
		equip(sets.precast.Curaga)
	elseif sets.precast.JA[spell.english] then	
		equip(sets.precast.JA[spell.english])
	elseif spell.action_type == 'Magic' then
		--add_to_chat(122, spell.skill)
		local currSkill = magicSkills[spell.skill]
		if  sets.precast[currSkill] then
			equip(sets.precast[currSkill])
		else
			equip(sets.precast.Magic)
		end				   
    elseif spell.type=="WeaponSkill" then   
		if sets.WS[spell.english] then
			equip(sets.WS[spell.english]) 
			if sets.WS[spell.english][wsMode] then
				equip(sets.WS[spell.english][wsMode]) 
			end
		else 
			equip(sets.precast.WS)
		end	
    elseif maneuvers[spell.english]  then
		equip(sets.precast.maneuver)
	elseif rolls[spell.english]  then
		equip(sets.precast.Roll)		
	elseif waltz[spell.english]  then
		equip(sets.precast.Waltz)
	elseif quickDraw[spell.english] then
		equip(sets.precast.Quickdraw)
	elseif spell.action_type == "Ranged Attack" then
		if sets.precast.Ranged ~= nil then
			equip(sets.precast.Ranged)
		end
    end
	
   end

------------------------------------------------------------------------Pet mid cast-----------------------------------------------------------
-- doesn't work for Ws
-- will equip pet magic sets if they exists
-- sets.midcast.Pet['Elemental Magic']
--function pet_midcast(spell)
--	if petWS then
--		if swaps == false then
--			add_to_chat(122, "swaps disabled")
--		elseif spell.skill == 'Elemental Magic' then
--			equip(sets.midcast.Pet['Elemental Magic'])
--		end
--	end
  
--end
---------------------------------------------------------------------Pet aftercast-----------------------------------------------------------------
--puts current tp/idle set on after a pet cast
 --if petWS bool is on it turns it off

function pet_aftercast(spell)
	if petWS and swaps == false then
		
			add_to_chat(122, "swaps disabled")
		elseif player.status =='Engaged' then
			equip(sets.aftercast.TP)
		else
			equip(sets.aftercast.Idle)
		
	end
	
end

---------------------------------------------------------------------aftercast-----------------------------------------------------------------
--puts current tp/idle set on after a  cast
function aftercast(spell)
	if swaps == false then
		add_to_chat(122, "swaps disabled")
    elseif player.status =='Engaged' then
        equip(sets.aftercast.TP)		
    else
        equip(sets.aftercast.Idle)
    end
	if rolls[spell.english]  then		
		add_to_chat(4,rolls[spell.english])
	end
	
end



-----------------------------------------------midcast----------------------------------------------------------------------------------------------
--mid cast sets---------------
-- sets.midcast[spell.english]
-- sets.midcast.Elemental
-- sets.midcast.Elemental.Burst
-- sets.midcast.Ranged
-- sets.midcast.Healing
-- sets.Blue.Magic
-- sets.Blue.Physical
-- sets.Blue.Debuff
-- sets.Blue.Buff
-- sets.Blue.Cure
-- sets.Blue.

function midcast(spell)
	if swaps == false then
		add_to_chat(122, "swaps disabled")
	elseif sets.midcast[spell.english] then
        equip(sets.midcast[spell.english])
	elseif  spell.action_type == 'Magic' then
		local currSkill = magicSkills[spell.skill]
		if cures[spell.english] and sets.midcast.Cure then
			equip(sets.midcast.Cure)
		elseif string.find(spell.english,'Bar') and sets.midcast.Bar then
			equip(sets.midcast.Bar)		
		elseif curagas[spell.english] and sets.midcast.Curaga then
			equip(sets.midcast.Curaga)		
		elseif sets.midcast[currSkill] then
			equip(sets.midcast[currSkill])
		else
			equip(sets.midcast.Magic)
		end	
		local burst = "Burst"
		if magicburst and sets[currSkill][burst] then
			equip(sets[currSkill][burst])
		end
		if spell.skill == "Blue Magic" then	
			equip(sets.Blue.Magic)
			if bluePhysical:contains(spell.english) then
				equip(sets.Blue.Physical)
			elseif blueDebuff:contains(spell.english) then
				equip(sets.Blue.Debuff)
			elseif blueBuff:contains(spell.english) then
				equip(sets.Blue.Buff)
			elseif blueCure:contains(spell.english) then
				equip(sets.Blue.Cure)
			elseif blueMagic:contains(spell.english) and sets.Blue.Magic[elementalMode] then
					equip(sets.Blue.Magic[elementaMode])
			end	
			
		end
		local storm = storms[spell.element]
			if spell.element == world.weather_element or spell.element == world.day_element or buffactive[storm]  then
				equip(sets.obi[spell.element])
		end	
	elseif spell.action_type == "Ranged Attack" and sets.midcast.Ranged ~= nil then
			equip(sets.midcast.Ranged)		
	end
end

-----------------------------------------------------------status change-------------------------------------------------------------

function status_change(new,old)
	if swaps == false then
		add_to_chat(122, "swaps disabled")
    elseif new == 'Idle' then 
        equip(sets.aftercast.Idle)
	elseif new == 'Resting' then
        equip(sets.Resting)
    elseif new == 'Engaged' then
        equip(sets.aftercast.TP)
	end
end

function booleanChange(bool) ------------------------------------------------------------------------- changes booleans---------------------------------------------
	if bool == false then 
			return true					
	else 
		return false			
	end
end

------------------------------------------------------------------------------change modes-------------------------------------------------------------------------

-- changes number of mode passed in and calls equip_Sets to change that set
function modeChange(currMode)
	local currNum = 0
	
	if currMode.num == #currMode.setModes then
			currMode.num = 1 
		else
			currMode.num = currMode.num + 1	
	end
	equip_Sets(currMode)
end
----------------------------------------

--changes the mode to match the current mode number
function equip_Sets(currMode)
  	current = currMode.setModes[currMode.num]
	if currMode.tpType == 1 then
		if  #currMode.setModes == 0 or sets[currMode.suffix][current] == nil then
			sets.aftercast.TP= sets[currMode.suffix]
			add_to_chat(122, "TP = Default" .. currMode.suffix)
		else 
			--if sets.TP[currMode.suffix] then
			--	sets.TP[currMode.suffix] = sets[currMode.suffix][current]
			--end
			sets.aftercast.TP = sets[currMode.suffix][current]
			add_to_chat(122, "TP = " .. current .. " " .. currMode.suffix)
		end
		if player.status =='Engaged' or currMode.suffix == "TP" then
			equip(sets.aftercast.TP) 
		end
	end	
	if currMode.idleType == 1 then
		
		if  #currMode.setModes == 0 or sets[currMode.suffix][current] == nil then
			sets.aftercast.Idle= sets[currMode.suffix]
			add_to_chat(122, "Idle = Default" .. currMode.suffix)
		else 
			--if sets.Idle[currMode.suffix] then
			--	sets.Idle[currMode.suffix] = sets[currMode.suffix][current]
			--end
			sets.aftercast.Idle = sets[currMode.suffix][current]
			add_to_chat(122,  "Idle = " .. current .. " " .. currMode.suffix )
		end
		if player.status =='Idle' then
			equip(sets.aftercast.Idle) 
		end
	end
	if currMode.precastType == 1 then
		if  #currMode.setModes == 0 or sets[currMode.suffix][current] == nil then
			add_to_chat(122, currMode.suffix .." Precast = " .. currMode.suffix .. " Default"  )
			sets.precast[currMode.suffix] = sets[currMode.suffix]
		else					
			sets.precast[currMode.suffix] = sets[currMode.suffix][current]
			add_to_chat(122, currMode.suffix .." Precast = " .. current )
		end
		
	end
	if currMode.midcastType == 1 then -- canges midcast set
		if  #currMode.setModes == 0 or sets[currMode.suffix][current] == nil then
			add_to_chat(122, currMode.suffix .. " Midcast = " .. currMode.suffix .. " Default" )
			sets.midcast[currMode.suffix] = sets[currMode.suffix]
		else					
			sets.midcast[currMode.suffix] = sets[currMode.suffix][current]
			add_to_chat(122, currMode.suffix .." Midcast = " .. current  )
		end
		
	end
end
----------------------------------------------------------------custom sets------------------------------------------------------------------------------------------
function customSet()
	 return {head= player.equipment.head, neck= player.equipment.neck,
        ear1=player.equipment.left_ear ,ear2=player.equipment.right_ear,body=player.equipment.body,hands=player.equipment.hands,
        ring1=player.equipment.left_ring,ring2=player.equipment.right_ring, back=player.equipment.back,waist=player.equipment.waist,legs=player.equipment.legs,
        feet= player.equipment.feet}
		--add_to_chat(122, set)
end

function self_command(command)

	--------------------------------------------------------------------------------Modes--------------------------------------------------------------------------------------------------------------

	if modeSets[command] ~= nil then 		
		if modeSets[command].setModes == nil then
			add_to_chat(122, "no modes set up for " .. modeSets[command].suffix)
		else
			modeChange(modeSets[command])
		end
---------------------------------------------------------------equip sets ---------------------------------------------------------------------------------------------------------------
	elseif equipSets[command] ~= nil then
		if modeSets[equipSets[command]].setModes == nil then
			add_to_chat(122, "no modes set up for " .. modeSets[equipSets[command]].suffix)
		else
			equip_Sets(modeSets[equipSets[command]], 1)
		end
---- bool toggle----	
	elseif booleans:contains(command) then		--turns booleans off or on, booleans must be in the commands section
		_G[command] = booleanChange(_G[command])
		if _G[command] == true then
			add_to_chat(122, command .. " on")
		else 
			add_to_chat(122, command .. " off")
		end
	elseif command == "cap" then
		if cap == false then
			equip({back = "Aptitude Mantle"})
			cap = true 
			disable("back")
			add_to_chat(122, command .. " on")
		else
			cap = false
			enable("back")
			add_to_chat(122, command .. " off")
		end
	elseif command == "auto" then
		if auto == false then 
			auto = true
			add_to_chat(122, command .. " on")		
			autoStuff()
		else 
			auto = false
			add_to_chat(122, command .. " off")
		end
	elseif command == "autoStuff" then
		autoStuff()	
	elseif command == "autoWS" then
		if autoWS == false then 
			autoWS = true
			add_to_chat(122, command .. " on")
			--wsId= windower.register_event('tp change', update_tp)
		else 
			autoWS = false
			--wsId = windower.unregister_event(wsId)
			add_to_chat(122, command .. " off")
		end
	elseif command == "petWS" then
		if petWS == false then 
			petWS = true
			petWsId = windower.raw_register_event('incoming chunk', update_pet_tp)
			add_to_chat(122, command .. " on")			
		else 
			petWS = false
			petWsId = windower.unregister_event(petWsId)
			add_to_chat(122, command .. " off")
		end

----------------------------------------------------------------------------------------------custom sets----------------------------------------------------------------------------
	
	elseif command == "check" then 
		checkStuff()
		
	elseif command == "mob" then
		mobs = windower.ffxi.get_mob_array()
		add_to_chat(122, player.target.name)
		add_to_chat(122, player.target.hpp)
		add_to_chat(122, player.target.id)		
		
	elseif customSets[command] then
		if sets[modeSets[customSets[command]].suffix] then
				if sets[modeSets[customSets[command]].suffix].Custom ~= nil then
					sets[modeSets[customSets[command]].suffix].Custom =  customSet()	
				end
			add_to_chat(122, "Custom " .. modeSets[customSets[command]].suffix .." Set")
		end
	elseif string.find(command,"setWS") then
		setAutoWS(string.sub(command,7))
		add_to_chat(122, command)
	elseif string.find(command,"setItem") then
		currItem = string.sub(command,9)
		add_to_chat(122, command)
	elseif string.find(command,"setTP") then
		 setWSTP(string.sub(command,7))
		add_to_chat(122, command)
	elseif string.find(command,"setMan1") then
		maneuver1 = (string.sub(command,9))
		add_to_chat(122, maneuver1)
	elseif string.find(command,"setMan2") then
		maneuver2 = (string.sub(command,9))
		add_to_chat(122, maneuver2)
	elseif string.find(command,"setMan3") then
		maneuver3 = (string.sub(command,9))
		add_to_chat(122, maneuver3)
	elseif string.find(command,"setRoll1") then
		roll1 = (string.sub(command,10))
		add_to_chat(122, command)
	elseif string.find(command,"setRoll2") then
		roll2 = (string.sub(command,10))
		add_to_chat(122, command)
		--elseif command == "autocast" then
	--	if firstAuto then
		--	include('autoMagic.lua')
	--	end
	--	firstAuto = false
	--	if autocast == false then
	--		autocast = true;
	--		add_to_chat(122, command .. " on")
	--		send_command('wait 2 ;input //gs c autoMagicCast')
	--	else 
	--		autocast = false
	--		add_to_chat(122, command .. " off")
	--	end
	
	--elseif command == "autoMagicCast" then
	--	autoMagicCast()
	end
	
	
	
	
end
    
	
