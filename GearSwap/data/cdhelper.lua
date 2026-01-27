
include('augments.lua')



packets = require('packets')

-- Track post-death timing
local lastDeathTime = 0

function update_pet_tp(id,data) 
	pet_tp = packets.parse('incoming', data)["Pet TP"]
	if pet_tp ~= nil and pet_tp > 999  then	

		if sets.Pet.WS[pet.frame] ~= nil then
			--add_to_chat(122, "Equipping frame-specific WS set for " .. pet.frame)
			send_command('gs equip sets.Pet.WS[' .. pet.frame.. ']')
		elseif sets.Pet and sets.Pet.WS then
			--add_to_chat(122, "Equipping default Pet WS set")
			send_command('gs equip sets.Pet.WS')
		else
			add_to_chat(122, "No Pet WS set found!")
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
	-- Player status info
	add_to_chat(122, "=== PLAYER STATUS ===")
	add_to_chat(122, "Status: " .. tostring(player.status))
	add_to_chat(122, "In Combat: " .. tostring(player.in_combat))
	add_to_chat(122, "Casting: " .. tostring(windower.ffxi.get_player().casting))
	add_to_chat(122, "HP: " .. player.hp .. "/" .. player.max_hp .. " (" .. player.hpp .. "%)")
	add_to_chat(122, "MP: " .. player.mp .. "/" .. player.max_mp .. " (" .. player.mpp .. "%)")
	if player.target then
		add_to_chat(122, "Target: " .. tostring(player.target.name) .. " (" .. tostring(player.target.type) .. ")")
	else
		add_to_chat(122, "Target: None")
	end
	
	-- Mob info
	add_to_chat(122, "=== MOB INFO ===")
	local mob =  windower.ffxi.get_mob_by_target("t")
	if mob ~= nil then
	 add_to_chat(122, "mob type " .. mob.spawn_type)
	 add_to_chat(122, "mob id " .. mob.id)
	 add_to_chat(122, "mob index " .. mob.index)
	 add_to_chat(122, "claim id " .. mob.claim_id)
	 if mob.target_index ~= nil then
	  add_to_chat(122, "mob target index " .. mob.target_index)
	 end
	end
	
	-- Leader info
	add_to_chat(122, "=== LEADER INFO ===")
	local leader =  windower.ffxi.get_mob_by_id(windower.ffxi.get_party().party1_leader)
	if leader ~= nil then
	 add_to_chat(122, "leader " .. leader.id )
	 add_to_chat(122, "leader target " .. leader.target_index) 
	end

end

autoStuff = function ()
	if auto then
		--add_to_chat(122, "autoStuff" )
		
		-- Don't auto cast anything if invisible is up
		if not buffactive['Invisible'] then
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
	if  pet.isvalid == false and wyvern and player.status =="Engaged" then
			send_command('input /ja Call Wyvern <me>')
			
	end
	if drgRecast and player.status == "Engaged" then
		send_command('input /ja "Jump" <t>')
		send_command('input /ja "High Jump" <t>')
		send_command('input /ja "Spirit Jump" <t>')
		send_command('input /ja "Soul Jump" <t>')
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
		if buffactive['Multi Strikes'] == nil then
			send_command('input /ma Temper <me>')
		end
		if buffactive['Regen'] == nil then
			send_command('input /ma "Regen IV" <me>')
		end
		if buffactive['Refresh'] == nil then
			send_command('input /ma Refresh <me>')
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

-- Smart combat detection function
function isActuallyInCombat()
    -- If not flagged as in combat, definitely not in combat
    if not player.in_combat then
        return false
    end
    
    -- Check if we're in the 2-second post-death waiting period
    if os.time() - lastDeathTime < 2 then
        return false  -- Still waiting after a death
    end
    
    -- If in combat, check if we have a valid living target
    local mob = windower.ffxi.get_mob_by_target("t")
    if mob and isValidMob(mob) and mob.hpp and mob.hpp > 0 then
        return true  -- We have a valid, living target
    end
    
    -- In combat flag is set, but no valid target = combat just ended
    if player.in_combat then
        lastDeathTime = os.time()  -- Record when combat ended
    end
    
    return false
