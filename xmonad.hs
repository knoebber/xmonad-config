import XMonad

main = do
  xmonad $ defaultConfig
    { terminal    = myTerminal
    , modMask     = myModMask
    , borderWidth = myBorderWidth
    }

myTerminal    = "alacritty"
myModMask     = mod4Mask
myBorderWidth = 3
