import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmonad $ defaultConfig
        { terminal   = "alacritty"
        , manageHook = manageDocks <+> manageHook defaultConfig -- need to find out what these 2 do
        , layoutHook = avoidStruts  $  layoutHook defaultConfig -- avoidStruts?
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_f), spawn "firefox") -- super shift f
        , ((controlMask .|. shiftMask, xK_s), spawn "scrot") -- super shift s, doesn't seem to work yet
        ]