end

function checkTrustMP()
	local party = windower.ffxi.get_party()
	local trustCount = 0
	
	-- Check party members p1-p5 (trusts are usually p1-p5)
	for i = 1, 5 do
		local member = party['p' .. i]
		
		if member and member.name and member.name ~= player.name then
			-- This is a trust/party member
			trustCount = trustCount + 1
			
			-- Try to get MP from party data
			if member.mp and member.mpp then
				if member.mpp < 75 then
					add_to_chat(122, member.name .. " has low MP (" .. member.mpp .. "%) - party not ready")
					return false
				end
			end
		end
	end
	
	-- Check if party is full (should have 5 trusts)
	if trustCount < 5 then
		add_to_chat(122, "Party not full - only " .. trustCount .. " trusts")
		return false
	end
	
	return true
end

function isValidMob(currMob)
    if currMob == nil or currMob.hpp <= 0 or badMobs[currMob.name] ~= nil or currMob.spawn_type ~= 16 then
        return false
    end
    
    -- Target filter: if enabled, only target mobs from approved list
    if targetFilter and not approvedTargets:contains(currMob.name) then
        return false
    end
    
    -- Check if mob is unclaimed or claimed by someone in our party
    local validClaim = false
    if currMob.claim_id == 0 then
        validClaim = true  -- Unclaimed mob
    else
        local claimer = windower.ffxi.get_mob_by_id(currMob.claim_id)
        if claimer and claimer.in_party then
            validClaim = true  -- Claimed by party member
        end
    end
    
    -- Priority 1: If we're in combat and mob is close, prioritize it (but still respect claims)
    if player.in_combat and currMob.distance < 25 and validClaim then
        return true
    end
    
    -- Priority 2: Original logic for all other cases
    return validClaim
end

