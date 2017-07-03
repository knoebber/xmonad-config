import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO


main = do
  xmproc <- spawnPipe "xmobar /home/nicolas/.xmonad/xmobarrc"
  xmonad $ defaultConfig
    { modMask            = mod4Mask
    , terminal           = "alacritty"
    , workspaces         = myWorkspaces
    , manageHook         = manageDocks <+> manageHook defaultConfig
    , layoutHook         = avoidStruts  $ layoutHook defaultConfig
    , handleEventHook    = handleEventHook defaultConfig <+> docksEventHook
    , logHook            = dynamicLogWithPP xmobarPP
    { ppOutput          = hPutStrLn xmproc
      , ppTitle          = xmobarColor "green" "black" . shorten 50
      , ppHiddenNoWindows = xmobarColor "gray" "black"
    }
    } `additionalKeys`
    [
      ((mod4Mask .|. shiftMask, xK_f), spawn "firefox")
    ]

myWorkspaces = names ++ map show [length names + 1..9]
               where names = ["web","dev","music"]

