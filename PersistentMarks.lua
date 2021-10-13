PersistentMarks = LibStub("AceAddon-3.0"):NewAddon("PersistentMarks", "AceConsole-3.0", "AceEvent-3.0")

local raidtargets = {"", "Star", "Circle", "Diamond", "Triangle",
            "Moon", "Square", "Cross", "Skull"}

local options = {
    name = "PersistentMarks - Type /pm or /persistentmarks to toggle marks",
    handler = PersistentMarks,
    type = "group",
    args = {
        general = {
			order = 1,
			type = "group",
			name = 'General',
			cmdInline = true,
			args = {
                autoSetIcons = {
                    type = "toggle",
                    name = "Set Marks automatically (Loadscreen, Entering Combat)",
                    get = "IsAutoSetIcons",
                    set = "ToggleAutoSetIcons",
                    width = "full",
                    order = -1
                },
                header = {
                    type = "header",
                    name = "General Settings",
                    width = "full",
                    order = 0
                }
            }
        },
        classIcons = {
			order = 2,
			type = "group",
			name = 'Class-Marks',
			cmdInline = true,
			args = {
                header = {
                    type = "header",
                    name = "Select Marks for Classes",
                    width = "full",
                    order = 0
                },
                warriorIcon = {
                    type = "select",
                    name = "Warrior Icon",
                    values = raidtargets,
                    get = "GetWarriorIcon",
                    set = "SetWarriorIcon"
                },
                paladinIcon = {
                    type = "select",
                    name = "Paladin Icon",
                    values = raidtargets,
                    get = "GetPaladinIcon",
                    set = "SetPaladinIcon",
                },
                hunterIcon = {
                    type = "select",
                    name = "Hunter Icon",
                    values = raidtargets,
                    get = "GetHunterIcon",
                    set = "SetHunterIcon",
                },
                rogueIcon = {
                    type = "select",
                    name = "Rogue Icon",
                    values = raidtargets,
                    get = "GetRogueIcon",
                    set = "SetRogueIcon",
                },
                priestIcon = {
                    type = "select",
                    name = "Priest Icon",
                    values = raidtargets,
                    get = "GetPriestIcon",
                    set = "SetPriestIcon",
                },
                deathknightIcon = {
                    type = "select",
                    name = "Deathknight Icon",
                    values = raidtargets,
                    get = "GetDeathknightIcon",
                    set = "SetDeathknightIcon",
                },
                shamanIcon = {
                    type = "select",
                    name = "Shaman Icon",
                    values = raidtargets,
                    get = "GetShamanIcon",
                    set = "SetShamanIcon",
                },
                mageIcon = {
                    type = "select",
                    name = "Mage Icon",
                    values = raidtargets,
                    get = "GetMageIcon",
                    set = "SetMageIcon",
                },
                warlockIcon = {
                    type = "select",
                    name = "Warlock Icon",
                    values = raidtargets,
                    get = "GetWarlockIcon",
                    set = "SetWarlockIcon",
                },
                monkIcon = {
                    type = "select",
                    name = "Monk Icon",
                    values = raidtargets,
                    get = "GetMonkIcon",
                    set = "SetMonkIcon",
                },
                druidIcon = {
                    type = "select",
                    name = "Druid Icon",
                    values = raidtargets,
                    get = "GetDruidIcon",
                    set = "SetDruidIcon",
                },
                demonhunterIcon = {
                    type = "select",
                    name = "Demonhunter Icon",
                    values = raidtargets,
                    get = "GetDemonhunterIcon",
                    set = "SetDemonhunterIcon",
                }
            }
        },
        nameIcons = {
			order = 3,
			type = "group",
			name = 'Player-Marks',
			cmdInline = true,
			args = {
                header = {
                    type = "header",
                    name = "Set Player-Names for Icons",
                    width = "full",
                    order = 0
                },
                starName = {
                    type = "input",
                    name = "Star",
                    get = "GetStarName",
                    set = "SetStarName",
                },
                circleName = {
                   type = "input",
                    name = "Circle",
                    get = "GetCircleName",
                    set = "SetCircleName",
                },
                diamondName = {
                    type = "input",
                    name = "Diamond",
                    get = "GetDiamondName",
                    set = "SetDiamondName",
                },
                triangleName = {
                    type = "input",
                    name = "Triangle",
                    get = "GetTriangleName",
                    set = "SetTriangleName",
                },
                moonName = {
                    type = "input",
                    name = "Moon",
                    get = "GetMoonName",
                    set = "SetMoonName",
                },
                squareName = {
                    type = "input",
                    name = "Square",
                    get = "GetSquareName",
                    set = "SetSquareName",
                },
                crossName = {
                    type = "input",
                    name = "Cross",
                    get = "GetCrossName",
                    set = "SetCrossName",
                },
                skullName = {
                    type = "input",
                    name = "Skull",
                    get = "GetSkullName",
                    set = "SetSkullName",
                },
            }
        },
    },
}

