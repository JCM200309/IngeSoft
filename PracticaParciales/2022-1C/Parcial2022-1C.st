!classDefinition: #LaddersAndSlidesTests category: #'Parcial2022-1C'!
TestCase subclass: #LaddersAndSlidesTests
	instanceVariableNames: 'dice diceX diceY diceXMoves diceYMoves'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2022-1C'!

!LaddersAndSlidesTests methodsFor: 'dice' stamp: 'JCM 11/17/2024 22:49:22'!
addDiceMove: aDiceThrow 
	
	diceXMoves add: aDiceThrow x.
	diceYMoves add: aDiceThrow y! !

!LaddersAndSlidesTests methodsFor: 'dice' stamp: 'JCM 11/17/2024 19:24:06'!
dice: aDiceResult

	diceX := aDiceResult x.
	diceY := aDiceResult y
	! !

!LaddersAndSlidesTests methodsFor: 'dice' stamp: 'JCM 11/17/2024 22:53:29'!
rollX

	^diceXMoves removeFirst ! !

!LaddersAndSlidesTests methodsFor: 'dice' stamp: 'JCM 11/17/2024 22:53:45'!
rollY
	
	^diceYMoves removeFirst ! !


!LaddersAndSlidesTests methodsFor: 'setUp' stamp: 'JCM 11/17/2024 22:52:48'!
setUp

	diceXMoves := OrderedCollection new.
	diceYMoves := OrderedCollection new! !


!LaddersAndSlidesTests methodsFor: 'tests' stamp: 'JCM 11/17/2024 23:01:33'!
test01InANewGamesThePlayersStartInTheGameStartingPosition

	| game player1 player2 floor1 floor2 |
	
	player1 := Player new.
	
	player2 := Player new.
	
	floor1 := Floor extentions: 2@2.
	
	floor2 := Floor extentions: 2@2.
	
	game := LaddersAndSlides 
		players: (OrderedCollection with: player1 with: player2)
		startingOnPosition: 1@1 inFloor: floor1
		endingPosition: 2@1 inFloor: floor2
		floors: (OrderedCollection with: floor1 with: floor2)
		dice: self.
		
	self assert: (game player: 1 position: 1@1 inFloor: floor1).
	self assert: (game player: 2 position: 1@1 inFloor: floor1)! !

!LaddersAndSlidesTests methodsFor: 'tests' stamp: 'JCM 11/18/2024 10:16:19'!
test02InANewGameThePlayersCannotStartInAnyOtherPositionThanTheStart

	| game player1 player2 floor1 floor2 |
	
	player1 := Player new.
	
	player2 := Player new.
	
	floor1 := Floor extentions: 2@2.
	
	floor2 := Floor extentions: 2@2.
	
	game := LaddersAndSlides 
		players: (OrderedCollection with: player1 with: player2)
		startingOnPosition: 1@1 inFloor: floor1
		endingPosition: 2@1 inFloor: floor2
		floors: (OrderedCollection with: floor1 with: floor2) 
		dice: self.
		
	self deny: (game player: 1 position: 2@1 inFloor: floor1).
	self deny: (game player: 2 position: 2@1 inFloor: floor1)! !

!LaddersAndSlidesTests methodsFor: 'tests' stamp: 'JCM 11/17/2024 23:01:05'!
test03inANewGameThePlayersStarInTheGameStartingFloor

	| game player1 player2 floor1 floor2 |
	
	player1 := Player new.
	
	player2 := Player new.
	
	floor1 := Floor extentions: 2@2.
	
	floor2 := Floor extentions: 2@2.
	
	game := LaddersAndSlides 
		players: (OrderedCollection with: player1 with: player2)
		startingOnPosition: 1@1 inFloor: floor1
		endingPosition: 2@1 inFloor: floor2
		floors: (OrderedCollection with: floor1 with: floor2)
		dice: self.
		
	self deny: (game player: 1 position: 1@1 inFloor: floor2).
	self deny: (game player: 2 position: 1@1 inFloor: floor2)! !

