vRP = Proxy.getInterface("vRP") 
vRPclient = Tunnel.getInterface("vRP", "JM")

-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------

	exports.ox_target:addSphereZone({
	coords = vec3(484.2286, -993.8629, 30.6413),
	radius = 1.2,
	debug = Config.Debug,
	options = {
	{
		name = 'sphere',
		event = 'JM:Client:RankCheck',
		icon = 'fa-solid fa-database',
		label = 'Open the Forensic laptop',
	}
	}
	})

RegisterNetEvent('vRP:Client:RankCheck')
AddEventHandler('JM:Client:RankCheck', function()
	TriggerServerEvent('JM:Server:RankCheck')
end)

-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
lib.registerContext({
	id = 'Los_Santos_Police_Forensics',
	title = Config.Name,
	options = {
	--   {
	-- 	title = 'Check Money',
	-- 	description = 'Check if the money that you have a suspicion about',
	-- 	icon = 'fa-solid fa-server',
	-- 	onSelect = function()
	-- 		TriggerEvent('JM:Client:Spinner')
	-- 	end,
	--   },
	--   {
	-- 	title = 'Check Money',
	-- 	description = 'Check if the money that you have a suspicion about',
	-- 	icon = 'fa-solid fa-server',
	-- 	onSelect = function()
	-- 		TriggerServerEvent('JM:Server:CheckDirtyMoney')
	-- 	end,
	--   },
	  {
		title = 'Check Money',
		description = 'Check if the money that you have a suspicion about',
		icon = 'fa-solid fa-server',
		onSelect = function()
			TriggerEvent('JM:Client:Skill')
		end,
	  }
	}
  })


RegisterNetEvent('JM:Client:Menu:Open')
AddEventHandler('JM:Client:Menu:Open', function()
	lib.showContext('Los_Santos_Police_Forensics')
end)
-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
if Config.Debug then 
	RegisterCommand('LSPF:Debug', function()
		lib.showContext('Los_Santos_Police_Forensics')
	end)
end




RegisterNetEvent('JM:Client:Skill', function()
	local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 2}, 'easy'}, {'w', 'a', 's', 'd'})

	if success then 
		TriggerEvent('JM:Client:Spinner')
	else
		lib.notify({title = Config.Name, description = 'The system is not 100% sure', type = 'error'})
		TriggerServerEvent('JM:Server:random')
	end
end)


RegisterNetEvent('JM:Client:Spinner')
AddEventHandler('JM:Client:Spinner', function()
	-- before the spinner
	lib.notify({title = Config.Name, description = 'The system analyzes. Wait', type = 'inform'})

	-- the spinner
	AddTextEntry('vRP:Money:Analyze', Config.Analyze)
	BeginTextCommandBusyspinnerOn('vRP:Money:Analyze')
	EndTextCommandBusyspinnerOn(3)
	Wait(10000)
	BusyspinnerOff()

	-- Ater it's done with the spinner
	lib.notify({title = Config.Name, description = 'The system is done with the analyze', type = 'success'})
	Wait(1)
	TriggerServerEvent('JM:Server:CheckDirtyMoney')
end)