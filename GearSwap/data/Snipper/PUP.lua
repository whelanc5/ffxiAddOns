include('cdhelper.lua')
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
	sets.midcast.Enfeebling = {head = "Tali'ah Turban +2", legs = "Tali'ah Sera. +1", body="Malignance Tabard", feet="Malignance Boots",  hands="Malignance Gloves" }
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


	sets.base = {head="Herculean Helm",neck="Shulmanu Collar",
        ear1="Schere Earring",ear2="Brutal Earring",body="Malignance Tabard",hands="Herculean Gloves",
        ring1="Niqmaddu Ring",ring2="Epona's Ring", back=VisuciusTP,waist="Moonbow Belt",legs= hercLegsTA,
        feet= hercFeetTA}
	--------------------------------------------------WS-----------------------------------------------------------------------
	--sets.base.WS = set_combine(sets.base,{ head="Hizamaru Somen +1", hands="Ryuo Tekko",  legs="Hiza. Hizayoroi +1", body = "Hizamaru Haramaki"})	
	sets.WS = set_combine(sets.base,{ head="Hizamaru Somen +2", hands="Ryuo Tekko",  legs="Hiza. Hizayoroi +2", body = "Pitre Tobe +3", ring1 =	"Niqmaddu Ring", ear1 ="Moonshade Earring", ear2="Brutal Earring", feet="Hiza. Sune-Ate +1", back =VisuciusWS})
	sets.WS.Default = set_combine(sets.WS,{})
	sets.WS.Acc = set_combine(sets.WS,{ })	
    sets.precast.WS = sets.WS -- don't change
	
	sets.WS['Shijin Spiral'] = set_combine(sets.WS,{body="Tali'ah Manteel +2",  Neck="Light Gorget", head = "Tali'ah Turban +2", back=VisuciusTP, feet="Malignance Boots"})
	sets.WS['Shijin Spiral'].Acc = sets.WS['Shijin Spiral']
		
	
	sets.WS['Victory Smite'] = set_combine(sets.WS,{Neck="Light Gorget"})
	sets.WS['Victory Smite'].Acc = sets.WS['Victory Smite']
	
	sets.WS['Stringing Pummel'] = set_combine(sets.WS, { Neck="Soil Gorget"})
	sets.WS['Stringing Pummel'].Acc = sets.WS['Stringing Pummel']
	
	sets.WS['Howling Fist'] = set_combine(sets.WS,{Neck="Light Gorget"})
	sets.WS['Howling Fist'].Acc = sets.WS['Howling Fist']

		------------------------------------------DT-----------------------------------------------------------------------------------------------
	sets.DT = set_combine(sets.base, { neck="Loricate Torque",  ring2="Defending Ring", waist = "Moonbow Belt", body="Malignance Tabard",hands="Malignance Gloves" , feet="Malignance Boots"})
    sets.DT.Default = sets.DT
	sets.DT.Magic  = set_combine(sets.DT,{neck="Twilight Torque", ring1="Dark Ring", ring2="Defending Ring"})
	sets.DT.Full = set_combine(sets.DT,{  back="Moonbeam Cape",neck="Twilight Torque", ring1="Dark Ring", ring2="Defending Ring", waist = "Moonbow Belt"})
	sets.DT.Custom = sets.DT
	-----------------------------------------------Tp---------------------------------------------------------------------------------------
    sets.TP = set_combine(sets.base,{})	 
	sets.TP.Current = sets.TP
	sets.TP.Default = set_combine(sets.TP,{})
    sets.TP.Acc = set_combine(sets.TP,{ hands="Malignance Gloves", head = "Tali'ah Turban +2", body="Malignance Tabard", feet="Malignance Boots"})	
	sets.TP.Haste = set_combine(sets.TP,{})	
    sets.TP.DT=  sets.DT 
	sets.TP.Pet= set_combine(sets.base,{ring1="Thurandaut Ring"})	
	sets.TP.Custom = set_combine(sets.TP,{})
	

	
	
	--------------------------------------------------------------------JA------------------------------------------------------------------
    --sets.precast.JA['Tactical Switch'] = {feet="Cirque Scarpe +2"}	
    sets.precast.JA['Repair'] = {feet="Foire Babouches +1", ammo="Automat. Oil +3", ear1 ="Guignol Earring"}	
	sets.precast.JA['Maintenance'] = {ammo="Automat. Oil +1"}
	sets.precast.JA['Overdrive'] = {body = "Pitre Tobe +3"}
	sets.precast.maneuver = { hands="Foire Dastanas +1", body="Karagoz Farsetto", neck="Buffoon's Collar", back= VisuciusPet, ear1 = "Burana Earring"}
	
	
	


	
	----------------------------------------------------Idle------------------------------------------------------------------
	sets.Idle = set_combine(sets.DT,{feet="Hermes' Sandals", body ="Hiza. Haramaki +2", back= "Moonbeam Cape"})
	sets.Idle.Current = sets.Idle
	sets.Idle.DT = set_combine(sets.DT,{})
	sets.Idle.Default = sets.Idle 
	sets.Idle.Pet = set_combine(sets.DT,{ring1="Thurandaut Ring"})
	sets.Idle.Custom = sets.Idle
	
	
	----------------------------------------------Pet-------------------------------------------------------------------------
	
	sets.midcast.Pet = {}	
	sets.midcast.Pet.Cure = { }
	sets.midcast.Pet['Elemental Magic'] = {}
	sets.Pet= {}
	sets.Pet.base = set_combine(sets.base, {head="Taeon Chapeau", body="Pitre Tobe +3",hands ="Taeon Gloves", ring1="Thurandaut Ring",ring2="Varar Ring +1", waist ="Klouskap Sash", ear1="Handler's Earring +1",  ear2="Domes. Earring",  feet = "Taeon Boots", legs = "Taeon Tights", back=VisuciusPet})
	sets.Pet.Default = set_combine(sets.Pet.base, {})
	
	sets.Pet.WS = set_combine( sets.Pet.base,{ hands="Cirque Guanti +2",  feet= "Naga Kyahan"} )
	sets.Pet.WS['Valoredge Frame'] = set_combine( sets.Pet.WS,{ head ='Taeon Chapeau', feet = "Taeon Boots", legs = "Taeon Tights", hands = "Taeon Gloves", ear1="Burana Earring", ring2="Overbearing Ring"} )
	sets.Pet.WS['Sharpshot Frame'] = set_combine(sets.Pet.WS,{head = "Karagoz Capello +1", back="Dispersal Mantle",  ear2="Burana Earring", waist="Isa Belt",  legs = "Tali'ah Sera. +2"})
	
	sets.Pet.Tank = set_combine(sets.Pet.base,{body = "Pitre Tobe +3",head = "Rao Kabuto", ear1="Handler's Earring +1", ear2="Handler's Earring",ring2="Varar Ring +1", feet = "Rao Sune-Ate", legs = "Tali'ah Sera. +2", hands = "Rao Kote", waist ="Isa Belt"})  	
 	
	sets.Pet.Custom = sets.Pet.base
	
	
		------------------------------------------------------After Cast---------------------------------------------
    sets.aftercast.TP = sets.TP 
	sets.aftercast.Idle = sets.Idle
	
	
	send_command('input /macro book 1;wait .1;input /macro set 9')
end