!LaddersAndSlidesTests methodsFor: 'tests' stamp: 'JCM 11/17/2024 23:00:58'!
test04WhenAGameIsPlayedAPlayerKnowsHowToMoveInTheSameFloor

	| game player1 player2 floor1 floor2 |
	
	"Ya empiezo a simular el dado, el test es el dado"
	self addDiceMove: 7@6.
	
	player1 := Player new.
	
	player2 := Player new.
	
	floor1 := Floor extentions: 2@2.
	
	floor2 := Floor extentions: 2@2.
	
	game := LaddersAndSlides 
		players: (OrderedCollection with: player1 with: player2)
		startingOnPosition: 1@1 inFloor: floor1
		endingPosition: 2@1 inFloor: floor2
		floors: (OrderedCollection with: floor1 with: floor2)
		dice: self.
	
	game playerPlays: 1.
	
	self assert: (game player: 1 position: 2@1 inFloor: floor1).
	self assert: (game player: 2 position: 1@1 inFloor: floor1)! !

!LaddersAndSlidesTests methodsFor: 'tests' stamp: 'JCM 11/17/2024 23:00:49'!
test05WhenAGameIsPlayedThePlayerCannotFallFromTheFloor

	| game player1 player2 floor1 floor2 |
	
	"Ahora el jugador tiene que poder conocer un objeto floor que tenga los limites en este"
	
	self addDiceMove: 8@9.
	
	player1 := Player new.
	
	player2 := Player new.
	
	floor1 := Floor extentions: 2@2.
	
	floor2 := Floor extentions: 2@2.
	
	
	game := LaddersAndSlides 
		players: (OrderedCollection with: player1 with: player2)
		startingOnPosition: 1@1 inFloor: floor1
		endingPosition: 2@1 inFloor: floor2
		floors:(OrderedCollection with: floor1 with: floor2)
		dice: self.
	
	game playerPlays: 1.
	
	self assert: (game player: 1 position: 2@2 inFloor: floor1).
	self assert: (game player: 2 position: 1@1 inFloor: floor1)! !

!LaddersAndSlidesTests methodsFor: 'tests' stamp: 'JCM 11/17/2024 23:03:39'!
test06WhenAPlayerReachesAStairPositionItChangesItsFloor

	| game player1 player2 floor1 floor2 stair1 |
	
	"Ahora el jugador tiene que poder conocer un objeto floor que tenga los limites en este"
	
	self addDiceMove: 7@6.
	
	player1 := Player new.
	
	player2 := Player new.
	
	floor2 := Floor extentions: 2@2  .
	
	stair1 := ShortCut inSourceFloor: 2@1 goesTo: 1@1 in: floor2.
	
	floor1 := Floor extentions: 2@2.
	
	floor1 addStair: stair1.
	
	game := LaddersAndSlides 
		players: (OrderedCollection with: player1 with: player2)
		startingOnPosition: 1@1 inFloor: floor1
		endingPosition: 2@1 inFloor: floor2
		floors:(OrderedCollection with: floor1 with: floor2)
		dice: self.
	
	game playerPlays: 1.
	
	self assert: (game player: 1 position: 1@1 inFloor: floor2).
	self assert: (game player: 2 position: 1@1 inFloor: floor1)! !

!LaddersAndSlidesTests methodsFor: 'tests' stamp: 'JCM 11/17/2024 21:56:05'!
test07AGameCanHaveMoreThanOneDiceThrows

	"Aca tendria que configurar el dado para que se pueda tirar mas de una vez"! !

