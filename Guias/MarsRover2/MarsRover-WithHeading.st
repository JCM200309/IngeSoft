!classDefinition: #MarsRover2Test category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRover2Test
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover2Test methodsFor: 'tests' stamp: 'jcm 11/13/2024 12:07:56'!
test01MarsRoverWithoutInstructionsBeginsWithEmptyLogTrackingOnlyPositions

	| marsRover log |
	
	marsRover := MarsRover at: 0@1 heading: MarsRoverHeadingNorth.
	log := Log new.
	
	marsRover attachPosition: log.
	
	self assert: log isEmpty.
	
	"Tendria que hacer este test?"
	"self assert: marsRover knowsOneEmptyLog"
	! !

!MarsRover2Test methodsFor: 'tests' stamp: 'jcm 11/13/2024 12:07:56'!
test02MarsRoverRememberInstructionLogsOnlyPosition

	| marsRover expectedPositions log |
	
	marsRover := MarsRover at: 0@1 heading: MarsRoverHeadingEast.
		log := Log new.
	
	marsRover attachPosition: log.

	marsRover  process: 'flbr'.
	expectedPositions := OrderedCollection new.
	expectedPositions add: 1@1.
	expectedPositions add: 1@0.
	
	self assert: (log has: expectedPositions).

	! !

!MarsRover2Test methodsFor: 'tests' stamp: 'jcm 11/13/2024 12:07:23'!
test03MarsRoverWithoutInstructionsBeginsWithEmptyLogTrackingHeadings

	| marsRover log |
	
	marsRover := MarsRover at: 0@1 heading: MarsRoverHeadingNorth.
	log := Log new.
	
	marsRover attachHeading: log.
	
	self assert: log isEmpty.
	
	"Tendria que hacer este test?"
	"self assert: marsRover knowsOneEmptyLog"

	! !

!MarsRover2Test methodsFor: 'tests' stamp: 'jcm 11/13/2024 12:07:23'!
test04MarsRoverRememberInstructionLogsOnlyHeading

	| marsRover expectedHeadings log |
	"Aca me doy cuenta de la constante repeticion y aplicaria el refactor en este test" 
	
	marsRover := MarsRover at: 0@1 heading: MarsRoverHeadingEast.
	log := Log new.
	
	marsRover attachHeading: log.
	
	marsRover  process: 'flbr'.
	expectedHeadings := OrderedCollection new.
	expectedHeadings add: MarsRoverHeadingNorth new .
	expectedHeadings add: MarsRoverHeadingEast new .
	
	self assert: (log hasEqualHeadings: expectedHeadings).

	! !

!MarsRover2Test methodsFor: 'tests' stamp: 'jcm 11/13/2024 12:10:10'!
test05MarsRoverWithoutInstructionBeginsWithEmptyWindow


	"Aca me doy cuenta de la constante repeticion y aplicaria el refactor en el test anterior" 

	| marsRover window |
	
	marsRover := MarsRover at: 0@1 heading: MarsRoverHeadingNorth.
	
	window := Window new.
	
	marsRover attachWindow: window.
	
	self assert: window isEmpty.! !

!MarsRover2Test methodsFor: 'tests' stamp: 'jcm 11/14/2024 17:33:33'!
test06MarsRoverRememberInstructionWithWindowObservingPositionAndHeading

	| marsRover expectedPositionAndHeading window |
	"Aca me doy cuenta de la constante repeticion y aplicaria el refactor en este test" 
	
	marsRover := MarsRover at: 0@1 heading: MarsRoverHeadingEast.
	window := Window new.
	
	marsRover attachPosition: window.
	marsRover attachHeading: window.
	
	marsRover  process: 'flbr'.
	expectedPositionAndHeading := Dictionary new.

	expectedPositionAndHeading at:'Position' put: 1@0.
	expectedPositionAndHeading at:'Heading' put: MarsRoverHeadingEast .

	self assert: (window hasEqualPositionAndHeadings: expectedPositionAndHeading).

	! !

!MarsRover2Test methodsFor: 'tests' stamp: 'jcm 11/14/2024 17:35:49'!
test07MarsRoverRememberInstructionWithWindowObservingOnlyPosition

	| marsRover window |
	"Aca me doy cuenta de la constante repeticion y aplicaria el refactor en este test" 
	
	marsRover := MarsRover at: 0@1 heading: MarsRoverHeadingEast.
	window := Window new.
	
	marsRover attachPosition: window.
	
	marsRover  process: 'flbr'.

	self assert: (window hasEqualPosition: 1@0).

	! !

