import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Util.EZConfig

myLayouts = s ||| m ||| f
        where s = smartBorders $ ResizableTall 1 (3/100) (2/3) []
              m = Mirror s
              f = noBorders Full

myKeys = [ ("M-S-;", spawn "gvim")
         , ("M-d", sendMessage MirrorShrink)
         , ("M-u", sendMessage MirrorExpand) ]

myManageHook = composeAll [ title =? "Firefox Preferences" --> doFloat ]

main = xmonad $ defaultConfig
    { borderWidth = 1
    , normalBorderColor = "#222222"
    , focusedBorderColor = "#dddddd"
    , layoutHook = myLayouts
    , manageHook = myManageHook
    }
    `additionalKeysP` myKeys

