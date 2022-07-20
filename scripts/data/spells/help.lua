local spell, super = Class(Spell, "help")

function spell:init()
    super:init(self)

    -- Display name
    self.name = "HELP"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Heal\nAlly...?"
    -- Menu description
    self.description = "[Press F1 For] HELP!\n[[Magic]] DEPEND."

    -- TP cost
    self.cost = 32

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

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
    target:heal((user.chara:getStat("magic")+4) * 5)
end

return spell