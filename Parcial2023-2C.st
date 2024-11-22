!classDefinition: #MineFieldTests category: #'Parcial2023-2C'!
TestCase subclass: #MineFieldTests
	instanceVariableNames: 'dicePosition random'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2023-2C'!

!MineFieldTests methodsFor: 'random' stamp: 'JCM 11/21/2024 12:16:59'!
fixRandomTo: aFixedPosition 
	
	random := aFixedPosition! !

!MineFieldTests methodsFor: 'random' stamp: 'JCM 11/21/2024 12:17:17'!
setup

	random := 0@0! !


!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 12:26:27'!
test01APlayerStartingInAValidPositionIsInThatPosition

	| player |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	MineField extends: 2@2 HasObjects: (OrderedCollection new) player: player .
	
	self assert: (player positionIs: 1@1).
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 12:26:27'!
test02APlayerStartingInAValidPositionIsNotInAnotherPosition

	| player |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	MineField extends: 2@2 HasObjects: (OrderedCollection new) player: player .
	
	self deny: (player positionIs: 1@2).
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 12:26:27'!
test03APlayerCanOnlyStartInTheFirstRow


	self should:  
	[MineField extends: 2@2 HasObjects: (OrderedCollection new) player: (MineFieldPlayer startOn: 1@2 playerLives: 3) ]
		raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:error | self assert: error messageText equals: MineFieldPlayer playerOnlyBegginsOnTheFirstRow ]
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 12:26:27'!
test04APlayerOnAMineFieldCanMoveUp

	"Aca preguntaria como hace el jugador para moverse, si tira un dado o q onda. Asumo que tira un dado"
	
	| player mineField |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	mineField := MineField extends: 3@3 HasObjects: (OrderedCollection new) player: player .
	
	mineField movePlayerUp.
	
	self assert: (player positionIs: 1@2).
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 12:26:26'!
test05APlayerOnAMineFieldCanMoveDown

	"Aca preguntaria como hace el jugador para moverse, si tira un dado o q onda. Asumo que tira un dado"
	
	| player mineField |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	mineField := MineField extends: 3@3 HasObjects: (OrderedCollection new) player: player .
	
	mineField movePlayerUp.
	mineField movePlayerDown.
	
	self assert: (player positionIs: 1@1).
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 12:26:27'!
test06APlayerOnAMineFieldCanMoveLeft

	"Aca preguntaria como hace el jugador para moverse, si tira un dado o q onda. Asumo que tira un dado"
	
	| player mineField |
	
	player := MineFieldPlayer startOn: 2@1 playerLives: 3.
	
	mineField := MineField extends: 3@3 HasObjects: (OrderedCollection new) player: player .
	
	mineField movePlayerLeft.
	
	self assert: (player positionIs: 1@1).
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 12:26:26'!
test07APlayerOnAMineFieldCanMoveRight

	"Aca preguntaria como hace el jugador para moverse, si tira un dado o q onda. Asumo que tira un dado"
	
	| player mineField |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	mineField := MineField extends: 3@3 HasObjects: (OrderedCollection new) player: player .
	
	mineField movePlayerRight.
	
	self assert: (player positionIs: 2@1).
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 12:26:27'!
test08APlayerCannotGoOutsideTheMineField
	
	| player mineField |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	mineField := MineField extends: 2@2 HasObjects: (OrderedCollection new) player: player .
	
	mineField movePlayerDown.
	
	self assert: (player positionIs: 1@1).
	
	mineField movePlayerLeft.
	
	self assert: (player positionIs: 1@1).
	
	mineField movePlayerUp.
	
	self assert: (player positionIs: 1@2).
	
	mineField movePlayerUp.
	
	self assert: (player positionIs: 1@2).
	
	mineField movePlayerRight. 
	
	self assert: (player positionIs: 2@2).
	
	mineField movePlayerRight. 
	
	self assert: (player positionIs: 2@2).
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 13:37:59'!
test09APlayerThatMovesUpAndEndsInALowPowerMineLossesALife
	
	| player mineField lowPowerMine |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	lowPowerMine := LowPowerMine on: 1@2.
	
	mineField := MineField extends: 2@2 HasObjects: (OrderedCollection with: lowPowerMine) player: player .
	
	mineField movePlayerUp.
	
	self assert: (player positionIs: 1@2).
	self assert: (player livesAre: 2)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 13:40:40'!