!MarsRover2Test methodsFor: 'tests' stamp: 'jcm 11/14/2024 17:37:06'!
test08MarsRoverRememberInstructionWithWindowObservingOnlyHeading

	| marsRover window |
	"Aca me doy cuenta de la constante repeticion y aplicaria el refactor en este test" 
	
	marsRover := MarsRover at: 0@1 heading: MarsRoverHeadingEast.
	window := Window new.
	
	marsRover attachHeading: window.
	
	marsRover  process: 'flbr'.

	self assert: (window hasEqualHeading: MarsRoverHeadingEast).

	! !

!MarsRover2Test methodsFor: 'tests' stamp: 'jcm 11/14/2024 17:47:25'!
test09MarsRoverRememberInstructionWithMoreThanOneObserver

	| marsRover window log expectedLog |
	"Aca me doy cuenta de la constante repeticion y aplicaria el refactor en este test" 
	
	marsRover := MarsRover at: 0@1 heading: MarsRoverHeadingEast.
	window := Window new.
	log := Log new.
	
	marsRover attachHeading: window.
	marsRover attachPosition: log.
	
	marsRover  process: 'flbr'.
	
	expectedLog := OrderedCollection new.
	
	expectedLog add: 1@1.
	expectedLog add: 1@0.

	self assert: (log has: expectedLog).
	self assert: (window hasEqualHeading: MarsRoverHeadingEast)
	! !

!MarsRover2Test methodsFor: 'tests' stamp: 'jcm 11/14/2024 17:49:39'!
test10MarsRoverRememberInstructionWithMoreThanOneObserver

	| marsRover window log expectedLog |
	"Aca me doy cuenta de la constante repeticion y aplicaria el refactor en este test" 
	
	marsRover := MarsRover at: 0@1 heading: MarsRoverHeadingEast.
	window := Window new.
	log := Log new.
	
	marsRover attachHeading: window.
	marsRover attachPosition: log.
	
	marsRover  process: 'flbr'.
	
	expectedLog := OrderedCollection new.
	
	expectedLog add: 1@1.
	expectedLog add: 1@0.

	self assert: (log has: expectedLog).
	self assert: (window hasEqualHeading: MarsRoverHeadingEast)
	! !

!MarsRover2Test methodsFor: 'tests' stamp: 'jcm 11/14/2024 18:01:09'!
test11MarsRoverRememberInstructionsObservingHeadingAndPosition

	| marsRover log expectedLogHeading expectedLogPositions |
	"Aca me doy cuenta de la constante repeticion y aplicaria el refactor en este test" 
	
	marsRover := MarsRover at: 0@1 heading: MarsRoverHeadingEast.
	log := Log new.
	
	marsRover attachPosition: log.
	marsRover attachHeading: log.
	
	marsRover  process: 'flbr'.
	
	expectedLogHeading := OrderedCollection new.	
	expectedLogPositions := OrderedCollection new.
	
	expectedLogPositions add: 1@1.
	expectedLogHeading add: MarsRoverHeadingNorth new .
	expectedLogPositions add: 1@0.
	expectedLogHeading add: MarsRoverHeadingEast new .

	self assert: (log hasEqualPositions: expectedLogPositions AndHeadings: expectedLogHeading).
	
	! !


!classDefinition: #MarsRoverTest category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'jcm 11/12/2024 19:58:26'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #Log category: #'MarsRover-WithHeading'!
Object subclass: #Log
	instanceVariableNames: 'headings positions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'notify' stamp: 'jcm 11/14/2024 17:55:08'!
notifyChangeInHeading: aNewHead


	headings add: aNewHead.! !

!Log methodsFor: 'notify' stamp: 'jcm 11/14/2024 17:55:03'!
notifyChangeInPosition: aNewPosition


	positions add: aNewPosition.! !


!Log methodsFor: 'testing' stamp: 'jcm 11/14/2024 17:56:24'!
has: expectedPositions

	^positions = expectedPositions ! !

!Log methodsFor: 'testing' stamp: 'jcm 11/14/2024 17:55:55'!
hasEqualHeadings: expectedHeadings
	
	"Chequeo a mano si tienen el mismo tipo"
	| index |
	index := 0.
	^headings allSatisfy: [:log | index := index + 1.
		log isKindOf: ((expectedHeadings at: index) class)]
	! !

!Log methodsFor: 'testing' stamp: 'jcm 11/14/2024 18:02:47'!
hasEqualPositions: expectedPositions AndHeadings: expectedHeadings
	
	"Chequeo a mano si tienen el mismo tipo"
	| index |
	index := 0.

	^(self hasEqualHeadings: expectedHeadings)
	& self has: expectedPositions
	! !

!Log methodsFor: 'testing' stamp: 'jcm 11/14/2024 17:56:16'!
isEmpty

	^positions isEmpty & headings isEmpty ! !


!Log methodsFor: 'instance creation' stamp: 'jcm 11/14/2024 17:55:27'!
initialize

	
	positions := OrderedCollection new.
	headings  := OrderedCollection new.! !