function onCooldown(spell)
	local recast_id = spell.recast_id
	
	if spell.action_type == 'Ability' then
		local recasts = windower.ffxi.get_ability_recasts()
		if recasts[recast_id] and recasts[recast_id] > 0 then
			return true
		end
	else
		local recasts = windower.ffxi.get_spell_recasts()
		if recasts[recast_id] and recasts[recast_id] > 0 then
			return true
		end
	end
	
	return false
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
	

	
	-- Check if trusts have enough MP and party is full before engaging (only when not actually in combat)
	if not isActuallyInCombat() then
		if not checkTrustMP() then
			if debugBot then add_to_chat(122, "PARTY CHECK FAILED - STOPPING BOT") end
			return
		end
	else
		if debugBot then add_to_chat(122, "IN ACTUAL COMBAT - SKIPPING PARTY CHECK") end
	end
	
		local mob =  windower.ffxi.get_mob_by_target("t")
	
	-- Check for closer threatening mobs even when we have a valid target
	local shouldSwitchTarget = false
	if player.status == "Engaged" and mob ~= nil and isValidMob(mob) then
		local currentDistance = mob.distance
		-- Look for closer mobs that might be hitting us
		for i = 0, mobNum do
			local nearbyMob = windower.ffxi.get_mob_by_index(i)
			if nearbyMob ~= nil and isValidMob(nearbyMob) and nearbyMob.id ~= mob.id then
				-- If there's a much closer mob (at least 10 units closer), switch to it
				if nearbyMob.distance < (currentDistance - 100) and nearbyMob.distance < 25 then
					shouldSwitchTarget = true
					break
				end
			end
		end
	end

	if isValidMob(mob) == false or player.target.type ~= "MONSTER" or shouldSwitchTarget then 
		if player.status=="Engaged"  then
			disengage()
			windower.ffxi.run(false)
		end
		local i =0
		local lowestDistance = 999
		lowestIndex = -1
		local combatDistance = 999
		local combatIndex = -1
		
		--while mob == nil or math.sqrt(mob.distance) > 50 or mob.hpp <= 0  do
		while i <= mobNum do
			currMob = windower.ffxi.get_mob_by_index(i)
			
			if currMob ~= nil and isValidMob(currMob) then
				-- Priority 1: If in combat but not engaged, prioritize very close mobs
				if player.in_combat and player.status ~= "Engaged" and currMob.distance < 25 and currMob.distance < combatDistance then
					combatDistance = currMob.distance
					combatIndex = i
				end
				-- Priority 2: Normal closest mob logic
				if currMob.distance < lowestDistance then
					lowestDistance = currMob.distance
					lowestIndex = i
				end
			end
				i = i +1		
		end
		
		-- Use combat priority mob if we found one, otherwise use closest
		if combatIndex ~= -1 then
			lowestIndex = combatIndex
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
	
	-- Lock on to target if engaged and not already locked
	if player.status == "Engaged" and not player.target_locked then
		send_command('input /lockon')
	end
	
	moveToMob(mob)
	prevMob = mob
	
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
	
	booleans = S{"magicburst", "deploy","rest", "automaneuver", "rune",  "autoHaste" ,"autoRoll","autoMagic", "provoke",  "swaps", "fire", "thunder", "water", "light", "dark", "wind", "earth", "activate", "mnkRecast", "warRecast", "samRecast", "drgRecast", "runRecast", "autoRunes", "runSpells", "automaneuver2", "autoRA", "bottin", "assist", "autoItem", "trusts", "wyvern", "autoClaim", "targetFilter", "debugBot"} --booleans
	
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
	targetFilter = false
	debugBot = false
	
	-- Approved target list - only these mobs can be targeted when filter is on
	approvedTargets = S{"Apex Eft", "Apex Crab", "Apex Bat", "Apex Tiger", "Apex Toad", "Apex Pugil"}
	cap = false
	autoClaim = false
	
	--job auto casts part of main auto loop
	automaneuver2 = false
	autoRoll = false	
	wyvern = false
	activate = false
	mnkRecast = false
	warRecast = false
	samRecast = false
	drgRecast = false
	runRecast = false
	autoRunes = false
	runSpells = false
	
	-- Auto-enable job-specific features
	if player.main_job == "DRG" then
		wyvern = true
	end
	
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
	if buffactive['Invisible'] then
		return
	end
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
		cancel_spell()
		return
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
    elseif string.find(spell.english,'Maneuver') then
		equip(sets.precast.maneuver)
	elseif string.find(spell.english,'Roll') or string.find(spell.english,'Phantom Roll') then
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
	-- Special handling for bottin command
	elseif command == "bottin" then
		bottin = booleanChange(bottin)
		if bottin == true then
			trusts = true
			autoClaim = true
			autoWS = true
			-- Enable job-specific recasts
			if player.main_job == "WAR" or player.sub_job == "WAR" then
				warRecast = true
			end
			if player.main_job == "DRG" then
				drgRecast = true
			end
			if player.main_job == "SAM" or player.sub_job == "SAM" then
				samRecast = true
			end
			if player.main_job == "MNK" then
				mnkRecast = true
			end
			if player.main_job == "RUN" then
				runRecast = true
			end
			add_to_chat(122, "bottin on")
		else 
			add_to_chat(122, "bottin off")
		end
---- bool toggle----	
	elseif booleans:contains(command) then		--turns booleans off or on, booleans must be in the commands section
		_G[command] = booleanChange(_G[command])
		if _G[command] == true then
			add_to_chat(122, command .. " on")
		else 
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
	elseif command == "am" then
		automaneuver = booleanChange(automaneuver)
		if automaneuver == true then
			add_to_chat(122, "automaneuver on")
		else 
			add_to_chat(122, "automaneuver off")
		end
	elseif command == "am2" then
		automaneuver2 = booleanChange(automaneuver2)
		if automaneuver2 == true then
			add_to_chat(122, "automaneuver2 on")
		else 
			add_to_chat(122, "automaneuver2 off")
		end
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
			add_to_chat(122, command .. " on123")
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
		
	elseif command == "checkTrust" then
		local oldDebug = debugBot
		debugBot = true  -- Force debug on for manual check
		local result = checkTrustMP()
		debugBot = oldDebug  -- Restore original setting
		if result then
			add_to_chat(122, "Trust check PASSED - party is ready")
		else
			add_to_chat(122, "Trust check FAILED - party not ready")
		end
		
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
    
	
