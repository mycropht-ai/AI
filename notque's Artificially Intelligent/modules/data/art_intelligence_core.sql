-- Artificiallyintelligent Core

-- AI Operation Definitions
UPDATE AiOperationDefs
SET BehaviorTree = 'Settle New Town v2', MaxTargetDefense = 0, Priority = 4
WHERE OperationName = 'City Founding';

-- AI Operation Teams
UPDATE AIOperationTeams
SET SafeRallyPoint = 1
WHERE OperationName = 'City Founding';

UPDATE AIOperationTeams
SET InitialStrengthAdvantage = -1, OngoingStrengthAdvantage = 0
WHERE OperationName = 'Attack Enemy City';

UPDATE AIOperationTeams
SET InitialStrengthAdvantage = -1, OngoingStrengthAdvantage = 0
WHERE OperationName = 'Independent Camp Attack';

-- Lowered Initial Strength Advantage to -1 to always defend cities.
UPDATE AIOperationTeams
SET InitialStrengthAdvantage = -1, OngoingStrengthAdvantage = 0
WHERE OperationName = 'City Defense';

-- AI Lists
INSERT INTO AILists (LeaderType, ListType, System)
VALUES ('TRAIT_LEADER_MAJOR_CIV', 'Major PsuedoYield Biases', 'YieldBiases');

INSERT INTO AIListTypes (ListType)
VALUES ('Major PsuedoYield Biases');

-- AI Favored Items

-- Base Operation Limits
UPDATE AiFavoredItems
SET Value = 2
WHERE ListType = 'BaseOperationsLimits' AND Item = 'CITY_FOUNDING';

UPDATE AiFavoredItems
SET Value = 1
WHERE ListType = 'BaseOperationsLimits' AND Item = 'CITY_ASSAULT';

UPDATE AiFavoredItems
SET Value = 50
WHERE ListType = 'LegacyPathStrategyExpansionPseudoYieldBiases' AND Item = 'PSEUDOYIELD_NEW_CITY';

UPDATE AiFavoredItems
SET Value = 50
WHERE ListType = 'LegacyPathStrategyWondersPseudoYieldBiases' AND Item = 'PSEUDOYIELD_NEW_CITY';

UPDATE AiFavoredItems
SET Value = 50
WHERE ListType = 'LegacyPathStrategyImportsPseudoYieldBiases' AND Item = 'PSEUDOYIELD_NEW_CITY';

-- Stop the AI from spamming explorers
-- This is a Firaxis bug I do not have access to with the way it decides 
-- targets for the locations for exporers to go to.
-- When Firaxis fixes this, remove this change.
-- Default: 200
UPDATE AiFavoredItems
SET Value = 50
WHERE ListType = 'LegacyPathArtifactsUnitBiases' AND Item = 'UNIT_EXPLORER';

-- Insert custom pseudo yield biases
INSERT INTO AiFavoredItems (ListType, Item, Value)
VALUES ('Major PsuedoYield Biases', 'PSEUDOYIELD_CITY_GUARDS', 150), -- Default 25
       ('Major PsuedoYield Biases', 'PSEUDOYIELD_CITY_DEFENSES', 50), -- Default 25
       ('Major PsuedoYield Biases', 'PSEUDOYIELD_TOWN_TO_CITY_UPGRADE_PER_POPULATION', 500),
       ('Major PsuedoYield Biases', 'PSEUDOYIELD_CITY_GARRISON_COMBAT_VALUE', 12), -- default 5
       ('Major PsuedoYield Biases', 'PSEUDOYIELD_STANDING_ARMY_COMMANDER', 100),
       ('Major PsuedoYield Biases', 'PSEUDOYIELD_NEW_CITY', 750);

