local character, super = Class(PartyMember, "spamton")

function character:init()
    super:init(self)

    -- Display name
    self.name = "Spamton"

	
	self.strings=38
	self.isbig=false
    -- Actor (handles overworld/battle sprites)
    self:setActor("spamton")
    self:setLightActor("spamton")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    if Game.chapter == 2 then
        self.title = "Salesman\nScams enemies out\nof their KROMER."
    else
        self.title = "Big Shot\nThe big one."
    end

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1, 0, 0}

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "SP-Action"
	
	self:addSpell("help")
	self:addSpell("bigdeal")

    -- Current health (saved to the save file)
	self.health=150

    -- Base stats (saved to the save file)
    
    self.stats = {
        health = 150,
        attack = 8,
        defense = 0,
        magic = 5
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/sword"

    -- Equipment (saved to the save file)
    self:setWeapon("puppetstring")
    self:setArmor(1, "frayedbowtie")
    self:setArmor(2, "dealmaker")

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {1, 1, 1}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    --self.dmg_color = {0.5, 1, 0.5}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    --self.attack_bar_color = {181/255, 230/255, 29/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    --self.attack_box_color = {0, 0.5, 0}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    --self.xact_color = {0.5, 1, 0.5}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/spamton/head"
    -- Path to head icons used in battle
    self.head_icons = "party/spamton/icon"
    -- Name sprite (TODO: optional)
    self.name_sprite = "party/spamton/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/bite"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1

    -- Battle position offset (optional)
    self.battle_offset = {0, 15}
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = nil
end

function character:onLevelUp(level)
    -- TODO: Maybe allow chapter 1 levelups?
    if Game.chapter == 1 then return end

    self:increaseStat("health", 2, 197)
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
    end
end

function character:onPowerSelect(menu)
	menu.kromer_count=math.random(1,23)
end

function character:drawPowerStat(index, x, y, menu)
	if index==1 then
		local icon = Assets.getTexture("ui/menu/icon/kromer")
		love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
		love.graphics.print("KROMER:", x, y)
		love.graphics.print(menu.kromer_count, x+130, y)
		return true
	elseif index==2 then
		local icon = Assets.getTexture("ui/menu/icon/strings")
		love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
		love.graphics.print("Strings:", x, y)
		if not(self.isbig)then
			love.graphics.print(self.strings, x+130, y)
		else
			love.graphics.print(0, x+130, y)
		end
		return true
	elseif index==3 then
		love.graphics.print("[[BIG]]:", x, y)
		if(self.isbig)then
			love.graphics.print("Yes", x+130, y)
		else
			love.graphics.print("No", x+130, y)
		end
		return true
	end
end
return character