!LaddersAndSlidesTests methodsFor: 'tests' stamp: 'JCM 11/18/2024 11:37:21'!
test08WhenAPlayerReachesASlidePositionItChangesItsFloor

	| game player1 player2 floor1 floor2 slide1 |
	
	"ToDo sacar el stairsAt de floor y que se inicialize con una colleccion vacia"
	
	self addDiceMove: 6@7.
	
	player1 := Player new.
	
	player2 := Player new.
	
	floor2 := Floor extentions: 2@2  .
	
	floor1 := Floor extentions: 2@2.
	
	slide1 := ShortCut inSourceFloor: 1@2 goesTo: 2@2 in: floor1.
	
	floor2 addShortcut: slide1.
	
	game := LaddersAndSlides 
		players: (OrderedCollection with: player1 with: player2)
		startingOnPosition: 1@1 inFloor: floor2
		endingPosition: 2@1 inFloor: floor1
		floors:(OrderedCollection with: floor1 with: floor2)
		dice: self.
	
	game playerPlays: 1.
	
	self assert: (game player: 1 position: 2@2 inFloor: floor1).
	self assert: (game player: 2 position: 1@1 inFloor: floor2)! !

!LaddersAndSlidesTests methodsFor: 'tests' stamp: 'JCM 11/17/2024 22:56:49'!
test09APlayerWinsWhenItReachesTheEndingGamePosition

	| game player1 player2 floor1 floor2 player3 players |
	
	"ToDo sacar el stairsAt de floor y que se inicialize con una colleccion vacia"
	
	self addDiceMove: 7@6.
	self addDiceMove: 6@6.
	
	player1 := Player new.
	
	player2 := Player new.
	
	player3 := Player new.
	
	floor1 := Floor extentions: 2@2.
	
	floor2 := Floor extentions: 2@2.
	
	players := OrderedCollection new.
	players add: player1.
	players add: player2.
	players add: player3.
	
	game := LaddersAndSlides 
		players: players
		startingOnPosition: 1@1 inFloor: floor2
		endingPosition: 2@1 inFloor: floor2
		floors:(OrderedCollection with: floor1 with: floor2)
		dice: self.
	
	game playerPlays: 1.
	game playerPlays: 2.
	
	
	self assert: (game player: 1 position: 2@1 inFloor: floor2).
	self assert: (game player: 2 position: 1@1 inFloor: floor2).
	self assert: (game player: 3 position: 1@1 inFloor: floor2).
	
	self assert: (game wonBy: 1)
	! !

!LaddersAndSlidesTests methodsFor: 'tests' stamp: 'JCM 11/18/2024 11:30:09'!
test10AGameCannotBeCreatedIfTheresIsMoreThanOneShortcutInOnePositionInTheSameFloor

	| player1 player2 floor1 floor2 player3 players floor3 stair1 slide1 floors |
	
	
	self addDiceMove: 7@6.
	self addDiceMove: 6@6.
	
	player1 := Player new.
	
	player2 := Player new.
	
	player3 := Player new.
	
	floor1 := Floor extentions: 2@2.
	
	floor2 := Floor extentions: 2@2.
	
	floor3 := Floor extentions: 2@2.
	
	stair1 := ShortCut inSourceFloor: 1@2 goesTo: 1@1 in: floor3.
	
	slide1 := ShortCut inSourceFloor: 1@2 goesTo: 2@1 in: floor1.
	
	floor2 addShortcut: stair1.
	floor2 addShortcut: slide1.
	
	players := OrderedCollection new.
	players add: player1.
	players add: player2.
	players add: player3.
	
	floors := OrderedCollection new.
	floors add: floor1.
	floors add: floor2.
	floors add: floor3.
	
	self should: [LaddersAndSlides 
		players: players
		startingOnPosition: 1@1 inFloor: floor2
		endingPosition: 2@1 inFloor: floor2
		floors:floors
		dice: self]
	
		raise: Error - MessageNotUnderstood 
		
		withExceptionDo: [:error | self assert: (error messageText = LaddersAndSlides cannotHaveMoreThanOneShortcutInTheSamePosition)]
		
		"Todo pensar side effects"
		
	
	
	
	! !

