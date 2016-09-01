--command event handler
SLASH_PM1, SHLASH_PM2 = '/pm', '/persistentmarks';
local function commandHandler(msg, editbox)
	if msg == "on" then
		print("[PersistentMarks] Enabled automatic Raid-Icons");
		PersistentMarksEnabled = true;
	elseif msg ==  "off" then
		print("[PersistentMarks] Disabled automatic Raid-Icons");
		PersistentMarksEnabled = false;
		return false;
	end
	setIconsForGroupMembers();
end
SlashCmdList["PM"] = commandHandler;

--world event handler
local function eventHandler(self, event, ...)
	if PersistentMarksEnabled == nil then
		PersistentMarksEnabled = false;
	end

	if PersistentMarksEnabled == false then
		return false; --dont do shit of disabled
	end
	print("[PersistentMarks] Setting Raidtargets");
	setIconsForGroupMembers();
end

local frame = CreateFrame("FRAME", "PersistentMarksFrame");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");
frame:RegisterEvent("RAID_ROSTER_UPDATE");
frame:SetScript("OnEvent", eventHandler);

--functions
function setIconsForGroupMembers()
	if GetNumGroupMembers() > 1 then --check if in grp
		for i = 1, GetNumGroupMembers() do
			local name, rang, grp, lvl, klasse, class, zone, online, tot = GetRaidRosterInfo(i);
			
			print("[PersistentMarks] Setting Mark "..getIconForClass(class).." for "..name.." "..class);
			SetRaidTarget("party"..i-1, getIconForClass(class)); --dirty as fuck i know, i-1 ... too lazy to figure out how to work with proper objects here 
		end	
		local playerClass, englishClass = UnitClass("player");
		SetRaidTarget("player", getIconForClass(englishClass));
	end
end

function getIconForClass(class)
	if class == 'MAGE' then
		return 6;
	elseif class == 'WARRIOR' then
		return 8;
	elseif class == 'DEATHKNIGHT' then
		return 7;
	elseif class == 'HUNTER' then
		return 4;
	elseif class == 'MONK' then
		return 4;
	elseif class == 'WARLOCK' then
		return 3;
	elseif class == 'ROGUE' then
		return 1;
	elseif class == 'DRUID' then
		return 2;
	elseif class == 'SHAMAN' then
		return 5;
	elseif class == 'DEMONHUNTER' then
		return 3;
	elseif class == 'PALADIN' then
		return 2;
	elseif class == 'PRIEST' then
		return 1;
	end
	return 0;
end
