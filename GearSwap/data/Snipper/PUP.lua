include('cdhelper.lua')
function get_sets() 
	-- Commands in game
	-- /gs c changeTP  switches between the list of modes in tpModes, equips the gear and sets it to current aftercast set
	-- /gs c "setName" quips the gear set and sets it to current aftercast set
	-- /gs c deploy puts autodeploy on, when you engage it will cast deploy
	-- /gs c automaneuver turns on automaneuver, when maneuvers wear it recasts them
	--/ in my init file (windower/scripts/init.txt) f9 is bound to sent /gs c changeTP 
	
	
	



----------------------------------------------------------------------Base sets-------------------------------------------------------------------------------

	
	modeSets["tpMode"].setModes = {"Default", "Pet", "Custom", "TA", "TH"} -- These are the sets that will cycle Modes, just make sure the set matches the name here ex: sets.TP.Name will equip if "Name" is in this list
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
	sets.midcast.Enfeebling = {head = "Tali'ah Turban +2", body="Malignance Tabard", feet="Malignance Boots",  hands="Malignance Gloves" }
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


	sets.base = {head="Mpaca's Cap",neck="Shulmanu Collar",
        ear1="Schere Earring",ear2="Brutal Earring",body="Mpaca's Doublet",hands="Mpaca's Gloves",
        ring1="Niqmaddu Ring",ring2="Epona's Ring", back=VisuciusTP,waist="Moonbow Belt +1",legs="Mpaca's Hose",
        feet="Mpaca's Boots"}
	--------------------------------------------------WS-----------------------------------------------------------------------
	sets.WS = set_combine(sets.base,{ head="Mpaca's Cap", hands="Ryuo Tekko",  legs="Mpaca's Hose", body="Mpaca's Doublet", ring1 =	"Niqmaddu Ring", ear1 ="Moonshade Earring", ear2="Brutal Earring", feet="Mpaca's Boots", back =VisuciusWS})
	sets.WS.Default = set_combine(sets.WS,{})
	sets.WS.Acc = set_combine(sets.WS,{ })	
    sets.precast.WS = sets.WS -- don't change
	
	sets.WS['Shijin Spiral'] = set_combine(sets.WS,{body="Tali'ah Manteel +2",  Neck="Light Gorget", back=VisuciusTP,})
	sets.WS['Shijin Spiral'].Acc = sets.WS['Shijin Spiral']
		
	
	sets.WS['Victory Smite'] = set_combine(sets.WS,{Neck="Light Gorget"})
	sets.WS['Victory Smite'].Acc = sets.WS['Victory Smite']
	
	sets.WS['Stringing Pummel'] = set_combine(sets.WS, { Neck="Soil Gorget"})
	sets.WS['Stringing Pummel'].Acc = sets.WS['Stringing Pummel']
	
	sets.WS['Howling Fist'] = set_combine(sets.WS,{Neck="Light Gorget", body="Foire Tobe +3", hands = "Pitre Dastanas +3"})
	sets.WS['Howling Fist'].Acc = sets.WS['Howling Fist']

		------------------------------------------DT-----------------------------------------------------------------------------------------------
	sets.DT = set_combine(sets.base, { neck="Loricate Torque",  ring2="Defending Ring", waist = "Moonbow Belt +1", body="Malignance Tabard",hands="Malignance Gloves" , feet="Malignance Boots"})
    sets.DT.Default = sets.DT
	sets.DT.Magic  = set_combine(sets.DT,{ring1="Dark Ring", ring2="Defending Ring"})
	sets.DT.Full = set_combine(sets.DT,{ring1="Dark Ring", ring2="Defending Ring", waist = "Moonbow Belt +1"})
	sets.DT.Custom = sets.DT
	-----------------------------------------------Tp---------------------------------------------------------------------------------------
    sets.TP = set_combine(sets.base,{})	 
	sets.TP.Current = sets.TP
	sets.TP.Default = set_combine(sets.TP,{})
    sets.TP.Acc = set_combine(sets.TP,{ hands="Malignance Gloves", head = "Mpaca's Cap", body="Malignance Tabard", feet="Malignance Boots"})	
	sets.TP.Haste = set_combine(sets.TP,{})	
    sets.TP.DT=  sets.DT 
	sets.TP.Pet= set_combine(sets.base,{
		head="Heyoka Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Heyoka Subligar",
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		right_ear="Brutal Earring",
		right_ring="Thurandaut Ring",
		back=VisuciusPet
	})	
	sets.TP.Custom = set_combine(sets.TP,{})
	sets.TP.TA = set_combine(sets.base, {head="Mpaca's Cap", body="Mpaca's Doublet", hands="Herculean Gloves", legs=hercLegsTA, feet=hercFeetTA})
	sets.TP.TH = set_combine(sets.TP, {legs="Volte Hose" })
	

	
	
	--------------------------------------------------------------------JA------------------------------------------------------------------
    sets.precast.JA['Tactical Switch'] = set_combine(sets.DT.Full, {feet="Karagoz Scarpe +1"})
    sets.precast.JA['Repair'] = set_combine(sets.DT.Full, {feet="Foire Babouches +3", ammo="Automat. Oil +3", ear1 ="Guignol Earring"})
	sets.precast.JA['Maintenance'] = sets.DT.Full
	sets.precast.JA['Overdrive'] = set_combine(sets.DT.Full, {body = "Pitre Tobe +3"})
	sets.precast.maneuver = set_combine(sets.DT.Full, {hands="Foire Dastanas +3", body="Karagoz Farsetto +1", neck="Buffoon's Collar", back= VisuciusPet, ear1 = "Burana Earring"})
	
	
	


	
	----------------------------------------------------Idle------------------------------------------------------------------
	sets.Idle = set_combine(sets.DT,{feet="Hermes' Sandals", back= "Moonbeam Cape"})
	sets.Idle.Current = sets.Idle
	sets.Idle.DT = set_combine(sets.DT,{})
	sets.Idle.Default = sets.Idle 
	sets.Idle.Pet = set_combine(sets.DT,{ring1="Thurandaut Ring"})
	sets.Idle.Custom = sets.Idle
	
	
	----------------------------------------------Pet-------------------------------------------------------------------------
	
	sets.midcast.Pet = {}	
	sets.midcast.Pet.Cure = { }
	sets.midcast.Pet['Elemental Magic'] = { 
		head="Mpaca's Cap",
    	body="Mpaca's Doublet",
    	hands="Mpaca's Gloves",
    	legs="Pitre Churidars +3",
    	feet="Pitre Babouches +2",
    	left_ear="Burana Earring"
	}
	sets.Pet= {}
	sets.Pet.base = set_combine(sets.base, {head="Taeon Chapeau", body="Pitre Tobe +3",hands ="Taeon Gloves", legs = "Karagoz Pantaloni +1", ring1="Thurandaut Ring",ring2="Varar Ring +1", waist ="Klouskap Sash", ear1="Handler's Earring +1",  ear2="Domes. Earring",  feet = "Taeon Boots", legs = "Taeon Tights", back=VisuciusPet})
	sets.Pet.Default = set_combine(sets.Pet.base, {})
	
	sets.Pet.WS = set_combine( sets.Pet.base,{ hands="Mpaca's Gloves",  feet= "Mpaca's Boots"} )
	sets.Pet.WS['Valoredge Frame'] = set_combine( sets.Pet.WS,{ head ='Taeon Chapeau', feet = "Taeon Boots", legs = "Taeon Tights", hands = "Taeon Gloves", ear1="Burana Earring", ring2="Overbearing Ring"})
	sets.Pet.WS['Sharpshot Frame'] = set_combine(sets.Pet.WS,{head = "Kara. Cappello +1", back="Dispersal Mantle",  ear2="Burana Earring",  legs = "Karagoz Pantaloni +1"})

	sets.Pet.Tank = set_combine(sets.Pet.base,{body = "Pitre Tobe +3",head = "Rao Kabuto", ear1="Handler's Earring +1", ear2="Handler's Earring",ring2="Varar Ring +1", feet = "Rao Sune-Ate", legs = "Tali'ah Sera. +2", hands = "Rao Kote", waist ="Isa Belt"})  	
 	
	sets.Pet.Custom = sets.Pet.base
	
	
		------------------------------------------------------After Cast---------------------------------------------
    sets.aftercast.TP = sets.TP 
	sets.aftercast.Idle = sets.Idle
	
	
	send_command('input /macro book 1;wait .1;input /macro set 9')
end

