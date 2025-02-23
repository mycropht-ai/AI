-- Artificiallyintelligent Core


-- AI Operation Definitions
UPDATE AiOperationDefs
SET BehaviorTree = 'Settle New Town v2', MaxTargetDefense = 0, Priority = 4
WHERE OperationName = 'City Founding';

UPDATE AiOperationDefs
SET MustHaveUnits = 6, MinOddsOfSuccess = 0.35, Priority = 4
WHERE OperationName = 'Attack Enemy City';

UPDATE AiOperationDefs
SET MustHaveUnits = 6, MinOddsOfSuccess = 0.35, Priority = 4
WHERE OperationName = 'Attack Enemy Independent';

-- AI Operation Teams
UPDATE AIOperationTeams
SET SafeRallyPoint = 0
WHERE OperationName = 'City Founding';

UPDATE AIOperationTeams
SET OngoingStrengthAdvantage = 2
WHERE OperationName = 'Attack Enemy City';

UPDATE AIOperationTeams
SET InitialStrengthAdvantage = 1, OngoingStrengthAdvantage = 2
WHERE OperationName = 'Independent Camp Attack';

-- Lowered Initial Strength Advantage to -1 to always defend cities. .5 for ongoing
UPDATE AIOperationTeams
SET InitialStrengthAdvantage = -1, OngoingStrengthAdvantage = 0.5
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
SET Value = 2
WHERE ListType = 'BaseOperationsLimits' AND Item = 'CITY_ASSAULT';

UPDATE AiFavoredItems
SET Value = 50
WHERE ListType = 'LegacyPathStrategyExpansionPseudoYieldBiases' AND Item = 'PSEUDOYIELD_NEW_CITY';

UPDATE AiFavoredItems
SET Value = -25
WHERE ListType = 'LegacyPathStrategyWondersPseudoYieldBiases' AND Item = 'PSEUDOYIELD_NEW_CITY';

UPDATE AiFavoredItems
SET Value = -50
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
VALUES ('Major PsuedoYield Biases', 'PSEUDOYIELD_CITY_GUARDS', -50),
       ('Major PsuedoYield Biases', 'PSEUDOYIELD_CITY_DEFENSES', -50),
       ('Major PsuedoYield Biases', 'PSEUDOYIELD_TOWN_TO_CITY_UPGRADE_PER_POPULATION', 500),
       ('Major PsuedoYield Biases', 'PSEUDOYIELD_CITY_GARRISON_COMBAT_VALUE', 20),
       ('Major PsuedoYield Biases', 'PSEUDOYIELD_STANDING_ARMY_COMMANDER', 100),
       ('Major PsuedoYield Biases', 'PSEUDOYIELD_NEW_CITY', 250);