!LaddersAndSlidesTests methodsFor: 'tests' stamp: 'JCM 11/18/2024 11:34:32'!
test11AGameCannotBeCreatedIfTheresIsAShortcutInTheStartingPosition

	| player1 player2 floor1 floor2 player3 players floors slide1 |
	
	
	self addDiceMove: 7@6.
	self addDiceMove: 6@6.
	
	player1 := Player new.
	
	player2 := Player new.
	
	player3 := Player new.
	
	floor1 := Floor extentions: 2@2.
	
	floor2 := Floor extentions: 2@2.
	
	slide1 := ShortCut inSourceFloor: 1@1 goesTo: 1@1 in: floor1.
	
	floor2 addShortcut: slide1.
		
	players := OrderedCollection new.
	players add: player1.
	players add: player2.
	players add: player3.
	
	floors := OrderedCollection new.
	floors add: floor1.
	floors add: floor2.
	
	self should: [LaddersAndSlides 
		players: players
		startingOnPosition: 1@1 inFloor: floor2
		endingPosition: 2@1 inFloor: floor2
		floors:floors
		dice: self]
	
		raise: Error - MessageNotUnderstood 
		
		withExceptionDo: [:error | self assert: (error messageText = LaddersAndSlides cannotBeAShortcutOnTheStartingOrEndingPosition)]
		
		"Todo pensar side effects"
		
	
	
	
	! !

!LaddersAndSlidesTests methodsFor: 'tests' stamp: 'JCM 11/18/2024 11:34:58'!
test12AGameCannotBeCreatedIfTheresIsAShortcutInTheEndingPosition

	| player1 player2 floor1 floor2 player3 players floors slide1 |
	
	
	self addDiceMove: 7@6.
	self addDiceMove: 6@6.
	
	player1 := Player new.
	
	player2 := Player new.
	
	player3 := Player new.
	
	floor1 := Floor extentions: 2@2.
	
	floor2 := Floor extentions: 2@2.
	
	slide1 := ShortCut inSourceFloor: 2@1 goesTo: 1@1 in: floor1.
	
	floor2 addShortcut: slide1.
		
	players := OrderedCollection new.
	players add: player1.
	players add: player2.
	players add: player3.
	
	floors := OrderedCollection new.
	floors add: floor1.
	floors add: floor2.
	
	
	
	self should: [LaddersAndSlides 
		players: players
		startingOnPosition: 1@1 inFloor: floor2
		endingPosition: 2@1 inFloor: floor2
		floors:floors
		dice: self]
	
		raise: Error - MessageNotUnderstood 
		
		withExceptionDo:[:error | self assert: (error messageText = LaddersAndSlides cannotBeAShortcutOnTheStartingOrEndingPosition)]
		
		"Todo pensar side effects"
		
	
	
	
	! !

!LaddersAndSlidesTests methodsFor: 'tests' stamp: 'JCM 11/18/2024 11:50:16'!
test13AGameCannotBeCreatedIfTheresIsAShortcutLoop

	| player1 player2 floor1 floor2 player3 players floors slide1 stair1 |
	
	
	self addDiceMove: 7@6.
	self addDiceMove: 6@6.
	
	player1 := Player new.
	
	player2 := Player new.
	
	player3 := Player new.
	
	floor1 := Floor extentions: 4@4.
	
	floor2 := Floor extentions: 4@4.
	
	slide1 := ShortCut inSourceFloor: 2@1 goesTo: 1@1 in: floor1.
	
	stair1 := ShortCut inSourceFloor: 1@1 goesTo: 2@1  in: floor2.
	
	floor2 addShortcut: slide1.
	floor1 addShortcut: stair1.
		
	players := OrderedCollection new.
	players add: player1.
	players add: player2.
	players add: player3.
	
	floors := OrderedCollection new.
	floors add: floor1.
	floors add: floor2.
	
	
	self should: [LaddersAndSlides 
		players: players
		startingOnPosition: 3@3 inFloor: floor2
		endingPosition: 4@4 inFloor: floor2
		floors:floors
		dice: self]
	
		raise: Error - MessageNotUnderstood 
		
		withExceptionDo:[:error | self assert: (error messageText = LaddersAndSlides xxx)]
		
		
		
	
	
	
	! !


