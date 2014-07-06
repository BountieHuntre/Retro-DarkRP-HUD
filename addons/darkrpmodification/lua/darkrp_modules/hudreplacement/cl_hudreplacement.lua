/*------------------------
Retro HUD 2D
Created by BountieHuntre
------------------------*/

local hideHUDElements = {
	["DarkRP_HUD"] = true,
	["DarkRP_EntityDisplay"] = false,
	["DarkRP_ZombieInfo"] = false,
	["DarkRP_LocalPlayerHUD"] = false,
	["DarkRP_Hungermod"] = false,
	["DarkRP_Agenda"] = false
}

hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
	if hideHUDElements[name] then return false end
end)


local function formatNumber(n)

	if not n then return "" end
	if n >= 1e14 then return tostring(n) end
	n = tostring(n)
	local sep = sep or ","
	local dp = string.find(n, "%.") or #n+1
	for i=dp-4, 1, -3 do
		n = n:sub(1, i) .. sep .. n:sub(i+1)
	end
	return n
	
end

local function hudHealth()

	local Health = LocalPlayer():Health() or 0
	if Health < 0 then Health = 0 elseif Health > 100 then Health = 100 end
	local DrawHealth = math.Min(Health/GAMEMODE.Config.startinghealth, 1)
	
	draw.RoundedBox(0, ScrW()-ScrW()+95, ScrH()-36, ScrW()-ScrW()+103, ScrH()-ScrH()+12, Color(0,0,0,255))
	if Health != 0 then
		draw.RoundedBox(0, ScrW()-ScrW()+97, ScrH()-35, ScrW()-ScrW()+100*DrawHealth, ScrH()-ScrH()+10, Color(255,0,0,255))
	elseif Health == 0 then
		Health = "Dead"
	end
	
	draw.DrawText("Health: "..Health, "TCB_BebasNeue_1", ScrW()-ScrW()+18, ScrH()-39, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
	
end

local function hudArmor()

	local Armor = LocalPlayer():Armor() or 0
	if Armor < 0 then Armor = 0 elseif Armor > 100 then Armor = 100 end
	if Armor == 0 then
		Armor = "None"
	end
	
	draw.DrawText("Armor: "..Armor, "TCB_BebasNeue_1", ScrW()-ScrW()+20, ScrH()-20, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
	
end
	
local function hudName()

	local Name = LocalPlayer():Nick() or nil
	
	draw.DrawText(Name, "TCB_BebasNeue_2", ScrW()/2, ScrH()-38, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
end

local function hudMoney()

	local Money = formatNumber(LocalPlayer():getDarkRPVar("money") or 0)

	draw.DrawText("$"..Money, "TCB_BebasNeue_1", ScrW()-ScrW()+425, ScrH()-39, Color(255,255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT)
	
end

local function hudSalary()

	draw.DrawText("+", "TCB_BebasNeue_1", ScrW()-ScrW()+375, ScrH()-20, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
	
	local Salary = formatNumber(LocalPlayer():getDarkRPVar("salary") or 0)
	
	draw.DrawText("$"..Salary, "TCB_BebasNeue_1", ScrW()-ScrW()+425, ScrH()-20, Color(255,255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT)
	
end

local function hudJob()

	local Job = LocalPlayer():getDarkRPVar("job") or ""
	
	draw.DrawText(Job, "TCB_BebasNeue_3", ScrW()/2+310, ScrH()-34, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
end

local iconLicense	= "icon16/page_red.png"
local iconWanted	= "icon16/exclamation.png"

local function hudIcons()

	if LocalPlayer():getDarkRPVar("HasGunlicense") then
		surface.SetDrawColor(255,255,255,255)
	else
		surface.SetDrawColor(25,25,25,255)
	end
	surface.SetMaterial(Material(iconLicense))
	surface.DrawTexturedRect(ScrW()-150, ScrH()-30, 20, 20)
	
	if LocalPlayer():getDarkRPVar("wanted") then
		surface.SetDrawColor(255,255,255,255)
	else
		surface.SetDrawColor(25,25,25,255)
	end
	surface.SetMaterial(Material(iconWanted))
	surface.DrawTexturedRect(ScrW()-100, ScrH()-30, 20, 20)
	
end

local function hudPaint()
	draw.RoundedBox(0, ScrW()-ScrW(), ScrH()-41, ScrW(), ScrH()-ScrH()+42, Color(50,50,50,255))

	hudHealth()
	hudArmor()
	hudName()
	hudMoney()
	hudSalary()
	hudJob()
	hudIcons()
	
	
end
hook.Add("HUDPaint", "DarkRP_Mod_HUDPaint", hudPaint)


/*----------------
Credit
TheCodingBeast
----------------*/