UPDATE AiFavoredItems SET Value = 1000 WHERE ListType = 'Default Settlement Plot Evaluations' AND Favored = 'false' AND TooltipString = 'LOC_SETTLEMENT_RECOMMENDATION_NEAREST_CITY' AND Item = 'Nearest Friendly City'; -- def -2
UPDATE AiFavoredItems SET Value = 1000 WHERE ListType = 'Default Settlement Plot Evaluations' AND Favored = 'true' AND TooltipString = 'LOC_SETTLEMENT_RECOMMENDATION_NEAREST_CITY' AND Item = 'Nearest Friendly City'; -- def -2
-- Shut off the desire for resource diversity, I think it might be
-- a major cause of forward settling, and I'm not sure it actually matters in game
-- I have found it does matter in the game. but i think city wise, not empire wise. 
UPDATE AiFavoredItems SET Value = 1 WHERE ListType = 'Default Settlement Plot Evaluations' AND TooltipString = 'LOC_SETTLEMENT_RECOMMENDATION_NEW_RESOURCES' AND Item = 'Resource Class' AND StringVal ='RESOURCECLASS_BONUS'; 

    -- Tactical priorities
    UPDATE AiFavoredItems
    SET Value = 6
    WHERE ListType = 'Default Tactical' AND Item = 'First Turn Settle';

    UPDATE AiFavoredItems
    SET Value = 5
    WHERE ListType = 'Default Tactical' AND Item IN ('Air Assault', 'Air Rebase', 'Use WMD', 'Take Razing City', 'Heal');


    -- Insert 'Capture City' at some point to try
    UPDATE AiFavoredItems
    SET Value = 4
    WHERE ListType = 'Default Tactical' AND Item IN ('Attack High Priority Unit', 'Upgrade Units');

    UPDATE AiFavoredItems
    SET Value = 3
    WHERE ListType = 'Default Tactical' AND Item IN ('Attack Medium Priority Unit', 'Attack Low Priority Unit');

    UPDATE AiFavoredItems
    SET Value = 2
    WHERE ListType = 'Default Tactical' AND Item IN ('Form Army', 'Plunder Trade Route');

    UPDATE AiFavoredItems
    SET Value = 1
    WHERE ListType = 'Default Tactical' AND Item IN ('Use Great Person', 'Explore', 'Block Enemy Expansion', 'Army Overrun', 'Defend Home', 'Escort Embarked', 'Wander near city');

    UPDATE AiFavoredItems
    SET Value = 0
    WHERE ListType = 'Default Tactical' AND Item = 'Wander';

-- AI Operation Team Requirements
UPDATE OpTeamRequirements
SET MinNumber = 2, MaxNumber = 6
WHERE TeamName = 'Enemy City Attack' AND ClassTag = 'UNIT_CLASS_MELEE';

UPDATE OpTeamRequirements
SET MinNumber = 3, MaxNumber = 12
WHERE TeamName = 'Enemy City Attack' AND ClassTag = 'UNIT_CLASS_RANGED';

INSERT INTO OpTeamRequirements (TeamName, ClassTag, Property, MaxNumber)
VALUES ('Enemy City Attack', 'UNIT_CLASS_CREATE_TOWN', 'LandClaimCharges', 0);

INSERT INTO OpTeamRequirements (TeamName, ClassTag, MaxNumber)
VALUES ('Enemy City Attack', 'UNIT_CLASS_NON_COMBAT', 0);

-- Trying reconsider while preparing.

--UPDATE OpTeamRequirements
--SET ReconsiderWhilePreparing = true
--WHERE TeamName = 'Enemy City Attack';

-- Independent Camp Attack
UPDATE OpTeamRequirements
SET MinNumber = 1, MaxNumber = 6
WHERE TeamName = 'Independent Camp Attack' AND ClassTag = 'UNIT_CLASS_MELEE';

UPDATE OpTeamRequirements
SET MinNumber = 2, MaxNumber = 12
WHERE TeamName = 'Independent Camp Attack' AND ClassTag = 'UNIT_CLASS_RANGED';

INSERT INTO OpTeamRequirements (TeamName, ClassTag, Property, MaxNumber)
VALUES ('Independent Camp Attack', 'UNIT_CLASS_CREATE_TOWN', 'LandClaimCharges', 0);

INSERT INTO OpTeamRequirements (TeamName, ClassTag, MaxNumber)
VALUES ('Independent Camp Attack', 'UNIT_CLASS_NON_COMBAT', 0);

-- Trying reconsider while preparing.