!classDefinition: #Floor category: #'Parcial2022-1C'!
Object subclass: #Floor
	instanceVariableNames: 'extentions shortcuts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2022-1C'!

!Floor methodsFor: 'instance creation' stamp: 'JCM 11/18/2024 10:27:09'!
initializeExtentions: aFloorExtentions 
	
	extentions := aFloorExtentions.
	shortcuts := OrderedCollection new.! !

!Floor methodsFor: 'instance creation' stamp: 'JCM 11/18/2024 10:27:09'!
initializeExtentions: aFloorExtentions stairsAt: floorStairs 
	
	extentions := aFloorExtentions.
	shortcuts := OrderedCollection new.! !


!Floor methodsFor: 'limits' stamp: 'JCM 11/17/2024 20:08:11'!
isBetweenLimits: aDestinationPosition 
	
	^extentions x >= aDestinationPosition x & (extentions y >= aDestinationPosition y)! !


!Floor methodsFor: 'extention' stamp: 'JCM 11/17/2024 20:19:05'!
extention
	
	^extentions ! !


!Floor methodsFor: 'stairs' stamp: 'JCM 11/18/2024 10:27:09'!
addStair: aStair
	
	shortcuts add: aStair! !

!Floor methodsFor: 'stairs' stamp: 'JCM 11/18/2024 11:22:50'!
findDestinationStairsPositionIn: aPositionToMove 

	"Mejorar uniendo isPlayerOnAStairsPosition y este metodo"
	
	| stairInPosition |
	
	stairInPosition := shortcuts detect:[:stair | stair isInPosition:aPositionToMove ].
	
	^stairInPosition
	
	! !

!Floor methodsFor: 'stairs' stamp: 'JCM 11/18/2024 11:22:50'!
isPlayerOnAStairsPosition: aPositionToMove 
	
	
	^shortcuts anySatisfy: [:stair | stair isInPosition: aPositionToMove]! !


!Floor methodsFor: 'shortcuts' stamp: 'JCM 11/18/2024 10:27:24'!
addShortcut: aShortcut
	
	shortcuts add: aShortcut ! !

!Floor methodsFor: 'shortcuts' stamp: 'JCM 11/18/2024 12:02:42'!
hasLoopShortcut: shortcut 
	self shouldBeImplemented.! !

!Floor methodsFor: 'shortcuts' stamp: 'JCM 11/18/2024 11:23:47'!
hasShortcutIn: gameStartingPosition
	
	^shortcuts anySatisfy: [:shortcut | shortcut isInPosition: gameStartingPosition ]! !

!Floor methodsFor: 'shortcuts' stamp: 'JCM 11/18/2024 12:05:53'!
shortcutsEntersInALoop
	
	| visitedShortcuts |
	
	"Pensar de mejorar con un visitor"
	
	visitedShortcuts := OrderedCollection new.
	
	^shortcuts do:[:shortcut | self visit: shortcut andAdd:visitedShortcuts]
	! !

!Floor methodsFor: 'shortcuts' stamp: 'JCM 11/18/2024 12:15:13'!
visit: shortcut andAdd: visitedShortcuts 
	
	shortcut visitShortcutPositions: shortcuts AndAddTo: visitedShortcuts.! !


!Floor methodsFor: 'assert' stamp: 'JCM 11/18/2024 10:48:31'!
hasMoreThanOneShortcutInAPosition
	
	| shortcutsPositions |
	
	"Todo como no violar encapsulamiento en shortcuts"
	
	shortcutsPositions := shortcuts collect: [:shortcut | shortcut sourceFloorPosition].
	
	^shortcutsPositions anySatisfy: [:shortcutPos | (shortcutsPositions occurrencesOf: shortcutPos) > 1]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Floor class' category: #'Parcial2022-1C'!
Floor class
	instanceVariableNames: ''!

