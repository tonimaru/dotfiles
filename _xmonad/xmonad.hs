import XMonad
import XMonad.Layout.GridVariants
import XMonad.Layout.NoBorders
import XMonad.Layout.OneBig
import XMonad.Layout.ResizableTile
import XMonad.Util.EZConfig

main :: IO ()
main = xmonad $ defaultConfig
    { borderWidth = 1
    , normalBorderColor = "#222222"
    , focusedBorderColor = "#dddddd"
    , layoutHook = lsl ||| lst ||| lob ||| lfu
    , manageHook = composeAll [ title =? "Firefox Preferences" --> doFloat ]
    }
    `additionalKeysP` myKeys
    where
        lsl = smartBorders $ SplitGrid L 1 1 (4/5) (2/1) (3/100)
        lst = smartBorders $ SplitGrid T 1 1 (4/5) (8/1) (3/100)
        lfu = noBorders Full
        lob = smartBorders $ OneBig (4/5) (4/5)
        myKeys = [ ("M-S-;", spawn "gvim")
                 , ("M-d", sendMessage MirrorShrink)
                 , ("M-u", sendMessage MirrorExpand)
                 ]
