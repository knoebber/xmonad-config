import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/nicolas/.xmonad/xmobarrc"
    xmonad $ defaultConfig
        { terminal   = "alacritty"
        , manageHook = manageDocks <+> manageHook defaultConfig -- need to find out what these 2 do
        , layoutHook = avoidStruts  $  layoutHook defaultConfig -- avoidStruts?
        , logHook    = dynamicLogWithPP xmobarPP
                           { ppOutput = hPutStrLn xmproc
                           , ppTitle  = xmobarColor "green" "" . shorten 50
                           }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_f), spawn "firefox") -- super shift f
        , ((controlMask .|. shiftMask, xK_s), spawn "scrot") -- super shift s, doesn't to work yet
        ]