!Floor class methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 20:02:57'!
extentions: aFloorExtentions 
	
	^self new initializeExtentions: aFloorExtentions ! !

!Floor class methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 21:00:16'!
extentions: aFloorExtentions stairsAt: floorStairs 
	
	^self new initializeExtentions: aFloorExtentions stairsAt: floorStairs ! !


!classDefinition: #LaddersAndSlides category: #'Parcial2022-1C'!
Object subclass: #LaddersAndSlides
	instanceVariableNames: 'players startingPosition startingFloor endingPosition endingFloor floors dice positionAfterDiceRoll playersPosition playersFloor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2022-1C'!

!LaddersAndSlides methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 22:59:47'!
initializePlayers: gamePlayers startingOnPosition: gameStartingPosition inFloor: gameStartingFloor endingPosition: gameEndingPosition inFloor: gameEndingFloor floors: gameFloors dice: aDice  
	
	players := gamePlayers.
	startingPosition := gameStartingPosition.
	startingFloor := gameStartingFloor.
	endingPosition := gameEndingPosition.
	endingFloor := gameEndingFloor.
	floors := gameFloors.
	dice := aDice.
	
	
	self playersOnStartPositionAndStartFloor.
	
	! !

!LaddersAndSlides methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 20:02:14'!
playersOnStartPositionAndStartFloor
	
	"Todo: para no romper encapsulamiento podria hacer que el juego directamente cree a los jugadores"
	
	players do:[:player | player position: startingPosition floor: startingFloor ]! !


!LaddersAndSlides methodsFor: 'testing' stamp: 'JCM 11/17/2024 19:54:46'!
player: aPlayer position: anExpectedPlayersPosition inFloor: anExpectedPlayersFloor 
	
	^(players at: aPlayer) isOn: anExpectedPlayersPosition in: anExpectedPlayersFloor ! !

!LaddersAndSlides methodsFor: 'testing' stamp: 'JCM 11/17/2024 22:56:36'!
wonBy: aPlayersId
	
	| player |
	
	player := players at: aPlayersId.
	
	^ player isOn: endingPosition in: endingFloor ! !


!LaddersAndSlides methodsFor: 'play' stamp: 'JCM 11/18/2024 10:21:41'!
playerPlays: aPlayer
	
	
	positionAfterDiceRoll := (dice rollX - 6) @ (dice rollY - 6).
	
	self changePlayersPosition: aPlayer.
	! !


!LaddersAndSlides methodsFor: 'position' stamp: 'JCM 11/18/2024 10:21:41'!
changePlayersPosition: aPlayer 
	
	| player |
	
	player := players at: aPlayer.
	
	player moveTo: positionAfterDiceRoll
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LaddersAndSlides class' category: #'Parcial2022-1C'!
LaddersAndSlides class
	instanceVariableNames: ''!

!LaddersAndSlides class methodsFor: 'instance creation' stamp: 'JCM 11/18/2024 11:16:16'!
players: gamePlayers startingOnPosition: gameStartingPosition inFloor: startingFloor endingPosition: endingPosition inFloor: endingFloor floors: gameFloors dice: aDice  
	
	self assertValidShortcuts: gameFloors inGameStartingOn: gameStartingPosition inFloor: startingFloor endingPosition: endingPosition inFloor: endingFloor.
	
	^self new initializePlayers: gamePlayers startingOnPosition: gameStartingPosition inFloor: startingFloor endingPosition: endingPosition inFloor: endingFloor floors: gameFloors dice: aDice  ! !


!LaddersAndSlides class methodsFor: 'assert' stamp: 'JCM 11/18/2024 11:12:28'!
assertNoShortcutWithTheSamePositionAndFloor: gameFloors
	
	"Tendria que ir chequeando si cada uno de los pisos tiene mas de un shortcut en esa posicion"
	(gameFloors anySatisfy:[:gamefloor | gamefloor hasMoreThanOneShortcutInAPosition]) ifTrue:[self error: self cannotHaveMoreThanOneShortcutInTheSamePosition]
	! !

