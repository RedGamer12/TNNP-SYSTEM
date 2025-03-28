_G.Configs = {
    allowed_actions = {
        AutoBounty = true,  -- Automatically targets players for bounty
        Team = "Marines",   -- Default team (Options: "Pirates", "Marines")
        AutoView = false,   -- Automatically changes camera view
        Limited = 70,      -- Time limit for certain actions
        Continue = 10,      -- Number of allowed continuous actions
        RandomATK = 20,     -- Random attack interval in seconds
        IgnoreFruits = {"Buddha-Buddha", "Leopard-Leopard", "Portal-Portal", "Kitsune-Kitsune"},  -- Fruits to ignore during attack or farm
        Webhook = {
            Enabled = true,  -- Enables sending logs to a Discord webhook
            Logs = {PlayerStatus = true, Console = false},  -- Log settings for Webhook
            URL = "" -- The Discord webhook URL for logging actions
        },
        Dodge = true,  -- Semi-auto dodge mechanic to avoid attacks
        Race = {
            V3 = {Enabled = true, Settings = {
                Human = 8500,  -- Uses Human V3 race when HP is below 8500
                Shark = {Stun = 2}  -- Uses Shark V3 race when stunned for more than 2 seconds
            }},
            V4 = {Enabled = true, UseAt = 12000}  -- Uses V4 race when HP is below 12000
        },
        MethodClicks = {Gun = false, Melee = true, Sword = false, CanM1At = 8000, Count = 4, Delay = 0.175},  -- Click attack method configuration
        SafeZone = {
            Enabled = true,  -- Safe Zone feature enabled to prevent attacks in protected areas
            ProtectCD = true,  -- Prevents action when under cooldown protection
            LowestHealth = 50,  -- Minimum health percentage for safe zone entry
            HighestHealth = 50,  -- Maximum health percentage for safe zone exit
            Max = 12000  -- Max height limit for safe zone check
        },
        Ken = true,  -- Automatically enables Ken haki when available
        Random = false,  -- Randomly uses skills from all available abilities
        Weapons = {
            Melee = {
                Enable = true,  -- Enables melee weapon attacks
                Skills = {
                    Z = {Enable = true, HoldTime = 0.35, Number = 4},  -- Melee Z skill configuration
                    X = {Enable = true, HoldTime = 0.2, Number = 3},   -- Melee X skill configuration
                    C = {Enable = true, HoldTime = 0.3, Number = 2}    -- Melee C skill configuration
                },
            },
            ["Blox Fruit"] = {
                Enable = true,  -- Disables Blox Fruit abilities (can be set to true for enabling)
                Skills = {
                    Z = {Enable = true, HoldTime = 0.5, Number = 6},  -- Blox Fruit Z skill
                    X = {Enable = true, HoldTime = 0.25, Number = 5},  -- Blox Fruit X skill
                    C = {Enable = true, HoldTime = 0.13, Number = 1}, -- Blox Fruit C skill (disabled by default)
                    V = {Enable = false, HoldTime = 0.1, Number = 7}, -- Blox Fruit V skill (disabled by default)
                    F = {Enable = false, HoldTime = 0.1, Number = 7}  -- Blox Fruit F skill (disabled by default)
                },
            },
            Gun = {
                Enable = false,  -- Enables gun weapon attacks
                Skills = {
                    Z = {Enable = true, HoldTime = 0.15, Number = 5},  -- Gun Z skill configuration
                    X = {Enable = true, HoldTime = 0.16, Number = 1}   -- Gun X skill configuration
                },
            },
            Sword = {
                Enable = false,  -- Disables sword weapon attacks (can be set to true for enabling)
                Skills = {
                    Z = {Enable = true, HoldTime = 1.75, Number = 5},  -- Sword Z skill configuration
                    X = {Enable = true, HoldTime = 2.3, Number = 3}    -- Sword X skill configuration
                },
            },
        }
    },
    Performance = {
        WhiteScreen = false,  -- Disables white screen for better performance
        BlackScreen = {
            Enabled = false,  -- Enables black screen to save performance (disabled by default)
            Font = Enum.Font.FredokaOne,  -- Font for displaying messages on the black screen
            Transparency = 0.25  -- Transparency level for the black screen
        },
    }
}
