module ATerm where

import           Control.Applicative

import           Data.Attoparsec.Text hiding (string,number)

import           Data.Text (Text)
import qualified Data.Text as T

import qualified Data.List as L

data ATerm
  = ATerm Text [ATerm]
  | List [ATerm]
  | String Text
  | Number Int

instance Show ATerm where
  show t = case t of
    ATerm c ts
      | not (null ts) -> T.unpack c ++ "(" ++ L.intercalate "," (show <$> ts) ++ ")"
      | otherwise -> T.unpack c
    List ts -> show ts
    String s -> show s
    Number i -> show i

parseATerm :: Text -> Either String ATerm
parseATerm t = case parse aterm t of
  Done _ r -> Right r
  Fail _ _ err -> Left err
  Partial {} -> Left "Partial"

aterm :: Parser ATerm
aterm = constructor <|> constant <|> list <|> string <|> number

constructor :: Parser ATerm
constructor = do
  con <- many1 letter
  _ <- char '('
  ts <- aterm `sepBy` char ','  
  _ <- char ')'
  return $ ATerm (T.pack con) ts

constant :: Parser ATerm
constant = do
  con <- many1 letter
  return $ ATerm (T.pack con) []

list :: Parser ATerm
list = do
  _ <- char '['
  ts <- aterm `sepBy` char ','
  _ <- char ']'
  return $ List ts

string :: Parser ATerm
string = do
  _ <- char '"'
  s <- manyTill anyChar (char '"')
  return $ String (T.pack s)

number :: Parser ATerm
number = Number <$> decimal
