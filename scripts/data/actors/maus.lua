return {
    -- ID of the actor (optional, defaults to filepath)
    id = "maus",

    -- Width and height of the actor (if unsure, just use sprite size)
    width = 35,
    height = 18,

    flip = "right",

    -- In-world hitbox, relative to the actor's topleft
    -- (these numbers are based on the actual deltarune hitbox)
    hitbox = {0, 6, 35, 12},

    -- Path to the actor's sprites
    path = "enemies/maus",
    -- Default animation or sprite relative to the path
    default = "idle",

    animations = {
        -- Looping animation with 0.25 seconds between each frame
        -- (even though there's only 1 idle frame)
        ["idle"] = {"idle", 0.2, true, frames={1, 2, 1, 2, 1, 3, 4, 5}},
    },

    offsets = {
        -- Since the width and height is the idle sprite size, the offset is 0,0
        ["idle"] = {0, 0},
    },
}