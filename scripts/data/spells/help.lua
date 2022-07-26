local spell, super = Class(Spell, "help")

function spell:init()
    super:init(self)

    -- Display name
    self.name = "HELP"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Heal All\nRandom HP"
    -- Menu description
    self.description = "Restores HP to all party members. \nExtremely volatile,depends on Magic."

    -- TP cost
    self.cost = 32

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "party"

    -- Tags that apply to this spell
    self.tags = {"heal"}
end


function spell:onStart(user, target)
    Game.battle:battleText(self:getCastMessage(user, target))
    user:setAnimation("battle/act", function()
        local result = self:onCast(user, target)
        if result or result == nil then
            Game.battle:finishActionBy(user)
        end
    end)
end

function spell:onCast(user, target)
    for _,battler in ipairs(target) do
        battler:heal(math.random(1,user.chara:getStat("magic") * 5.5))
    end
end
return spell