local defaults = {
    profile =  {
        autoSetIcons = false
    },
}

function PersistentMarks:OnInitialize()
    -- Called when the addon is loaded
    self.db = LibStub("AceDB-3.0"):New("PersistentMarksDB", defaults, true)

    LibStub("AceConfig-3.0"):RegisterOptionsTable("PersistentMarks", options, nil)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PersistentMarks", "PersistentMarks")
    self:RegisterChatCommand("pm", "ChatCommand")
    self:RegisterChatCommand("persistentmarks", "ChatCommand")

    options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	options.args.profiles.order = -2
end

function PersistentMarks:OnEnable()
    -- Called when the addon is enabled
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
end

function PersistentMarks:PLAYER_ENTERING_WORLD()
	if self.db.profile.autoSetIcons then
		--self:Print("Automatically settings marks");
        PersistentMarks:setIconsForGroupMembers()
    end
end

function PersistentMarks:PLAYER_REGEN_DISABLED()
	if self.db.profile.autoSetIcons then
		--self:Print("Automatically settings marks");
        PersistentMarks:setIconsForGroupMembers()
    end
end


function PersistentMarks:ChatCommand(input)
    if input == "clear" then
        self:Print("Clearing Marks")
        PersistentMarks:resetRaidtargets()
        return
    end

    if input == "options" or input == "settings" or input == "config" then
	    InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
        return
    end

    self:Print("Setting Marks")
	PersistentMarks:setIconsForGroupMembers()
end

--logic
function PersistentMarks:setIconsForGroupMembers()
	--self:Print("Setting Marks.")
	PersistentMarks:resetRaidtargets()
	for i = 1, GetNumGroupMembers() do
		local name, rang, grp, lvl, klasse, class, zone, online, tot = GetRaidRosterInfo(i)
		if online then
			local icon = PersistentMarks:getIconForClassOrName(class, name)
            if icon == nil then
                return
            end
            icon = icon-1
            --self:Print("Setting Mark "..icon.." for "..name.." "..class)
            SetRaidTarget("party"..i-1, icon)
		end
	end	
	local playerClass, englishClass = UnitClass("player")
	local icon = PersistentMarks:getIconForClassOrName(englishClass, UnitName("player"))
    if icon == nil then
        return
    end
    icon = icon-1
    --self:Print("Setting Mark "..icon.." for player")
    SetRaidTarget("player", icon)
end

function PersistentMarks:resetRaidtargets()
	for i = 0, 9 do
		SetRaidTarget("player", i);
	end
end

