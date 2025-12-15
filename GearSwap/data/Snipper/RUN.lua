include('cdhelper.lua')
currWS = 'Resolution'
	

function get_sets() 
	-- Commands in game
	-- /gs c changeTP  switches between the list of modes in tpModes, equips the gear and sets it to current aftercast set
	-- /gs c "setName" quips the gear set and sets it to current aftercast set
	-- /gs c deploy puts autodeploy on, when you engage it will cast deploy
	-- /gs c automaneuver turns on automaneuver, when maneuvers wear it recasts them
	--/ in my init file (windower/scripts/init.txt) f9 is bound to sent /gs c changeTP 
	
	
	

----------------------------------------------------------------------Base sets-------------------------------------------------------------------------------

	
	modeSets["tpMode"].setModes = {"Default","Tank", "DT","Acc","Custom"} -- These are the sets that will cycle Modes, just make sure the set matches the name here ex: sets.TP.Name will equip if "Name" is in this list
	modeSets["dtMode"].setModes = {"Default", "Magic", "Full", "Custom"} --sets.DT.Mode
	modeSets["wsMode"].setModes = {"Default", "Acc"}  --sets.WS.Mode
	modeSets["idleMode"].setModes = {"Default","Custom"}
	modeSets["tankMode"].setModes = {"Default","DT"}
	-- --- precast--------------------------------
	sets.precast = {}
	sets.precast.Magic = {}
	sets.precast.TP ={}			
	sets.precast.WS = {}
	sets.precast.JA = {}
	sets.precast.Magic = {}
	--------------midcast----------------------
	sets.midcast = {}
	------------------aftercast----------------
	sets.aftercast = {}	
	--------------blue-------------------------
	sets.Blue = {}
	sets.Blue.Magic = {}
	sets.Blue.Physical = {}
	sets.Blue.Debuff = {}
	sets.Blue.Buff = {}
	sets.Blue.Cure = {}


	sets.base = {
		ammo="Honed Tathlum",
		head="Herculean Helm",
		ear1="Brutal Earring",
		ear2="Sherida Earring",
		body="Rawhide Vest",
		hands="Herculean Gloves",
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring", 
		waist="Ioskeha Belt",
		legs= hercLegsTA,
		feet= hercFeetTA, 
		back=OgmaTP
	}
	--------------------------------------------------WS-----------------------------------------------------------------------
	sets.WS = set_combine(sets.base,{body="Meg. Cuirie +2", hands="Meg. Gloves +2", legs = "Meghanada Chausses +2",ear1 ="Moonshade Earring" , head="Meghanada Visor +2"})
	sets.WS.Default = set_combine(sets.WS,{})
	sets.WS.Acc = set_combine(sets.WS,{ })	
    sets.precast.WS = sets.WS -- don't change
	sets.WS['Resolution'] = set_combine(sets.WS, {
		head={ name="Herculean Helm", augments={'Accuracy+22','"Triple Atk."+3','Attack+7',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+16','"Triple Atk."+3','DEX+1',}},
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','INT+3','Attack+13',}},
		neck="Soil Gorget", 
		waist="Ioskeha Belt", -- Change to 'Soil Belt' if you want the WS damage boost
		back=OgmaWS
	})




	
	--------------------------------------------------------------------JA------------------------------------------------------------------

	
	
	------------------------------------------DT-----------------------------------------------------------------------------------------------
	sets.DT = set_combine(sets.base,{
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Meg. Gloves +2",
		legs="Aya. Cosciales +2",
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','INT+3','Attack+13',}},
		neck="Twilight Torque",
		waist="Flume Belt",
		left_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -3%','Phys. dmg. taken -5%',}},
		right_ring="Defending Ring",
		back=OgmaDT
	})
    sets.DT.Default = set_combine(sets.DT,{})
	sets.DT.Magic  = set_combine(sets.DT,{})
	sets.DT.Full = sets.DT
	sets.DT.Custom = sets.DT
	
	------------------------------------------------------After Cast---------------------------------------------
    
  
	
	----------------------------------------------------Idle------------------------------------------------------------------
	sets.Idle = set_combine(sets.DT,{feet="Hermes' Sandals"})
	sets.Idle.Current = sets.Idle
	sets.Idle.DT = set_combine(sets.DT,{})
	sets.Idle.Default = sets.Idle 
	sets.Idle.Custom = sets.Idle
	sets.aftercast.Idle = sets.Idle
	
	
	
	sets.Tank =  set_combine(sets.base,{body="Meg. Cuirie +2", neck="Twilight Torque", back="Ogma's Cape", waist = "Flume Belt",  head="Meghanada Visor +2"})
	sets.Tank.DT =  set_combine(sets.DT,{})
	sets.Tank.Default = sets.Tank
	sets.Tank.Custom = sets.Tank
		-----------------------------------------------Tp---------------------------------------------------------------------------------------
    sets.TP = set_combine(sets.base,{
		head={ name="Herculean Helm", augments={'Accuracy+22','"Triple Atk."+3','Attack+7',}},
		body="Ayanmo Corazza +2",
		hands={ name="Herculean Gloves", augments={'Accuracy+16','"Triple Atk."+3','DEX+1',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','INT+3','Attack+13',}},
		neck="Anu Torque",
		waist="Ioskeha Belt",
		left_ear="Brutal Earring",
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back=OgmaTP
	})
	sets.aftercast.TP = sets.TP  
	sets.TP.Current = sets.TP
	sets.TP.Default = set_combine(sets.TP,{})
    sets.TP.Acc = set_combine(sets.TP,{body="Meg. Cuirie +2", hands="Meg. Gloves +2",body="Meg. Cuirie +2"})	
	sets.TP.Haste = set_combine(sets.TP,{})	
    sets.TP.DT =  set_combine(sets.DT,{back="Ogma's Cape"})
	sets.TP.Tank =  set_combine(sets.DT,{back="Ogma's Cape"})

	sets.TP.Custom = set_combine(sets.TP,{})
	
	send_command('input /macro book 9;wait .1;input /macro set 1')
end