test10APlayerThatMovesDownAndEndsInALowPowerMineLossesALife
	
	| player mineField lowPowerMine |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	lowPowerMine := LowPowerMine on: 2@1.
	
	mineField := MineField extends: 2@3 HasObjects: (OrderedCollection with: lowPowerMine) player: player .
	
	mineField movePlayerUp.
	mineField movePlayerRight.
	mineField movePlayerDown.
	
	self assert: (player positionIs: 2@1).
	self assert: (player livesAre: 2)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 13:41:14'!
test11APlayerThatMovesLeftAndEndsInALowPowerMineLossesALife
	
	| player mineField lowPowerMine |
	
	player := MineFieldPlayer startOn: 2@1 playerLives: 3.
	
	lowPowerMine := LowPowerMine on: 1@1.
	
	mineField := MineField extends: 2@3 HasObjects: (OrderedCollection with: lowPowerMine) player: player .
	
	mineField movePlayerLeft.
	
	
	self assert: (player positionIs: 1@1).
	self assert: (player livesAre: 2)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 13:41:21'!
test12APlayerThatMovesRightAndEndsInALowPowerMineLossesALife
	
	| player mineField lowPowerMine |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	lowPowerMine := LowPowerMine on: 2@1.
	
	mineField := MineField extends: 2@3 HasObjects: (OrderedCollection with: lowPowerMine) player: player .
	
	mineField movePlayerRight .
	
	
	self assert: (player positionIs: 2@1).
	self assert: (player livesAre: 2)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 14:02:50'!
test13APlayerThatMovesAndEndsInAHighPowerMineLossesTwoLivesAndEndsInARandomPosition
	
	| player mineField fixedRandomGenerator highPowerMine |
	
	fixedRandomGenerator := FixedRando fixTo: -1@0 maxRandomValue: 8.
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	highPowerMine := HighPowerMine on: 2@1 randomGenerator: fixedRandomGenerator.
	
	mineField := MineField extends: 2@3 HasObjects: (OrderedCollection with: highPowerMine ) player: player.
	
	mineField movePlayerRight .
	
	self assert: (player positionIs: 1@1).
	self assert: (player livesAre: 1)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 14:05:13'!
test14APlayerThatFliesToAPositionWithAMineIsAlsoAffectedByTheLastOne
	
	| player mineField fixedRandomGenerator highPowerMine lowPowerMine |
	
	fixedRandomGenerator := FixedRando fixTo: 0@1 maxRandomValue: 8.
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 4.
	
	highPowerMine := HighPowerMine on: 2@1 randomGenerator: fixedRandomGenerator.
	
	lowPowerMine := LowPowerMine on: 2@2.
	
	mineField := MineField extends: 2@3 HasObjects: (OrderedCollection with: highPowerMine with: lowPowerMine ) player: player.
	
	mineField movePlayerRight .
	
	self assert: (player positionIs: 2@2).
	self assert: (player livesAre: 1)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 14:29:08'!
test15APlayerCannotBeAffectedByTheSameMineTwice
	
	| player mineField lowPowerMine fixedRandomGenerator |
	
	fixedRandomGenerator := FixedRando fixTo: -1@0 maxRandomValue: 8.
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 4.

	lowPowerMine := HighPowerMine on: 2@1 randomGenerator: fixedRandomGenerator .
	
	mineField := MineField extends: 3@4 HasObjects: (OrderedCollection with: lowPowerMine ) player: player.
	
	mineField movePlayerRight .
	mineField movePlayerRight.
	
	
	self assert: (player positionIs: 2@1).
	self assert: (player livesAre: 2)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 14:29:19'!
test16APlayerThatMovesAndEndsInAPositionWithALightArmourEquipsIt
	
	| player mineField lightArmour |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	lightArmour := LightArmour on: 2@1.
	
	mineField := MineField extends: 2@3 HasObjects: (OrderedCollection with: lightArmour ) player: player.
	
	mineField movePlayerRight .
	
	self assert: (player positionIs: 2@1).
	self assert: (player livesAre: 3).
	self assert: (player hasEquiped: lightArmour)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 14:42:05'!
