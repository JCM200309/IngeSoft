!classDefinition: #LaddersSlides3DTests category: #'Parcial2022-1C'!
TestCase subclass: #LaddersSlides3DTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2022-1C'!

!LaddersSlides3DTests methodsFor: 'test' stamp: 'JCM 11/17/2024 17:53:44'!
test01AGameWithoutStairsOrSlidesCanBeFinishedIn1Throw
	
	| floor1 floor2 game |
	
	
	floor1 := Floor dimensions: 2@2.
	floor2 := Floor dimensions: 2@2.
	
	game := Game 
		startingFloor: floor1 
		endingFloor: floor1
		startingPosition: 1@1
		ends: 2@1 
		floors: (OrderedCollection with: floor1 with: floor2) 
		numberOfPlayers: 2 .
	
	game player: 1 throwsDiceX: 7 Y:6.
	
	self assert: (game wonPlayer: 1).
	self assert: (game player: 1 on: floor1)
	
! !

!LaddersSlides3DTests methodsFor: 'test' stamp: 'JCM 11/17/2024 18:18:15'!
test02InAGameWithStairsAPlayerKnowsHowToUseThem
	
	| floor1 floor2 game stairFloor1 |
	
	floor2 := Floor dimensions: 2@2.
	
	stairFloor1 := Stairs atPosition: 2@1 goTo: floor2 atPosition: 1@1.
	
	floor1 := Floor dimensions: 2@2 stairsAt: (OrderedCollection with: stairFloor1 ).
	
	
	game := Game 
		startingFloor: floor1 
		endingFloor: floor1
		startingPosition: 1@1
		ends: 2@1 
		floors: (OrderedCollection with: floor1 with: floor2) 
		numberOfPlayers: 2 .
	
	game player: 1 throwsDiceX: 7 Y:6.
	
	self assert: (game player: 1 isInPosition: 1@1 floor: 2).
	
! !


!classDefinition: #Floor category: #'Parcial2022-1C'!
Object subclass: #Floor
	instanceVariableNames: 'dimensions floorsDimension stairs floorStairs_CHANGE_ME'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2022-1C'!

!Floor methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 17:57:47'!
initializeDimensions: aFloorsDimension 
	
	floorsDimension := aFloorsDimension.
	stairs := OrderedCollection new.! !

!Floor methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 18:17:27'!
initializeDimensions: aFloorsDimension stairsAt: floorStairs 
	
	floorsDimension := aFloorsDimension.
	stairs := floorStairs.! !


!Floor methodsFor: 'stairs' stamp: 'JCM 11/17/2024 18:34:07'!
hasStairsAt: aSourcePosition 
	
	^stairs anySatisfy: [:floorStairs | floorStairs sourcePosition: aSourcePosition]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Floor class' category: #'Parcial2022-1C'!
Floor class
	instanceVariableNames: ''!

!Floor class methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 17:35:54'!
dimensions: aFloorsDimension

	^self new initializeDimensions: aFloorsDimension ! !

!Floor class methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 17:33:46'!
dimensions: aPoint floor: aStartingFloor
	
	^self new initializeDimensions: aPoint andStartingFloor: aStartingFloor.! !

!Floor class methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 18:17:08'!
dimensions: aFloorsDimension stairsAt: floorStairs 
	
	^self new initializeDimensions: aFloorsDimension stairsAt: floorStairs ! !


!classDefinition: #Game category: #'Parcial2022-1C'!
Object subclass: #Game
	instanceVariableNames: 'floors players startingFloor startingPosition endingPosition endingFloor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2022-1C'!

!Game methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 17:43:39'!
createPlayers: amountOfPlayers on: aStartingFloor 
	
	
	amountOfPlayers timesRepeat: [players add: (Player position: startingPosition floor: aStartingFloor)]! !

!Game methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 17:56:30'!
initializeStartingFloor: aStartingFloor endingFloor: anEndingFloor startingPosition: aStartingPosition ends: anEndingPosition floors: gameFloors numberOfPlayers: amountOfPlayers 
	
	
	startingFloor := aStartingFloor.
	endingFloor := anEndingFloor.
	startingPosition := aStartingPosition.
	endingPosition := anEndingPosition.
	floors := gameFloors.
	players := OrderedCollection new.
	self createPlayers: amountOfPlayers on: aStartingFloor .! !

!Game methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 17:38:11'!
initializeStartingFloor: aStartingFloor startingPosition: aStartingPosition ends: anEndingPosition floors: gameFloors numberOfPlayers: amountOfPlayers 
	
	startingFloor := aStartingFloor.
	startingPosition := aStartingPosition.
	endingPosition := anEndingPosition.
	floors := gameFloors.
	players := OrderedCollection new.
	self createPlayers: amountOfPlayers on: aStartingFloor .! !


