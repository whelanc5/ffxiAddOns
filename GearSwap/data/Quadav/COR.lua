
include('cdhelper.lua')


function get_sets() 
	-- Commands in game
	-- /gs c changeTP  switches between the list of modes in tpModes, equips the gear and sets it to current aftercast set
	-- /gs c "setName" quips the gear set and sets it to current aftercast set
	-- /gs c deploy puts autodeploy on, when you engage it will cast deploy
	-- /gs c automaneuver turns on automaneuver, when maneuvers wear it recasts them
	--/ in my init file (windower/scripts/init.txt) f9 is bound to sent /gs c changeTP 
	
	

	
	
	currWS = "Savage Blade"
	currTP=1000
	claimJA = "dia"
-------------------------------------------modes---------------------------------------------------------------------------------
-- These are the sets that will cycle Modes, just make sure the set matches the name here ex: sets.TP.Name will equip if "Name" is in this list
-- remove modes by deleting the string, make sure not to leave an extra comma
-- All modes should have a "Default" entry
	modeSets["tpMode"].setModes = {"Custom", "Acc", "Haste" } -- These are the sets that will cycle Modes, just make sure the set matches the name here ex: sets.TP.Name will equip if "Name" is in this list
	modeSets["dtMode"].setModes = {"Default", "Custom"} --sets.DT.Mode
	modeSets["wsMode"].setModes = {"Default", "Acc"}  --sets.WS.Mode
	modeSets["idleMode"].setModes = {"Default", "Custom"}
	modeSets["rangeMode"].setModes = {"Default"}
	
	
	
	----------------------------------------------------------------------Base sets---------------------------------------------------------------------------------
	-- i use this to use sets_combine to make other sets.
	
	tpEar1 = "Bladeborn Earring"
	tpEar2="Steelflash Earring"	
		
	if player.sub_job == 'NIN' then
		tpEar1="Dudgeon Earring" 
		tpEar2="Heartseeker Earring"
	end
	
	sets.base ={
    head="Malignance Chapeau",   
    body="Mummu Jacket +2",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet= "Malignance Boots",
    neck="Iskur Gorget",
    waist="Hurch'lan Sash",
	ear1 = tpEar1,
	ear2 = tpEar2,
    left_ring="Meghanada Ring",
    right_ring="Epona's Ring",
    back=CamulusbackTP,
} -- Base set. Can use this as a base for other sets


	----------------------------------------------------------------Precast------------------------------------------------------------------------------------------
	sets.precast = {}
	sets.precast.Magic = {}
	sets.precast.TP ={}			
	sets.precast.JA = {}
	sets.precast.JA['Wild Card'] = {feet = "Lanun Bottes +3"}
	sets.precast.Magic = {}
	sets.precast.Roll = {left_ring="Barataria Ring"}

	----------------------------------------------------------------Midcast------------------------------------------------------------------------------------------
	sets.midcast = {}
			----------------------------------------------------------------AFTERCAST----------------------------------------------------------------------------------------	
	sets.aftercast = {}	
	  
  
	----------------------------------------------------------------MAGIC--------------------------------------------------------------------------------------------
	sets.midcast.Magic = {}	
	sets.midcast.Elemental = {}	
	sets.midcast.Healing = nil --set to a set if going to be used
	sets.precast.Magic.Healing = nil --set to a set if going to be used

	----------------------------------------------------------------JA-----------------------------------------------------------------------------------------------
	-- put sets.precast.JA['Spell Name'] = {set} to equip before using a ja
	-- ex: sets.precast.JA['Tactical Switch'] = {feet="Cirque Scarpe +2"}	.
	sets.precast.Waltz = {} -- sets for curing waltz
	sets.precast.maneuver = {} -- sets for manuevers
	sets.precast.Quickdraw = {right_ear="Friomisi Earring",left_ear = "Hecate's Earring", head="Mummu Bonnet +2",
    body="Mummu Jacket +2",
    hands="Mummu Wrists +2",
    legs="Mummu Kecks +2",
    feet="Mummu Gamash. +2",
    neck="Sanctity Necklace",
    waist="Kwahu Kachina Belt",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring"}
	----------------------------------------------------------------TP-----------------------------------------------------------------------------------------------
	sets.TP = set_combine(sets.base,{ })	 -- base set for TP gear
	sets.TP.Current = sets.TP -- don't change this
	sets.aftercast.TP = sets.TP -- don't change this
	sets.TP.Custom = sets.TP -- don't change this
	sets.TP.Default = sets.TP -- don't change this
    sets.TP.Acc = set_combine(sets.TP,{ head="Meghanada Visor +2",    feet="Meg. Jam. +2"})
	sets.TP.Haste = set_combine(sets.TP,{body = "Rawhide Vest", waist = "Windbuffet Belt"})	
 	
	
	----------------------------------------------------------------DT-----------------------------------------------------------------------------------------------
	sets.DT = set_combine(sets.base, {head="Malignance Chapeau",  body="Meg. Cuirie +2",   hands="Malignance Gloves", left_ring="Meghanada Ring"})
    sets.DT.Default = sets.DT -- don't change this
	sets.DT.Custom = sets.DT -- don't change this
	sets.DT.Magic  = set_combine(sets.DT,{})
	sets.DT.Full = set_combine(sets.DT,{})
	
	----------------------------------------------------------------IDLE---------------------------------------------------------------------------------------------
	sets.Idle = set_combine(sets.DT,{neck="Bathy Choker",feet="Hermes' Sandals"}) -- base set for idle
	sets.aftercast.Idle = sets.Idle -- don't change this
	sets.Idle.Current = sets.Idle -- don't change this
	sets.Idle.Default = sets.Idle -- don't change this
	sets.Idle.Custom = sets.Idle -- don't change this
	sets.Idle.DT = set_combine(sets.Idle,{})

	----------------------------------------------------------------BLUE---------------------------------------------------------------------------------------------
	sets.Blue = {}
	sets.Blue.Magic = {}
	sets.Blue.Physical = {}
	sets.Blue.Debuff = {}
	sets.Blue.Buff = {}
	sets.Blue.Cure = {}

	----------------------------------------------------------------WS-----------------------------------------------------------------------------------------------
	sets.WS= set_combine(sets.base,{ ammo="Eminent Bullet",head="Meghanada Visor +2", body="Meg. Cuirie +2",hands="Meg. Gloves +2", ear1 ="Moonshade Earring", feet = "Lanun Bottes +3", 
	neck ='Lacono Neck. +1' , waist = "Prosilio Belt +1", left_ring="Ifrit Ring", right_ring="Ifrit Ring", back= CamulusbackAGI})--base set for weaponskill that isn't named
	sets.WS.Rng = set_combine(sets.base,{ ammo="Eminent Bullet",head="Meghanada Visor +2", body="Meg. Cuirie +2",hands="Meg. Gloves +2", ear1 ="Moonshade Earring", feet = "Lanun Bottes +3", 
	neck ='Iskur Gorget' ,  left_ring="Garuda Ring", right_ring="Hajduk Ring",back= CamulusbackAGI, waist = "Kwahu Kachina Belt"})--base set for weaponskill that isn't named
	sets.precast.WS = sets.WS -- -- don't change this 
	sets.WS.Default = sets.WS -- don't change this
	sets.WS.Acc = set_combine(sets.WS,{})
	sets.WS['Last Stand'] = set_combine(sets.WS.Rng,{ ammo="Eminent Bullet",head="Meghanada Visor +2", body="Meg. Cuirie +2",hands="Meg. Gloves +2",  feet="Meg. Jam. +2"})
	sets.WS['Leaden Salute'] = set_combine(sets.WS.Rng, {waist = "Eschan Stone", neck="Sanctity Necklace", head = "Pixie Hairpin +1", right_ring="Apate Ring", right_ear="Friomisi Earring", body = "Rawhide Vest", legs = hercLegsMAB, feet = hercFeetMAB, hands = hercHandsMAB})
	sets.WS['Savage Blade'] =  set_combine(sets.WS, {head = hercHeadTP}) 
  
	----sets.WS['Shijin Spiral'] = {ring1 = "Rajas Ring", Neck="Light Gorget" }


	

	----------------------------------------------------------------Range----------------------------------------------------------------------------------------------
	sets.Ranged = set_combine(sets.base,{ ammo = "Eminent Bullet", head="Malignance Chapeau",  body="Nisroch Jerkin",  hands="Meg. Gloves +2",   feet="Meg. Jam. +2", left_ring="Apate Ring", right_ring="Hajduk Ring",	 back=CamulusbackAGI, waist = "Kwahu Kachina Belt", neck ='Iskur Gorget' })
	sets.midcast.Ranged = set_combine(sets.Ranged,{})
	sets.precast.Ranged  = set_combine(sets.Ranged,{ammo = "Eminent Bullet",legs = "Nahtirah Trousers",feet="Meg. Jam. +2"})
	----------------------------------------------------macro book--------------------------------------------------
	--set the book and set to your jobs macro set
	send_command('input /macro book 2;wait .1;input /macro set 9')
end


