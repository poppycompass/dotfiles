-- ~/.xmonad/xmonad.hs
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run

main :: IO ()
main = do
      myStatusBar <- spawnPipe "xmobar"
      xmonad defaultConfig {
            modMask              = myModMask
            , layoutHook         = myLayoutHook
            , manageHook         = manageDocks <+> myManageHook
                                    <+> manageHook defaultConfig
            , logHook            = myLogHook myStatusBar
            , borderWidth        = 3                     -- 周りの枠線の太さ
            , normalBorderColor  = "#e6e6e6"             -- 枠の色
            , focusedBorderColor = "#ff0000"             -- 選択枠の色
            , terminal           = "urxvt"               -- 起動端末
          }

myModMask = mod3Mask -- ~/.Xmodmapでmod3を無変換キーに束縛．それをModキーに適応

myLayoutHook = avoidStruts $ layoutHook defaultConfig
myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    ]


myLogHook h  = dynamicLogWithPP xmobarPP {
                   ppOutput = hPutStrLn h
                 }