!Game methodsFor: 'throwing' stamp: 'JCM 11/17/2024 18:30:48'!
player: playersId throwsDiceX: diceValueX Y: diceValueY 

	| player |
	
	player := players at: playersId.
	
	player moveX: (diceValueX - 6) moveY: (diceValueY - 6).
	
	(player isInStairs) ifTrue: [player moveFloorTo: (floors at: 2)].
	
	
	
	! !


!Game methodsFor: 'testing' stamp: 'JCM 11/17/2024 18:21:27'!
player: aPlayersId isInPosition: aPlayersPosition floor: aFloor 
	
	^(players at: aPlayersId) isInPosition: aPlayersPosition atFloor: aFloor
	
	! !

!Game methodsFor: 'testing' stamp: 'JCM 11/17/2024 17:32:32'!
player: aPlayersId on: aFloor
	
	| player |
	player := players at: aPlayersId.
	
	^player isAtFloor: aFloor.! !

!Game methodsFor: 'testing' stamp: 'JCM 11/17/2024 17:44:22'!
wonPlayer: aPlayersId
	
	| player |
	
	player := players at: aPlayersId.
	
	^player isAt: endingPosition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Game class' category: #'Parcial2022-1C'!
Game class
	instanceVariableNames: ''!

!Game class methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 17:55:02'!
startingFloor: aStartingFloor endingFloor: anEndingFloor startingPosition: aStartingPosition ends: anEndingPosition floors: gameFloors numberOfPlayers: amountOfPlayers 
	
	^self new initializeStartingFloor: aStartingFloor endingFloor: anEndingFloor startingPosition: aStartingPosition ends: anEndingPosition floors: gameFloors numberOfPlayers: amountOfPlayers ! !


!classDefinition: #Player category: #'Parcial2022-1C'!
Object subclass: #Player
	instanceVariableNames: 'position floor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2022-1C'!

!Player methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 17:41:19'!
initializePosition: aStartingPlayersPoint floor: aStartingFloor 
	
	position := aStartingPlayersPoint.
	floor := aStartingFloor.! !


!Player methodsFor: 'move' stamp: 'JCM 11/17/2024 17:25:29'!
moveX: anXMovement moveY: anYMovement 
	
	position := (position x + anXMovement) @ (position y + anYMovement).! !


!Player methodsFor: 'testing' stamp: 'JCM 11/17/2024 17:27:25'!
isAt: gamesEndingPoint
	
	^position = gamesEndingPoint! !

!Player methodsFor: 'testing' stamp: 'JCM 11/17/2024 17:33:03'!
isAtFloor: aFloor 
	
	
	^floor = aFloor.! !

!Player methodsFor: 'testing' stamp: 'JCM 11/17/2024 18:22:33'!
isInPosition: aPlayersPosition atFloor: aFloor 
	
	^ position = aPlayersPosition & (floor = aFloor)! !


!Player methodsFor: 'stairs' stamp: 'JCM 11/17/2024 18:32:01'!
isInStairs
	
	"Me fijo si piso del jugador en la posicion del jugador es una escalera"
	
	^ floor hasStairsAt: position! !

!Player methodsFor: 'stairs' stamp: 'JCM 11/17/2024 18:29:03'!
isInStairs: gameFloors

	gameFloors
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Player class' category: #'Parcial2022-1C'!
Player class
	instanceVariableNames: ''!

!Player class methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 17:20:08'!
position: playersStartingPoint

	^self new initializePosition: playersStartingPoint ! !

!Player class methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 17:39:11'!
position: aStartingPlayersPoint floor: aStartingFloor 
	
	^self new initializePosition: aStartingPlayersPoint floor: aStartingFloor ! !


!classDefinition: #Stairs category: #'Parcial2022-1C'!
Object subclass: #Stairs
	instanceVariableNames: 'sourcePosition destinationFloor destinationPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2022-1C'!

!Stairs methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 17:59:12'!
initializeAtPosition: aSourcePosition goTo: aDestinationFloor atPosition: aDestinationPosition 
	
	sourcePosition := aSourcePosition.
	destinationFloor := aDestinationFloor.
	destinationPosition := aDestinationPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Stairs class' category: #'Parcial2022-1C'!
Stairs class
	instanceVariableNames: ''!

!Stairs class methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 17:58:30'!
atPosition: aSourcePosition goTo: aDestinationFloor atPosition: aDestinationPosition 
	
	^self new initializeAtPosition: aSourcePosition goTo: aDestinationFloor atPosition: aDestinationPosition ! !