-- Insert natural wonder plot evaluations
INSERT INTO AiFavoredItems (ListType, Item, Value, StringVal, TooltipString)
VALUES 
    ('Default Settlement Plot Evaluations', 'Specific Feature', 25, 'FEATURE_VALLEY_OF_FLOWERS', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 25, 'FEATURE_BARRIER_REEF', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 25, 'FEATURE_REDWOOD_FOREST', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 25, 'FEATURE_GRAND_CANYON', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 25, 'FEATURE_GULLFOSS', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 25, 'FEATURE_HOERIKWAGGO', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 25, 'FEATURE_IGUAZU_FALLS', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 25, 'FEATURE_KILIMANJARO', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 25, 'FEATURE_ZHANGJIAJIE', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 25, 'FEATURE_THERA', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 25, 'FEATURE_TORRES_DEL_PAINE', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES'),
    ('Default Settlement Plot Evaluations', 'Specific Feature', 25, 'FEATURE_ULURU', 'LOC_SETTLEMENT_RECOMMENDATION_FEATURES');

-- Tactical priorities
UPDATE AiFavoredItems
SET Value = 10
WHERE ListType = 'Default Tactical' AND Item = 'First Turn Settle';

UPDATE AiFavoredItems
SET Value = 9
WHERE ListType = 'Default Tactical' AND Item IN ('Air Assault', 'Air Rebase', 'Use WMD', 'Army Overrun');

UPDATE AiFavoredItems
SET Value = 8
WHERE ListType = 'Default Tactical' AND Item IN ('Heal', 'Upgrade Units');

UPDATE AiFavoredItems
SET Value = 7
WHERE ListType = 'Default Tactical' AND Item IN ('Take Razing City', 'Attack High Priority Unit');

UPDATE AiFavoredItems
SET Value = 6
WHERE ListType = 'Default Tactical' AND Item = 'Attack Medium Priority Unit';

UPDATE AiFavoredItems
SET Value = 5
WHERE ListType = 'Default Tactical' AND Item IN ('Form Army', 'Use Great Person', 'Explore');

UPDATE AiFavoredItems
SET Value = 4
WHERE ListType = 'Default Tactical' AND Item IN ('Plunder Trade Route', 'Block Enemy Expansion');

UPDATE AiFavoredItems
SET Value = 3
WHERE ListType = 'Default Tactical' AND Item IN ('Escort Embarked', 'Defend Home');

UPDATE AiFavoredItems
SET Value = 2
WHERE ListType = 'Default Tactical' AND Item = 'Attack Low Priority Unit';

UPDATE AiFavoredItems
SET Value = 1
WHERE ListType = 'Default Tactical' AND Item = 'Wander near city';

UPDATE AiFavoredItems
SET Value = 0
WHERE ListType = 'Default Tactical' AND Item = 'Wander';

-- Op Team Requirements
-- Enemy City Attack
UPDATE OpTeamRequirements
SET MinNumber = 2, MaxNumber = 6
WHERE TeamName = 'Enemy City Attack' AND ClassTag = 'UNIT_CLASS_MELEE';

UPDATE OpTeamRequirements
SET MinNumber = 3, MaxNumber = 12
WHERE TeamName = 'Enemy City Attack' AND ClassTag = 'UNIT_CLASS_RANGED';

INSERT INTO OpTeamRequirements (TeamName, ClassTag, Property, MaxNumber)
VALUES ('Enemy City Attack', 'UNIT_CLASS_CREATE_TOWN', 'LandClaimCharges', 0);

-- Independent Camp Attack
UPDATE OpTeamRequirements
SET MinNumber = 2, MaxNumber = 6
WHERE TeamName = 'Independent Camp Attack' AND ClassTag = 'UNIT_CLASS_MELEE';

UPDATE OpTeamRequirements
SET MinNumber = 3, MaxNumber = 12
WHERE TeamName = 'Independent Camp Attack' AND ClassTag = 'UNIT_CLASS_RANGED';

INSERT INTO OpTeamRequirements (TeamName, ClassTag, Property, MaxNumber)
VALUES ('Independent Camp Attack', 'UNIT_CLASS_CREATE_TOWN', 'LandClaimCharges', 0);

-- City Defense
INSERT INTO OpTeamRequirements (TeamName, ClassTag, Property, MaxNumber)
VALUES ('City Defense', 'UNIT_CLASS_CREATE_TOWN', 'LandClaimCharges', 0);

UPDATE OpTeamRequirements
SET MinNumber = 2, MaxNumber = 8
WHERE TeamName = 'City Defense' AND ClassTag = 'UNIT_CLASS_COMBAT';

INSERT INTO OpTeamRequirements (TeamName, ClassTag, MinNumber, MaxNumber)
VALUES ('City Defense', 'UNIT_CLASS_MELEE', 1, 4),
       ('City Defense', 'UNIT_CLASS_RANGED', 1, 6),
       ('City Defense', 'UNIT_CLASS_SIEGE', 0, 2);

-- City Founders
UPDATE OpTeamRequirements
SET MinNumber = 0, MaxNumber = 4
WHERE TeamName = 'City Founders' AND ClassTag = 'UNIT_CLASS_COMBAT';

UPDATE OpTeamRequirements
SET MaxNumber = 1
WHERE TeamName = 'City Founders' AND ClassTag = 'UNIT_CLASS_ARMY_COMMANDER';




--------------------------------------------------------------------------
-- RH General Leader and Civ Plot Settlement Improvements

UPDATE AiFavoredItems 
SET Value = Value / 2
WHERE Value > 25 
  AND ListType LIKE '%Settlement Plot Evaluations%'
  AND ListType NOT LIKE 'Default Settlement Plot Evaluations';

-- Increase science bias for Legacy Path Science
UPDATE AiFavoredItems
SET Value = 30 -- Def 10
WHERE ListType = 'LegacyPathStrategyScienceYieldBiases' AND Item = 'Yield_SCIENCE';

-- Increase production bias for Legacy Path Expansion
UPDATE AiFavoredItems
SET Value = 20
WHERE ListType = 'LegacyPathStrategyExpansionYieldBiases' AND Item = 'YIELD_PRODUCTION';

--    <Row ListType="Chola Settlement Plot Evaluations" Item="Specific Terrain" Value="25" StringVal="TERRAIN_COAST" TooltipString="LOC_SETTLEMENT_RECOMMENDATION_TERRAIN"/>