include('cdhelper.lua')
function get_sets()   
	
-- Commands in game
	-- /gs c changeTP  switches between the list of modes in tpModes, equips the gear and sets it to current aftercast set
	-- /gs c "setName" quips the gear set and sets it to current aftercast set   
	--/ in my init file (windower/scripts/init.txt) f9 is bound to sent /gs c changeTP 	
    
	
	modeSets["tpMode"].setModes = {"Default", "Acc", "Custom"} -- These are the sets that will cycle Modes, just make sure the set matches the name here ex: sets.TP.Name will equip if "Name" is in this list
	modeSets["dtMode"].setModes = {"Default",  "Full", "Custom"} --sets.DT.Mode
	modeSets["wsMode"].setModes = {"Default", "Acc"}  --sets.WS.Mode
	modeSets["idleMode"].setModes = {"Default",  "Custom"}
		
	-- --- precast--------------------------------
	sets.precast = {}
	sets.precast.Magic = {}
	sets.precast.TP ={}			
	sets.precast.WS = {}
	sets.precast.JA = {}
	sets.precast.Magic = {}
	--------------midcast----------------------
	sets.midcast = {}
	sets.midcast.Enfeebling = {}
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


	sets.base = {
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands=hercGlovesTA,
		legs="Mpaca's Hose",
		feet=hercFeetTA,
		neck="Anu Torque",
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back=SegomoTP
	}
	--------------------------------------------------WS-----------------------------------------------------------------------
	--sets.base.WS = set_combine(sets.base,{ head="Hizamaru Somen +1", hands="Ryuo Tekko",  legs="Hiza. Hizayoroi +1", body = "Hizamaru Haramaki"})	
	sets.WS = set_combine(sets.base,{hands="Ryuo Tekko", ring1 =	"Niqmaddu Ring", ear1 ="Moonshade Earring", ear2="Sherida Earring"})
	sets.WS.Default = set_combine(sets.WS,{})
	sets.WS.Acc = set_combine(sets.WS,{ })	
    sets.precast.WS = sets.WS -- don't change
	
	sets.WS['Shijin Spiral'] = set_combine(sets.WS,{  Neck="Light Gorget",   feet="Malignance Boots"})
	sets.WS['Shijin Spiral'].Acc = sets.WS['Shijin Spiral']
		
	
	sets.WS['Victory Smite'] = set_combine(sets.WS,{Neck="Light Gorget"})
	sets.WS['Victory Smite'].Acc = sets.WS['Victory Smite']
	
	sets.WS['Stringing Pummel'] = set_combine(sets.WS, { Neck="Soil Gorget"})
	sets.WS['Stringing Pummel'].Acc = sets.WS['Stringing Pummel']
	
	sets.WS['Howling Fist'] = set_combine(sets.WS,{Neck="Light Gorget"})
	sets.WS['Howling Fist'].Acc = sets.WS['Howling Fist']

		------------------------------------------DT-----------------------------------------------------------------------------------------------
	sets.DT = set_combine(sets.base, {
		hands="Mpaca's Gloves",
		feet="Mpaca's Boots",
		neck="Loricate Torque",
		right_ring="Defending Ring"
	})
    sets.DT.Default = sets.DT
	sets.DT.Magic  = set_combine(sets.DT,{neck="Twilight Torque", left_ring="Dark Ring"})
	sets.DT.Full = set_combine(sets.DT,{
		body="Malignance Tabard",
		hands="Malignance Gloves",
		feet="Malignance Boots",
		back="Moonbeam Cape"
	})
	sets.DT.Custom = sets.DT
	-----------------------------------------------Tp---------------------------------------------------------------------------------------
    sets.TP = set_combine(sets.base,{})	 
	sets.TP.Current = sets.TP
	sets.TP.Default = set_combine(sets.TP,{})
    sets.TP.Acc = set_combine(sets.TP,{ hands="Malignance Gloves", feet="Malignance Boots"})	
	sets.TP.Haste = set_combine(sets.TP,{})	
    sets.TP.DT=  sets.DT 
	sets.TP.Custom = set_combine(sets.TP,{})
	

	
	
	--------------------------------------------------------------------JA------------------------------------------------------------------
   	
	----------------------------------------------------Idle------------------------------------------------------------------
	sets.Idle = set_combine(sets.DT,{feet="Hermes' Sandals"})
	sets.Idle.Current = sets.Idle
	sets.Idle.DT = set_combine(sets.DT,{})
	sets.Idle.Default = sets.Idle 
	sets.Idle.Custom = sets.Idle
	
	
		------------------------------------------------------After Cast---------------------------------------------
    sets.aftercast.TP = sets.TP 
	sets.aftercast.Idle = sets.Idle
	
    send_command('input /macro book 3;wait .1;input /macro set 1')
end