--UPDATE OpTeamRequirements
--SET ReconsiderWhilePreparing = true
--WHERE TeamName = 'Independent Camp Attack';

-- City Defense
INSERT INTO OpTeamRequirements (TeamName, ClassTag, Property, MaxNumber)
VALUES ('City Defense', 'UNIT_CLASS_CREATE_TOWN', 'LandClaimCharges', 0);

-- Already Set to 0, this is for documentation to know why it's not set.
-- INSERT INTO OpTeamRequirements (TeamName, ClassTag, MaxNumber)
-- VALUES ('City Defense', 'UNIT_CLASS_NON_COMBAT', 0);

UPDATE OpTeamRequirements
SET MinNumber = 2 -- MaxNumber = 8
WHERE TeamName = 'City Defense' AND ClassTag = 'UNIT_CLASS_COMBAT';

INSERT INTO OpTeamRequirements (TeamName, ClassTag, MinNumber, MaxNumber)
VALUES ('City Defense', 'UNIT_CLASS_MELEE', 1, 4),
       ('City Defense', 'UNIT_CLASS_RANGED', 1, 6),
       ('City Defense', 'UNIT_CLASS_SIEGE', 0, 2);

-- City Founders
UPDATE OpTeamRequirements
SET MinNumber = 0, MaxNumber = 1
WHERE TeamName = 'City Founders' AND ClassTag = 'UNIT_CLASS_COMBAT';

UPDATE OpTeamRequirements
SET MaxNumber = 0
WHERE TeamName = 'City Founders' AND ClassTag = 'UNIT_CLASS_ARMY_COMMANDER';

-- Natural Wonder plot evaluations
INSERT INTO AiFavoredItems (ListType, Item, Value, StringVal, TooltipString)
VALUES 
    ('Default Settlement Plot Evaluations', 'Specific Feature', 2, 'FEATURE_VALLEY_OF_FLOWERS', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 2, 'FEATURE_BARRIER_REEF', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 2, 'FEATURE_REDWOOD_FOREST', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 2, 'FEATURE_GRAND_CANYON', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 2, 'FEATURE_GULLFOSS', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 2, 'FEATURE_HOERIKWAGGO', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 2, 'FEATURE_IGUAZU_FALLS', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 2, 'FEATURE_KILIMANJARO', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 2, 'FEATURE_ZHANGJIAJIE', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 2, 'FEATURE_THERA', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 2, 'FEATURE_TORRES_DEL_PAINE', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 2, 'FEATURE_ULURU', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES');
    
UPDATE AiFavoredItems 
SET Value = 2
WHERE Value > 2 
  AND ListType LIKE '%Settle Plot Conditions%'
  AND ListType NOT LIKE 'Default Settle Plot Conditions';

Update AiFavoredItems
SET Value = 2
Where ListType = 'Default Settlement Plot Evaluations' and Item = 'Coastal';

Update AiFavoredItems
SET Value = 2
Where ListType = 'Default Settlement Plot Evaluations' and Item = 'Fresh Water';

-- Increase science bias for Legacy Path Science
UPDATE AiFavoredItems
SET Value = 15 -- Def 10
WHERE ListType = 'LegacyPathStrategyScienceYieldBiases' AND Item = 'Yield_SCIENCE';

-- Increase production bias for Legacy Path Expansion
UPDATE AiFavoredItems
SET Value = 15
WHERE ListType = 'LegacyPathStrategyExpansionYieldBiases' AND Item = 'YIELD_PRODUCTION';

UPDATE AiFavoredItems 
SET Value = 1000 
WHERE ListType = 'Default Settlement Plot Evaluations' AND Favored = 'false' AND TooltipString = 'LOC_SETTLEMENT_RECOMMENDATION_NEAREST_CITY' AND Item = 'Nearest Friendly City'; 

UPDATE AiFavoredItems 
SET Value = 1000
WHERE ListType = 'Default Settlement Plot Evaluations' AND Favored = 'true' AND TooltipString = 'LOC_SETTLEMENT_RECOMMENDATION_NEAREST_CITY' AND Item = 'Nearest Friendly City'; 