function PersistentMarks:getIconForClassOrName(class, name)
    if name == PersistentMarks:GetStarName() then
        return 2 --we use the index of our raitargets-list (dirty). subtracting in setIconsForGroupMembers
    elseif name == PersistentMarks:GetCircleName() then
        return 3
    elseif name == PersistentMarks:GetDiamondName() then
        return 4
    elseif name == PersistentMarks:GetTriangleName() then
        return 5
    elseif name == PersistentMarks:GetMoonName() then
        return 6
    elseif name == PersistentMarks:GetSquareName() then
        return 7
    elseif name == PersistentMarks:GetCrossName() then
        return 8
    elseif name == PersistentMarks:GetSkullName() then
        return 9
    end

	if class == 'MAGE' then
		return PersistentMarks:GetMageIcon()
	elseif class == 'WARRIOR' then
		return PersistentMarks:GetWarriorIcon()
	elseif class == 'DEATHKNIGHT' then
		return PersistentMarks:GetDemonhunterIcon()
	elseif class == 'HUNTER' then
		return PersistentMarks:GetHunterIcon()
	elseif class == 'MONK' then
		return PersistentMarks:GetMonkIcon()
	elseif class == 'WARLOCK' then
		return PersistentMarks:GetWarlockIcon()
	elseif class == 'ROGUE' then
		return PersistentMarks:GetRogueIcon()
	elseif class == 'DRUID' then
		return PersistentMarks:GetDruidIcon()
	elseif class == 'SHAMAN' then
		return PersistentMarks:GetShamanIcon()
	elseif class == 'DEMONHUNTER' then
		return PersistentMarks:GetDemonhunterIcon()
	elseif class == 'PALADIN' then
		return PersistentMarks:GetPaladinIcon()
	elseif class == 'PRIEST' then
		return PersistentMarks:GetPriestIcon()
	end
	return 0;
end

--check if icon is usable
function PersistentMarks:RemovePresentIcons(icon)
	if self.db.profile.warriorIcon == icon then
		self.db.profile.warriorIcon = 0
	elseif self.db.profile.paladinIcon == icon then
	    self.db.profile.paladinIcon = 0
	elseif self.db.profile.hunterIcon == icon then
	    self.db.profile.hunterIcon = 0
	elseif self.db.profile.rogueIcon == icon then
		self.db.profile.rogueIcon = 0
	elseif self.db.profile.priestIcon == icon then
	    self.db.profile.priestIcon = 0
	elseif self.db.profile.deathknightIcon == icon then
	    self.db.profile.deathknightIcon = 0
	elseif self.db.profile.shamanIcon == icon then
		 self.db.profile.shamanIcon = 0
	elseif self.db.profile.mageIcon == icon then
	    self.db.profile.mageIcon = 0
	elseif self.db.profile.warlockIcon == icon then
	    self.db.profile.warlockIcon = 0
	elseif self.db.profile.monkIcon == icon then
		self.db.profile.monkIcon = 0
	elseif self.db.profile.druidIcon == icon then
	    self.db.profile.druidIcon = 0
	elseif self.db.profile.demonhunterIcon == icon then
	   self.db.profile.demonhunterIcon = 0
	end
end

--getters/setters
function PersistentMarks:GetWarriorIcon(info)
    return self.db.profile.warriorIcon
end

function PersistentMarks:SetWarriorIcon(info, newValue)
	PersistentMarks:RemovePresentIcons(newValue)
    self.db.profile.warriorIcon = newValue
end

function PersistentMarks:GetPaladinIcon(info)
    return self.db.profile.paladinIcon
end

function PersistentMarks:SetPaladinIcon(info, newValue)
	PersistentMarks:RemovePresentIcons(newValue)
    self.db.profile.paladinIcon = newValue
end

function PersistentMarks:GetHunterIcon(info)
    return self.db.profile.hunterIcon
end

function PersistentMarks:SetHunterIcon(info, newValue)
	PersistentMarks:RemovePresentIcons(newValue)
    self.db.profile.hunterIcon = newValue
end

function PersistentMarks:GetRogueIcon(info)
    return self.db.profile.rogueIcon
end

function PersistentMarks:SetRogueIcon(info, newValue)
	PersistentMarks:RemovePresentIcons(newValue)
    self.db.profile.rogueIcon = newValue
end

function PersistentMarks:GetPriestIcon(info)
    return self.db.profile.priestIcon