!LaddersAndSlides class methodsFor: 'assert' stamp: 'JCM 11/18/2024 11:34:32'!
assertTheresNo: gameFloors withShortcutInThe: gamePosition in: gameFloor	

	^(gameFloors anySatisfy:[:gamefloor | gamefloor = gameFloor and:[gamefloor hasShortcutIn: gamePosition]]) ifTrue:[self error: self cannotBeAShortcutOnTheStartingOrEndingPosition ]! !

!LaddersAndSlides class methodsFor: 'assert' stamp: 'JCM 11/18/2024 12:01:31'!
assertTheresNoLoopsIn: gameFloors 
	
	"Hay que ver si yendo por un slide o por una stair termino en el mismo que empece"
	
	(gameFloors anySatisfy: [:gameFloor | gameFloor shortcutsEntersInALoop]) ifTrue:[self error: self xxx]! !

!LaddersAndSlides class methodsFor: 'assert' stamp: 'JCM 11/18/2024 11:51:54'!
assertValidShortcuts: gameFloors inGameStartingOn: gameStartingPosition inFloor: startingFloor endingPosition: endingPosition inFloor: endingFloor
	
	
	self assertNoShortcutWithTheSamePositionAndFloor: gameFloors.
	self assertTheresNo: gameFloors withShortcutInThe: gameStartingPosition in: startingFloor.
	self assertTheresNo: gameFloors withShortcutInThe: endingPosition in: endingFloor.
	self assertTheresNoLoopsIn: gameFloors.
	
	
	! !


!LaddersAndSlides class methodsFor: 'errors' stamp: 'JCM 11/18/2024 11:34:43'!
cannotBeAShortcutOnTheStartingOrEndingPosition
	
	^'Cannot be a shortcut on the starting or ending position'! !

!LaddersAndSlides class methodsFor: 'errors' stamp: 'JCM 11/18/2024 10:49:21'!
cannotHaveMoreThanOneShortcutInTheSamePosition
	
	^'Cannot have more than one shortcut in the same position in the same floor'! !


!classDefinition: #Player category: #'Parcial2022-1C'!
Object subclass: #Player
	instanceVariableNames: 'position floor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2022-1C'!

!Player methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 19:44:10'!
initializeWithId: aPlayersId 
	
	playersId := aPlayersId.! !

!Player methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 19:49:00'!
position: aPlayersPosition floor: aPlayersFloor 
	
	position:= aPlayersPosition.
	floor := aPlayersFloor! !



!Player methodsFor: 'move' stamp: 'JCM 11/17/2024 22:39:34'!
isInFloorChangerPosition: aPositionToMove

	^floor isPlayerOnAStairsPosition: aPositionToMove! !

!Player methodsFor: 'move' stamp: 'JCM 11/17/2024 20:06:26'!
isInLimits: aDestinationPosition 
	
	^floor isBetweenLimits: aDestinationPosition.! !

!Player methodsFor: 'move' stamp: 'JCM 11/17/2024 22:39:34'!
moveTo: aPositionToMove 
	
	"Ojo que violo encapsulamiento"
	
	| destinationPosition stairInPosition |
	
	
	destinationPosition := (position x + aPositionToMove x) @ (position y + aPositionToMove y).
	
	(self isInLimits: destinationPosition) ifTrue:[position := destinationPosition] ifFalse:[position := (self moveWhithoutFallingTo: destinationPosition)].
	
	
	
	(self isInFloorChangerPosition: position) ifTrue:[
		stairInPosition := self moveToFloorChangerDestinationFloor: position . 
		position := stairInPosition destinationsPosition.
		floor := stairInPosition destinationsFloor].
	
	
	! !

!Player methodsFor: 'move' stamp: 'JCM 11/17/2024 22:37:44'!
moveToFloorChangerDestinationFloor: aPositionToMove 
	
	^floor findDestinationStairsPositionIn: aPositionToMove.! !

