module Hp where

import Parsec hiding (Parser)
import qualified ParsecToken as P
import ParsecLanguage (haskellDef)


pmodule
  = do{ reserved "module"
      ; identifier
      ; reserved "where"
      ; decls
      }
  * decls