test17APlayerEquipsTheLastArmourReached
	
	| player mineField lightArmour lightArmour2 |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	lightArmour := LightArmour on: 2@1.
	lightArmour2 := LightArmour on: 1@1.
	
	mineField := MineField extends: 2@3 HasObjects: (OrderedCollection with: lightArmour with: lightArmour2) player: player.
	
	mineField movePlayerRight .
	
	self assert: (player positionIs: 2@1).
	self assert: (player livesAre: 3).
	self deny: (player hasEquiped: lightArmour2)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 14:47:19'!
test18APlayerWithALightArmourDoesNotLosesLifesWhenHitByALowPowerMine
	
	| player mineField lightArmour lowPowerMine |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	lightArmour := LightArmour on: 2@1.
	
	lowPowerMine := LowPowerMine on: 2@2.
	
	mineField := MineField extends: 2@3 HasObjects: (OrderedCollection with: lightArmour with: lowPowerMine) player: player.
	
	mineField movePlayerRight.
	mineField movePlayerUp.
	
	self assert: (player positionIs: 2@2).
	self assert: (player livesAre: 3).
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 14:29:31'!
test19APlayerWithALightArmourFliesToHalfTheRandomValueGeneratedWhenHitByAHighPowerMine
	
	| player mineField lightArmour highPowerMine fixedRandomGenerator |
	
	fixedRandomGenerator := FixedRando fixTo: -2@0 maxRandomValue: 8.
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	lightArmour := LightArmour on: 2@1.
	
	highPowerMine := HighPowerMine on: 2@2  randomGenerator: fixedRandomGenerator.
	
	mineField := MineField extends: 2@3 HasObjects: (OrderedCollection with: lightArmour with: highPowerMine) player: player.
	
	mineField movePlayerRight.
	mineField movePlayerUp.
	
	self assert: (player positionIs: 1@2).
	self assert: (player livesAre: 3).
	self assert: (player hasEquiped: lightArmour).
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 14:44:46'!
test20APlayersLightArmourDurationIsOneMine
	
	| player mineField lightArmour highPowerMine |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	lightArmour := LightArmour on: 2@1.
	
	highPowerMine := LowPowerMine on: 2@2. 
	
	mineField := MineField extends: 2@3 HasObjects: (OrderedCollection with: lightArmour with: highPowerMine) player: player.
	
	mineField movePlayerRight.
	mineField movePlayerUp.
	
	self assert: (player positionIs: 2@2).
	self assert: (player livesAre: 3).
	self deny: (player hasEquiped: lightArmour).
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 14:43:42'!
test21APlayerThatMovesAndEndsInAPositionWithAHeavyArmourEquipsIt
	
	| player mineField heavyArmour |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	heavyArmour := HeavyArmour on: 2@1.
	
	mineField := MineField extends: 2@3 HasObjects: (OrderedCollection with: heavyArmour ) player: player.
	
	mineField movePlayerRight .
	
	self assert: (player positionIs: 2@1).
	self assert: (player livesAre: 3).
	self assert: (player hasEquiped: heavyArmour)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 14:50:23'!
test21APlayerWithAHeavyArmourDoesNotLosesLifeWhenHitByALowPowerMine
	
	| player mineField heavyArmour lowPowerMine |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	heavyArmour := HeavyArmour on: 2@1.
	
	lowPowerMine := LowPowerMine on: 2@2.
	
	mineField := MineField extends: 2@3 HasObjects: (OrderedCollection with: heavyArmour with: lowPowerMine) player: player.
	
	mineField movePlayerRight .
	mineField movePlayerUp.
	
	self assert: (player positionIs: 2@2).
	self assert: (player livesAre: 3).
	self assert: (player hasEquiped: heavyArmour)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !

!MineFieldTests methodsFor: 'tests' stamp: 'JCM 11/21/2024 14:49:29'!
test22APlayerWithAHeavyArmourDoesNotLosesLifeWhenHitByAHighPowerMine
	
	| player mineField heavyArmour |
	
	player := MineFieldPlayer startOn: 1@1 playerLives: 3.
	
	heavyArmour := HeavyArmour on: 2@1.
	
	mineField := MineField extends: 2@3 HasObjects: (OrderedCollection with: heavyArmour ) player: player.
	
	mineField movePlayerRight .
	
	self assert: (player positionIs: 2@1).
	self assert: (player livesAre: 3).
	self assert: (player hasEquiped: heavyArmour)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	! !


