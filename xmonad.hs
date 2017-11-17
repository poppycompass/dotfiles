-- ~/.xmonad/xmonad.hs
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
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
            , handleEventHook    = handleEventHook def <+> docksEventHook -- 最初のワークスペースでxmobarが後ろに隠れてしまう問題を解決
            , borderWidth        = 3                     -- 周りの枠線の太さ
            , normalBorderColor  = "#e6e6e6"             -- 枠の色
            , focusedBorderColor = "#ff0000"             -- 選択枠の色
            , terminal           = "urxvt"               -- 起動端末
          }

myModMask = mod1Mask -- ~/.Xmodmapで無変換キーをAltにする． keycode 102 = Alt_L Alt_L Alt_L Alt_L Alt_L, 数値(102)はxevで確認

myLayoutHook = avoidStruts $ layoutHook def
myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "VirtualBox" --> doFloat
    ]

myLogHook h  = dynamicLogWithPP xmobarPP {
                   ppOutput = hPutStrLn h
                 }