end

function PersistentMarks:SetPriestIcon(info, newValue)
	PersistentMarks:RemovePresentIcons(newValue)
    self.db.profile.priestIcon = newValue
end

function PersistentMarks:GetDeathknightIcon(info)
    return self.db.profile.deathknightIcon
end

function PersistentMarks:SetDeathknightIcon(info, newValue)
	PersistentMarks:RemovePresentIcons(newValue)
    self.db.profile.deathknightIcon = newValue
end

function PersistentMarks:GetShamanIcon(info)
    return self.db.profile.shamanIcon
end

function PersistentMarks:SetShamanIcon(info, newValue)
	PersistentMarks:RemovePresentIcons(newValue)
   	self.db.profile.shamanIcon = newValue
end

function PersistentMarks:GetMageIcon(info)
    return self.db.profile.mageIcon
end

function PersistentMarks:SetMageIcon(info, newValue)
	PersistentMarks:RemovePresentIcons(newValue)
    self.db.profile.mageIcon = newValue
end

function PersistentMarks:GetWarlockIcon(info)
    return self.db.profile.warlockIcon
end

function PersistentMarks:SetWarlockIcon(info, newValue)
	PersistentMarks:RemovePresentIcons(newValue)
    self.db.profile.warlockIcon = newValue
end

function PersistentMarks:GetMonkIcon(info)
    return self.db.profile.monkIcon
end

function PersistentMarks:SetMonkIcon(info, newValue)
	PersistentMarks:RemovePresentIcons(newValue)
    self.db.profile.monkIcon = newValue
end

function PersistentMarks:GetDruidIcon(info)
    return self.db.profile.druidIcon
end

function PersistentMarks:SetDruidIcon(info, newValue)
	PersistentMarks:RemovePresentIcons(newValue)
    self.db.profile.druidIcon = newValue
end

function PersistentMarks:GetDemonhunterIcon(info)
    return self.db.profile.demonhunterIcon
end

function PersistentMarks:SetDemonhunterIcon(info, newValue)
	PersistentMarks:RemovePresentIcons(newValue)
    self.db.profile.demonhunterIcon = newValue
end

function PersistentMarks:ToggleAutoSetIcons(info, value)
    self.db.profile.autoSetIcons = value
end

function PersistentMarks:IsAutoSetIcons(info)
    return self.db.profile.autoSetIcons
end
--getters/setters for name mapping
function PersistentMarks:SetStarName(info, newValue)
    self.db.profile.starName = newValue
end

function PersistentMarks:GetStarName(info)
    return self.db.profile.starName
end

function PersistentMarks:SetCircleName(info, newValue)
    self.db.profile.circleName = newValue
end

function PersistentMarks:GetCircleName(info)
    return self.db.profile.circleName
end

function PersistentMarks:SetDiamondName(info, newValue)
    self.db.profile.diamondName = newValue
end

function PersistentMarks:GetDiamondName(info)
    return self.db.profile.diamondName
end

function PersistentMarks:SetTriangleName(info, newValue)
    self.db.profile.triangleName = newValue
end

function PersistentMarks:GetTriangleName(info)
    return self.db.profile.triangleName
end

function PersistentMarks:SetMoonName(info, newValue)
    self.db.profile.moonName = newValue
end

function PersistentMarks:GetMoonName(info)
    return self.db.profile.moonName
end

function PersistentMarks:SetSquareName(info, newValue)
    self.db.profile.squareName = newValue
end

function PersistentMarks:GetSquareName(info)
    return self.db.profile.squareName
end

function PersistentMarks:SetCrossName(info, newValue)
    self.db.profile.crossName = newValue
end

function PersistentMarks:GetCrossName(info)
    return self.db.profile.crossName
end

function PersistentMarks:SetSkullName(info, newValue)
    self.db.profile.skullName = newValue
end

function PersistentMarks:GetSkullName(info)
    return self.db.profile.skullName
end