!classDefinition: #Armour category: #'Parcial2023-2C'!
Object subclass: #Armour
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2023-2C'!

!Armour methodsFor: 'protects' stamp: 'JCM 11/21/2024 14:37:32'!
protects: aMineFieldPlayer FromHighMineWantingToFlyTo: aRandomPosition in: aMineField

	self subclassResponsibility! !

!Armour methodsFor: 'protects' stamp: 'JCM 11/21/2024 14:37:27'!
protects: aMineFieldPlayer FromLowPowerMineIn: aMineField

	self subclassResponsibility! !

!Armour methodsFor: 'protects' stamp: 'JCM 11/21/2024 14:37:23'!
protectsFromLowPowerMine: aMineFieldPlayer

	self subclassResponsibility! !


!classDefinition: #MineFieldArmours category: #'Parcial2023-2C'!
Armour subclass: #MineFieldArmours
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2023-2C'!

!MineFieldArmours methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 14:39:04'!
initializeOn: aMineFieldPosition 
	
	position := aMineFieldPosition.! !


!MineFieldArmours methodsFor: 'register' stamp: 'JCM 11/21/2024 14:39:10'!
registerOn: objectsPosition

	objectsPosition at: position put: self
	! !


!MineFieldArmours methodsFor: 'affect' stamp: 'JCM 11/21/2024 14:39:19'!
affect: aPlayer in: aMineField 
	
	aPlayer equip: self.! !


!classDefinition: #HeavyArmour category: #'Parcial2023-2C'!
MineFieldArmours subclass: #HeavyArmour
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2023-2C'!



!HeavyArmour methodsFor: 'protects' stamp: 'JCM 11/21/2024 14:51:37'!
protects: aMineFieldPlayer FromLowPowerMineIn: aMineField

	aMineFieldPlayer isHitByALowMineWithAHeavyArmour! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HeavyArmour class' category: #'Parcial2023-2C'!
HeavyArmour class
	instanceVariableNames: ''!

!HeavyArmour class methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 14:32:43'!
on: aMineFieldPosition 
	
	^self new initializeOn: aMineFieldPosition ! !


!classDefinition: #LightArmour category: #'Parcial2023-2C'!
MineFieldArmours subclass: #LightArmour
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2023-2C'!




