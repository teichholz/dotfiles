import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map        as M


myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- close focused window
    [ ((modm, xK_w), kill) ]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ def
        { modMask = mod4Mask
        , keys = myKeys `M.union` keys
        , terminal = "kitty"
        }
