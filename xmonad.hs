-- ~/.xmonad/xmonad.hs
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Actions.UpdatePointer
import XMonad.Util.Run

main :: IO ()
main = do
      xmproc <- spawnPipe "xmobar"
      xmonad def {
            modMask              = myModMask
            , layoutHook         = myLayoutHook
            , manageHook         = manageDocks <+> myManageHook
                                    <+> manageHook def
            , logHook            = dynamicLogWithPP xmobarPP -- 今選択しているパネルの情報を出力
                                       { ppOutput = hPutStrLn xmproc
                                       , ppTitle  = xmobarColor "green" "" . shorten 50
                                       }
                                     >> updatePointer (0.5, 0.5) (0, 0)
            , handleEventHook    = handleEventHook def <+> docksEventHook -- 最初のワークスペースでxmobarが後ろに隠れてしまう問題を解決
            , borderWidth        = 5                     -- 周りの枠線の太さ
            , normalBorderColor  = "#e6e6e6"             -- 枠の色
            , focusedBorderColor = "#ff0000"             -- 選択枠の色
            , terminal           = "urxvt"               -- 起動端末
            , startupHook        = setWMName "LG3D"      -- Java GUI
          }

myModMask = mod1Mask -- udevで無変換キーをAltにする． /etc/udev/hwdb.d

myLayoutHook = avoidStruts $ layoutHook def
myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "VirtualBox" --> doFloat
    ]