!Player methodsFor: 'move' stamp: 'JCM 11/17/2024 20:18:47'!
moveWhithoutFallingTo: destinationPosition 
	
	^(destinationPosition x min:(floor extention x)) @ (destinationPosition y min: (floor extention y))! !


!Player methodsFor: 'testing' stamp: 'JCM 11/17/2024 19:53:52'!
isOn: anExpectedPlayersPosition in: anExpectedPlayersFloor 
	
	^position = anExpectedPlayersPosition & (floor = anExpectedPlayersFloor )! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Player class' category: #'Parcial2022-1C'!
Player class
	instanceVariableNames: ''!

!Player class methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 19:43:56'!
withId: aPlayersId
	
	^self new initializeWithId: aPlayersId ! !


!classDefinition: #ShortCut category: #'Parcial2022-1C'!
Object subclass: #ShortCut
	instanceVariableNames: 'sourceFloorPosition destinationPosition destinationFloor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2022-1C'!

!ShortCut methodsFor: 'checking position' stamp: 'JCM 11/18/2024 11:22:49'!
isInPosition: aPositionToMove 
	
	^sourceFloorPosition = aPositionToMove ! !

!ShortCut methodsFor: 'checking position' stamp: 'JCM 11/18/2024 11:20:52'!
isInPostion: gameStartingPosition inFloor: startingFloor 
	self shouldBeImplemented.! !

!ShortCut methodsFor: 'checking position' stamp: 'JCM 11/18/2024 12:20:42'!
visitShortcutPositions: shortcuts1 AndAddTo: visitedShortcuts 
	
	| conectedShortcut |
	visitedShortcuts add: self.
	
	conectedShortcut := shortcuts1 detect:[:shortcut | shortcut sourceFloorPositionIs: destinationPosition ].
	
	shortcuts1 remove: conectedShortcut.
	
	shortcuts1 ifNotEmpty:[conectedShortcut visitShortcutPositions: shortcuts1 AndAddTo: visitedShortcuts]! !

!ShortCut methodsFor: 'checking position' stamp: 'JCM 11/18/2024 12:15:00'!
visitShortcutPositionsAndAddTo: visitedShortcuts 
	
	visitedShortcuts ! !


!ShortCut methodsFor: 'getters' stamp: 'JCM 11/17/2024 22:15:37'!
destinationsFloor
	
	^destinationFloor ! !

!ShortCut methodsFor: 'getters' stamp: 'JCM 11/17/2024 22:15:33'!
destinationsPosition
	
	^destinationPosition ! !

!ShortCut methodsFor: 'getters' stamp: 'JCM 11/18/2024 10:43:54'!
sourceFloorPosition
	
	^sourceFloorPosition ! !


!ShortCut methodsFor: 'instance creation' stamp: 'JCM 11/18/2024 10:43:40'!
initializeInSourceFloor: aSourceFloorPosition goesTo: aDestinationFloorPosition in: aDestinationFloor 
	
	sourceFloorPosition := aSourceFloorPosition.
	destinationPosition := aDestinationFloorPosition.
	destinationFloor := aDestinationFloor.! !


!ShortCut methodsFor: 'as yet unclassified' stamp: 'JCM 11/18/2024 12:00:41'!
endsInTheFirstShortcut
	self shouldBeImplemented.! !

!ShortCut methodsFor: 'as yet unclassified' stamp: 'JCM 11/18/2024 12:07:01'!
visitAndAddTo: visitedShortcuts 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShortCut class' category: #'Parcial2022-1C'!
ShortCut class
	instanceVariableNames: ''!

!ShortCut class methodsFor: 'instance creation' stamp: 'JCM 11/17/2024 23:04:02'!
inSourceFloor: aSourceFloor goesTo: aDestinationPosition in: aDestinationsFloor 
	
	^self new initializeInSourceFloor: aSourceFloor goesTo: aDestinationPosition in: aDestinationsFloor ! !