!classDefinition: #MarsRover category: #'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head ObserversPosition window ObserversHeadingTo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'jcm 11/13/2024 12:08:44'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	ObserversPosition := OrderedCollection new.
	
	ObserversHeadingTo := OrderedCollection new.
	
	
	
	! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:02'!
headEast
	
	head := MarsRoverHeadingEast for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'jcm 11/13/2024 12:08:39'!
rotateLeft
	
	head rotateLeft.
	"Ahora tengo dos listas con los logs correspondientes, ahora segun la instruccion los voy a actualizar o no"
	
	
	ObserversHeadingTo do:[:aLog | aLog notifyChangeInHeading: head]
	! !

!MarsRover methodsFor: 'heading' stamp: 'jcm 11/13/2024 12:08:39'!
rotateRight
	
	head rotateRight.
	"Ahora tengo dos listas con los logs correspondientes, ahora segun la instruccion los voy a actualizar o no"
	
	
	ObserversHeadingTo do:[:aLog | aLog notifyChangeInHeading: head]
	! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !

!MarsRover methodsFor: 'testing' stamp: 'jcm 11/12/2024 20:58:09'!
windowShowsPosition: aPosition facing: aCardinalPoint

	^ window ! !


!MarsRover methodsFor: 'moving' stamp: 'jcm 11/13/2024 12:08:33'!
moveBackward
	
	head moveBackward.
	"Ahora tengo dos listas con los logs correspondientes, ahora segun la instruccion los voy a actualizar o no"
	
	
	ObserversPosition do:[:aLog | aLog notifyChangeInPosition: position]

	! !

!MarsRover methodsFor: 'moving' stamp: 'jcm 11/12/2024 20:17:17'!
moveEast
	
	position := position + (1@0).
	
	! !

!MarsRover methodsFor: 'moving' stamp: 'jcm 11/13/2024 12:08:33'!
moveForward
	
	head moveForward.
	"Ahora tengo dos listas con los logs correspondientes, ahora segun la instruccion los voy a actualizar o no"
	
	
	ObserversPosition do:[:aLog | aLog notifyChangeInPosition: position]
! !

!MarsRover methodsFor: 'moving' stamp: 'jcm 11/12/2024 20:16:44'!
moveNorth
	
	position := position + (0@1).
	
	! !

!MarsRover methodsFor: 'moving' stamp: 'jcm 11/12/2024 20:16:41'!
moveSouth
	
	position := position + (0@-1).
	
	! !

!MarsRover methodsFor: 'moving' stamp: 'jcm 11/12/2024 20:16:38'!
moveWest
	
	position := position + (-1@0).
	
	! !


!MarsRover methodsFor: 'attachLog' stamp: 'jcm 11/13/2024 12:08:39'!
attachHeading: aLog


	ObserversHeadingTo add: aLog.
! !

!MarsRover methodsFor: 'attachLog' stamp: 'jcm 11/13/2024 12:08:33'!
attachPosition: aLog


	ObserversPosition add: aLog.
! !

!MarsRover methodsFor: 'attachLog' stamp: 'jcm 11/13/2024 12:13:22'!
attachWindow: aWindow 
	
	
	ObserversPosition add: aWindow.
	ObserversHeadingTo add: aWindow.! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: #'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #Window category: #'MarsRover-WithHeading'!
Object subclass: #Window
	instanceVariableNames: 'data'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Window methodsFor: 'testing' stamp: 'jcm 11/14/2024 17:37:38'!
hasEqualHeading: expectedHeading
	
	
	^((data at: 'Heading') class) = expectedHeading! !

!Window methodsFor: 'testing' stamp: 'jcm 11/14/2024 17:35:08'!
hasEqualPosition: expectedPosition
	
	
	^(data at: 'Position') = expectedPosition ! !

!Window methodsFor: 'testing' stamp: 'jcm 11/13/2024 12:29:05'!
hasEqualPositionAndHeadings: expectedPositionAndHeading 
	
	
	^(data at: 'Position') = (expectedPositionAndHeading at: 'Position') &
	((data at: 'Heading') class) = ((expectedPositionAndHeading at: 'Heading'))! !

!Window methodsFor: 'testing' stamp: 'jcm 11/13/2024 12:14:19'!
isEmpty

	^data isEmpty! !


!Window methodsFor: 'instance creation' stamp: 'jcm 11/13/2024 12:20:01'!
initialize

	"La idea es que sea como un struct donde en la primera componente tiene la posicion y en la segunda tiene el heading"
	data := Dictionary new.! !


!Window methodsFor: 'notify' stamp: 'jcm 11/13/2024 12:20:34'!
notifyChangeInHeading: aNewHead

	data at: 'Heading' put: aNewHead.! !

!Window methodsFor: 'notify' stamp: 'jcm 11/13/2024 12:21:42'!
notifyChangeInPosition: aNewPosition

	data at: 'Position' put: aNewPosition! !