!LightArmour methodsFor: 'protects' stamp: 'JCM 11/21/2024 14:35:52'!
protects: aMineFieldPlayer FromHighMineWantingToFlyTo: aRandomPosition in: aMineField  
	
	aMineFieldPlayer isHitByAHighPowerMineWithLightArmourAndFliesTo: (aRandomPosition // 2)! !

!LightArmour methodsFor: 'protects' stamp: 'JCM 11/21/2024 14:46:41'!
protects: aMineFieldPlayer FromLowPowerMineIn: aMineField

	aMineFieldPlayer isHitByALowMineWithALightArmour! !

!LightArmour methodsFor: 'protects' stamp: 'JCM 11/21/2024 13:36:49'!
protectsFromLowPowerMine: aMineFieldPlayer 

	aMineFieldPlayer isHitByALowMineWithLightArmour! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LightArmour class' category: #'Parcial2023-2C'!
LightArmour class
	instanceVariableNames: ''!

!LightArmour class methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 13:16:51'!
on: aMineFieldPosition 
	
	^self new initializeOn: aMineFieldPosition ! !


!classDefinition: #NoArmour category: #'Parcial2023-2C'!
Armour subclass: #NoArmour
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2023-2C'!

!NoArmour methodsFor: 'protects' stamp: 'JCM 11/21/2024 14:06:57'!
protects: aMineFieldPlayer FromHighMineWantingToFlyTo: aRandomPosition in: aMineField
	
	aMineFieldPlayer isHitByAHighPowerMineWithNoArmourAndFliesTo: aRandomPosition in: aMineField.! !

!NoArmour methodsFor: 'protects' stamp: 'JCM 11/21/2024 14:19:23'!
protects: aMineFieldPlayer FromLowPowerMineIn: aMineField
	
	aMineFieldPlayer isHitByALowMineWithNoArmourIn: aMineField! !

!NoArmour methodsFor: 'protects' stamp: 'JCM 11/21/2024 14:19:23'!
protectsFromLowPowerMine: aMineFieldPlayer 
	
	aMineFieldPlayer isHitByALowMineWithNoArmourIn: aMineField! !


!classDefinition: #FixedRando category: #'Parcial2023-2C'!
Object subclass: #FixedRando
	instanceVariableNames: 'fixedPosition maxRandomValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2023-2C'!

!FixedRando methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 12:54:47'!
initializeFixTo: aFixedPosition maxRandomValue: aMaxRandomValue  
	
	fixedPosition := aFixedPosition.
	maxRandomValue := aMaxRandomValue .! !


!FixedRando methodsFor: 'nextRandom' stamp: 'JCM 11/21/2024 12:56:16'!
nextInteger
	
	^self nextInteger: maxRandomValue.! !

!FixedRando methodsFor: 'nextRandom' stamp: 'JCM 11/21/2024 12:56:52'!
nextInteger: aMaxRandomValue 
	
	"Estoy simulando el random "
	
	^fixedPosition ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FixedRando class' category: #'Parcial2023-2C'!
FixedRando class
	instanceVariableNames: ''!

!FixedRando class methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 12:54:31'!
fixTo: aFixedPosition maxRandomValue: maxRandomValue 

	^self new initializeFixTo: aFixedPosition maxRandomValue: maxRandomValue ! !


!classDefinition: #MineField category: #'Parcial2023-2C'!
Object subclass: #MineField
	instanceVariableNames: 'extention objects player objectsPosition random'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2023-2C'!

!MineField methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 12:26:15'!
initializeExtends: aFieldExtention withObjects: fieldObjects player: aPlayer    
	
	player := aPlayer.
	extention := aFieldExtention.
	objects := fieldObjects.
	objectsPosition := Dictionary new.
	
	
	self putObjectsInPosition: fieldObjects.! !

!MineField methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 11:34:19'!
putObjectsInPosition: fieldObjects 
	
	
	
	fieldObjects do:[:object | object registerOn: objectsPosition ]! !


!MineField methodsFor: 'move player' stamp: 'JCM 11/21/2024 13:02:25'!
movePlayerDown
	
	| newPosition |
	
	newPosition := player canMoveDownWithoutFalling: extention.
	
	objectsPosition at: newPosition ifPresent: [:object | object affect: player in: self]! !

!MineField methodsFor: 'move player' stamp: 'JCM 11/21/2024 13:02:25'!
movePlayerLeft
	
	| newPosition |
	
	newPosition := player canMoveLeftWithoutFalling: extention.
	
	objectsPosition at: newPosition ifPresent: [:object | object affect: player in: self]! !

!MineField methodsFor: 'move player' stamp: 'JCM 11/21/2024 13:02:25'!
movePlayerRight
	
	| newPosition |
	
	newPosition := player canMoveRightWithoutFalling: extention.
	
	objectsPosition at: newPosition ifPresent: [:object | object affect: player in: self]! !

!MineField methodsFor: 'move player' stamp: 'JCM 11/21/2024 14:10:37'!
movePlayerTo: aPosition
	
	"Unificar codigo repetido"
	
	
	(player canBeMovedTo: aPosition withMineFieldExtention: extention) ifTrue:[objectsPosition at: aPosition ifPresent: [:object | object affect: player in: self]]! !

!MineField methodsFor: 'move player' stamp: 'JCM 11/21/2024 13:02:25'!
movePlayerUp
	
	| newPosition |
	
	newPosition := player canMoveUpWithoutFalling: extention.
	
	objectsPosition at: newPosition ifPresent: [:object | object affect: player in: self]! !

!MineField methodsFor: 'move player' stamp: 'JCM 11/21/2024 13:06:31'!
moveTo: aPosition
	
	| newPosition |
	
	newPosition := player canMoveTo: aPosition WithoutFalling: extention.
	
	objectsPosition at: newPosition ifPresent: [:object | object affect: player in: self]! !


!MineField methodsFor: 'remove' stamp: 'JCM 11/21/2024 14:21:17'!
removeObjectAt: anObjectPosition
	
	objectsPosition removeKey: anObjectPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MineField class' category: #'Parcial2023-2C'!
MineField class
	instanceVariableNames: ''!

!MineField class methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 12:26:26'!
extends: aFieldExtention HasObjects: fieldObjects player: aPlayer     
	
	^self new initializeExtends: aFieldExtention withObjects: fieldObjects player: aPlayer ! !


!classDefinition: #MineFieldPlayer category: #'Parcial2023-2C'!
Object subclass: #MineFieldPlayer
	instanceVariableNames: 'position lives armour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2023-2C'!

!MineFieldPlayer methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 13:39:14'!
initializeStartOn: aStartingPosition Lives: playerLives  
	
	lives := playerLives.
	position := aStartingPosition.
	armour := NoArmour new.! !


!MineFieldPlayer methodsFor: 'position' stamp: 'JCM 11/21/2024 10:15:59'!
positionIs: anExpectedPosition 
	
	^position = anExpectedPosition ! !


!MineFieldPlayer methodsFor: 'move' stamp: 'JCM 11/21/2024 14:11:14'!
canBeMovedTo: aPosition withMineFieldExtention: aMineFieldExtention

	  
	
	^aPosition between: 1@1 and: aMineFieldExtention! !

!MineFieldPlayer methodsFor: 'move' stamp: 'JCM 11/21/2024 11:03:33'!
canMoveDown
	self shouldBeImplemented.! !

!MineFieldPlayer methodsFor: 'move' stamp: 'JCM 11/21/2024 11:48:21'!
canMoveDownWithoutFalling: aMineFieldExtention

	| newPosition |
	
	newPosition := position x @ (position y - 1).
	
	(newPosition between: 1@1 and: aMineFieldExtention) ifTrue:[position := newPosition].
	
	^position
	! !

!MineFieldPlayer methodsFor: 'move' stamp: 'JCM 11/21/2024 13:09:08'!
canMoveLeftWithoutFalling: aMineFieldExtention 

	| newPosition |
	
	newPosition := (position x - 1) @ position y.
	
	
	(newPosition between: 1@1 and: aMineFieldExtention) ifTrue:[position := newPosition ].
	
	^position! !

!MineFieldPlayer methodsFor: 'move' stamp: 'JCM 11/21/2024 11:51:35'!
canMoveRightWithoutFalling: aMineFieldExtention 

	| newPosition |
	
	"Limpiar codigo repetido "
	
	newPosition := (position x + 1) @ position y .
	
	(newPosition between: 1@1 and: aMineFieldExtention) ifTrue:[position := newPosition ].
	
	^position! !

!MineFieldPlayer methodsFor: 'move' stamp: 'JCM 11/21/2024 11:39:01'!
canMoveUpWithoutFalling: aMineFieldExtention 

	| newPosition |
	
	newPosition := position x @ (position y + 1).
	
	(newPosition between: 1@1 and: aMineFieldExtention) ifTrue:[position := newPosition ].
	
	^position! !


!MineFieldPlayer methodsFor: 'lives' stamp: 'JCM 11/21/2024 11:36:07'!
livesAre: anExpectedPlayerLives

	^lives  = anExpectedPlayerLives ! !


!MineFieldPlayer methodsFor: 'isHit' stamp: 'JCM 11/21/2024 14:06:32'!
isHitByAHighMineAndFlightsTo: aRandomPosition in: aMineField
	
	"Todo hacer que se mueva a la posicion y que se fije si habia otro objeto"
	
	armour protects: self FromHighMineWantingToFlyTo: aRandomPosition in: aMineField.
	
	! !

!MineFieldPlayer methodsFor: 'isHit' stamp: 'JCM 11/21/2024 13:53:12'!
isHitByAHighPowerMineWithLightArmourAndFliesTo: aRandomPosition

	 
	position := position + aRandomPosition.! !

!MineFieldPlayer methodsFor: 'isHit' stamp: 'JCM 11/21/2024 14:28:51'!
isHitByAHighPowerMineWithNoArmourAndFliesTo: aRandomPosition in: aMineField  
	
	lives := lives - 2.
	
	aMineField removeObjectAt: position.
	
	position  := position + aRandomPosition.
	
	aMineField movePlayerTo: position.! !

!MineFieldPlayer methodsFor: 'isHit' stamp: 'JCM 11/21/2024 14:17:38'!
isHitByALowMineIn: aMineField
	
	armour protects: self FromLowPowerMineIn: aMineField.! !

!MineFieldPlayer methodsFor: 'isHit' stamp: 'JCM 11/21/2024 14:46:58'!
isHitByALowMineWithALightArmour
	
	armour := NoArmour! !

!MineFieldPlayer methodsFor: 'isHit' stamp: 'JCM 11/21/2024 14:20:26'!
isHitByALowMineWithNoArmourIn: aMineField
	
	lives := lives - 1.
	
	aMineField removeObjectAt: position.! !


!MineFieldPlayer methodsFor: 'equip' stamp: 'JCM 11/21/2024 14:34:44'!
equip: anArmour 
	
	
	
	armour := anArmour ! !

!MineFieldPlayer methodsFor: 'equip' stamp: 'JCM 11/21/2024 13:25:28'!
hasEquiped: lightArmour 
	
	^ armour = lightArmour ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MineFieldPlayer class' category: #'Parcial2023-2C'!
MineFieldPlayer class
	instanceVariableNames: ''!

!MineFieldPlayer class methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 11:26:03'!
startOn: aStartingPosition playerLives: lives  
	
	self assertIsValidStartingPosition: aStartingPosition.
	
	^self new initializeStartOn: aStartingPosition Lives: lives ! !


!MineFieldPlayer class methodsFor: 'assert' stamp: 'JCM 11/21/2024 10:50:57'!
assertIsValidStartingPosition: aStartingPosition 
	
	(aStartingPosition y = 1) ifFalse:[self error: self playerOnlyBegginsOnTheFirstRow]! !


!MineFieldPlayer class methodsFor: 'error' stamp: 'JCM 11/21/2024 10:22:14'!
playerOnlyBegginsOnTheFirstRow
	
	'A player cannot begging on another row rather than the first'! !



!classDefinition: #Mines category: #'Parcial2023-2C'!
Object subclass: #Mines
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2023-2C'!

!Mines methodsFor: 'affect' stamp: 'JCM 11/21/2024 13:15:04'!
affect: aPlayer in: aMineField

	self subclassResponsibility! !


!Mines methodsFor: 'register' stamp: 'JCM 11/21/2024 13:15:14'!
registerOn: objectsPositions

	objectsPositions at: position put: self.
	! !


!classDefinition: #HighPowerMine category: #'Parcial2023-2C'!
Mines subclass: #HighPowerMine
	instanceVariableNames: 'randomGenerator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2023-2C'!

!HighPowerMine methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 12:22:47'!
initializeOn: aMineFieldPosition 
	
	position := aMineFieldPosition.! !

!HighPowerMine methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 12:51:18'!
initializePositionOn: aMineFieldPosition withRandomGenerator: aRandomGenerator 
	
	position := aMineFieldPosition.
	randomGenerator := aRandomGenerator.! !



!HighPowerMine methodsFor: 'affect' stamp: 'JCM 11/21/2024 13:03:41'!
affect: aPlayer in: aMineField

	| randomPosition |
	
	randomPosition := randomGenerator nextInteger.
	
	aPlayer isHitByAHighMineAndFlightsTo: randomPosition in: aMineField.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HighPowerMine class' category: #'Parcial2023-2C'!
HighPowerMine class
	instanceVariableNames: ''!

!HighPowerMine class methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 12:51:04'!
on: aMineFieldPosition randomGenerator: aRandomGenerator 

	^self new initializePositionOn: aMineFieldPosition withRandomGenerator: aRandomGenerator! !


!classDefinition: #LowPowerMine category: #'Parcial2023-2C'!
Mines subclass: #LowPowerMine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2023-2C'!

!LowPowerMine methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 11:29:30'!
initializeOn: aPosition 
	
	position := aPosition.! !



!LowPowerMine methodsFor: 'affect' stamp: 'JCM 11/21/2024 14:17:05'!
affect: aPlayer in: aMineField

	aPlayer isHitByALowMineIn: aMineField! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LowPowerMine class' category: #'Parcial2023-2C'!
LowPowerMine class
	instanceVariableNames: ''!

!LowPowerMine class methodsFor: 'instance creation' stamp: 'JCM 11/21/2024 13:38:16'!
on: aPosition 

	^self new initializeOn: aPosition ! !
