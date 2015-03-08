module Halogen.HTML.Forms 
  ( onValueChanged
  , onChecked
  ) where
    
import DOM

import Data.Maybe
import Data.Either
import Data.Foreign
import Data.Foreign.Class

import Halogen.HTML.Attributes
  
-- | Attach an event handler which will produce an input when the value of an input field changes
-- |
-- | An input will not be produced if the value cannot be cast to the appropriate type.
onValueChanged :: forall value i. (IsForeign value) => (value -> i) -> Attribute i
onValueChanged f = unsafeHandler' "change" \e -> f <$> readValue e.target
  where
  readValue :: Node -> Maybe value
  readValue = either (const Nothing) Just <<< readProp "value" <<< toForeign
  
-- | Attach an event handler which will fire when a checkbox is checked or unchecked
onChecked :: forall i. (Boolean -> i) -> Attribute i
onChecked f = unsafeHandler' "change" \e -> f <$> readChecked e.target
  where
  readChecked :: Node -> Maybe Boolean
  readChecked = either (const Nothing) Just <<< readProp "checked" <<< toForeign