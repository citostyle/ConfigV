module Rules where

-- | every instance of Learnable is a template of rules we can learn
--   instance provided in the Learners dir
class Foldable t => Learnable t a where
  -- | build a set of rules from a IR
  -- these are not probabalistic
  buildRelations :: IRConfigFile -> t a
  -- | two rules can be related, and they must be merged, or unrelated, then we keep both
  -- this allows us to merge two related rules into a more general one
  -- e.g. (x>y,2) and (x>=y,3) can become (x>=y,5)
  merge :: a -> a -> t a 
  -- | how to check if a rule holds on a file
  check :: a -> IRConfigFile -> Bool

-- | A rule is the structure for tracking and merging evidence relations
--   We need to track how much evidence we have for the rule, against the rule, and how often we have seen the rule
data Rule (a, NumEvidenceTrue, NumEvidenceFalse, TotalTimes)

------------
-- The specific types of relations we want to learn
-- go below here
-----------

-- | these keywords should appear in the same file
data keywordCoor = Rule (Keyword,Keyword)

data ordering = Rule (Keyword,Keyword)

data intRel = Rule (IRLine,IRLine,Fomula)


newtype AppearsThereshold = Int
newtype FrequencyThreshold = Double --between 0 and 1
