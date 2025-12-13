include('cdhelper.lua')

	currWS = "Shijin Spiral"
	currTP = 1000

function get_sets() 
	-- Commands in game
	-- /gs c changeTP  switches between the list of modes in tpModes, equips the gear and sets it to current aftercast set
	-- /gs c "setName" quips the gear set and sets it to current aftercast set
	-- /gs c deploy puts autodeploy on, when you engage it will cast deploy
	-- /gs c automaneuver turns on automaneuver, when maneuvers wear it recasts them
	--/ in my init file (windower/scripts/init.txt) f9 is bound to sent /gs c changeTP 
	
	
	

----------------------------------------------------------------------Base sets-------------------------------------------------------------------------------

	
	modeSets["tpMode"].setModes = {"Default", "Acc", "Pet", "Custom"} -- These are the sets that will cycle Modes, just make sure the set matches the name here ex: sets.TP.Name will equip if "Name" is in this list
	modeSets["dtMode"].setModes = {"Default",  "Full", "Custom"} --sets.DT.Mode
	modeSets["wsMode"].setModes = {"Default", "Acc"}  --sets.WS.Mode
	modeSets["idleMode"].setModes = {"Default", "Pet", "Custom"}
	modeSets["petMode"].setModes =  {"Default","Tank","Custom"}
	
	-- --- precast--------------------------------
	sets.precast = {}
	sets.precast.Magic = {}
	sets.precast.TP ={}			
	sets.precast.WS = {}
	sets.precast.JA = {}
	sets.precast.Magic = {}
	--------------midcast----------------------
	sets.midcast = {}
	sets.midcast.Enfeebling = {body="Tali'ah Manteel +2",head = "Tali'ah Turban +2", legs = "Tali'ah Sera. +1", feet="Tali'ah Crackows +1",  hands="Tali'ah Gages +1" }
	------------------aftercast----------------
	sets.aftercast = {}	
	--------------blue-------------------------
	sets.Blue = {}
	
	sets.Blue.Magic = {}
	sets.Blue.Physical = {}
	sets.Blue.Debuff = {}
	sets.Blue.Buff = {}
	sets.Blue.Cure = {}
	------------Nuke-------------------------
	sets.Nuke = {}


  
	sets.base = { head= hercHeadTP,
    body="Hiza. Haramaki +1",
    hands=hercHandsTP,
    legs="Tali'ah Sera. +1",
    feet=hercFeetTP,
    neck="Ej Necklace",
    waist="Hurch'lan Sash",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    ring1 =	"Niqmaddu Ring",
    ring2="Epona's Ring",
      back=VisuciusPet,}
	--------------------------------------------------WS-----------------------------------------------------------------------
	--sets.base.WS = set_combine(sets.base,{ head="Hizamaru Somen +1", hands="Ryuo Tekko",  legs="Hiza. Hizayoroi +1", body = "Hizamaru Haramaki"})	
	sets.WS = set_combine(sets.base,{ head="Hizamaru Somen +1",   legs="Hiza. Hizayoroi +2",  ring1 =	"Niqmaddu Ring", ear1 ="Moonshade Earring",  feet="Hiza. Sune-Ate +1", back =VisuciusWS})
	sets.WS.Default = set_combine(sets.WS,{ring1 = "Spiral Ring"})
	sets.WS.Acc = set_combine(sets.WS,{ neck="Shifting Necklace +1"})	
    sets.precast.WS = sets.WS -- don't change
	
	sets.WS['Shijin Spiral'] = set_combine(sets.WS,{body="Tali'ah Manteel +2",  Neck="Light Gorget", head = "Tali'ah Turban +1", back=VisuciusTP, feet="Malignance Boots"})
	sets.WS['Shijin Spiral'].Acc = sets.WS['Shijin Spiral']
		
	
	sets.WS['Victory Smite'] = set_combine(sets.WS,{Neck="Light Gorget"})
	sets.WS['Victory Smite'].Acc = sets.WS['Victory Smite']
	
	sets.WS['Stringing Pummel'] = set_combine(sets.WS, { Neck="Soil Gorget"})
	sets.WS['Stringing Pummel'].Acc = sets.WS['Stringing Pummel']
	
	sets.WS['Howling Fist'] = set_combine(sets.WS,{Neck="Light Gorget"})
	sets.WS['Howling Fist'].Acc = sets.WS['Howling Fist']

		------------------------------------------DT-----------------------------------------------------------------------------------------------
	sets.DT = set_combine(sets.base, { head="Malignance Chapeau", neck="Twilight Torque",  ring2="Defending Ring", waist = "Moonbow Belt", feet="Malignance Boots"})
    sets.DT.Default = sets.DT
	sets.DT.Magic  = set_combine(sets.DT,{neck="Twilight Torque", ring1="Dark Ring", ring2="Defending Ring", feet="Malignance Boots"})
	sets.DT.Full = set_combine(sets.DT,{  back="Moonbeam Cape",neck="Twilight Torque", ring1="Dark Ring", ring2="Defending Ring", waist = "Moonbow Belt",  feet="Malignance Boots"})
	sets.DT.Custom = sets.DT
	-----------------------------------------------Tp---------------------------------------------------------------------------------------
    sets.TP = set_combine(sets.base,{})	 
	sets.TP.Current = sets.TP
	sets.TP.Default = set_combine(sets.TP,{})
    sets.TP.Acc = set_combine(sets.TP,{ })	
	sets.TP.Custom = set_combine(sets.TP,{})
	

	
	
	--------------------------------------------------------------------JA------------------------------------------------------------------
    --sets.precast.JA['Tactical Switch'] = {feet="Cirque Scarpe +2"}	
    sets.precast.JA['Repair'] = {feet="Foire Babouches +1", ammo="Automat. Oil +3"}	
	sets.precast.JA['Maintenance'] = {ammo="Automat. Oil +1"}
	sets.precast.JA['Overdrive'] = {body = "Pitre Tobe +3"}
	sets.precast.maneuver = { hands="Foire Dastanas +1", body="Karagoz Farsetto", neck="Buffoon's Collar", back= VisuciusPet, ear1 = "Burana Earring"}
	
	
	


	
	----------------------------------------------------Idle------------------------------------------------------------------
	sets.Idle = set_combine(sets.DT,{feet="Hermes' Sandals", body ="Hiza. Haramaki +1"})
	sets.Idle.Current = sets.Idle
	sets.Idle.DT = set_combine(sets.DT,{})
	sets.Idle.Default = sets.Idle 
	sets.Idle.Custom = sets.Idle
	
	
	----------------------------------------------Pet-------------------------------------------------------------------------
	
	sets.midcast.Pet = {}	
	sets.midcast.Pet.Cure = { }
	sets.midcast.Pet['Elemental Magic'] = {}
	sets.Pet= {}
	sets.Pet.base = set_combine(sets.base, {  feet = "Tali'ah Crackows +1",  back=VisuciusPet, head = "Tali'ah Turban +1"})
	sets.Pet.Default = set_combine(sets.Pet.base, {})
	
	sets.Pet.WS = set_combine( sets.Pet.base,{ hands="Cirque Guanti +2",  feet= "Naga Kyahan"} )
	sets.Pet.WS['Valoredge Frame'] = set_combine( sets.Pet.WS,{legs = "Taeon Tights", ear1="Burana Earring", ring2="Overbearing Ring"} )
	sets.Pet.WS['Sharpshot Frame'] = set_combine(sets.Pet.WS,{head = "Karagoz Capello +1", back="Dispersal Mantle",  ear2="Burana Earring", waist="Isa Belt",  legs = "Tali'ah Sera. +1"})
	
	sets.Pet.Tank = set_combine(sets.Pet.base,{body = "Pitre Tobe +3",head = "Rao Kabuto", ear1="Handler's Earring +1", ear2="Handler's Earring",ring2="Varar Ring +1", feet = "Rao Sune-Ate", legs = "Tali'ah Sera. +1", hands = "Rao Kote", waist ="Isa Belt"})  	
 	
	sets.Pet.Custom = sets.Pet.base
	
	
		------------------------------------------------------After Cast---------------------------------------------
    sets.aftercast.TP = sets.TP 
	sets.aftercast.Idle = sets.Idle
	
	
	send_command('input /macro book 1;wait .1;input /macro set 9')
end

