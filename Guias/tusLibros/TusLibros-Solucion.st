!classDefinition: #CartTests category: #'TusLibros-Solucion'!
TestCase subclass: #CartTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CartTests methodsFor: 'tests' stamp: 'jcm 11/4/2024 09:32:18'!
test01CartIsCreatedEmpty

	
	| cart |
	
	cart := Cart create.
	
	self assert: cart isEmpty.
	! !

!CartTests methodsFor: 'tests' stamp: 'jcm 11/4/2024 09:51:27'!
test02GivenAnEmptyCartWhenOneBookIsAddedThenTheresOneBookInTheCart

	"Nombre creado con la metodologia:
	Given[setup] when [exercise] then [verification]"

	
	| cart book1 |
	
	cart := Cart create.
	book1 := Book new.
	
	cart addToCart: 1 of: book1.
	
	self assert: cart size equals: 1.
	self assert: cart includes: book1
	! !

!CartTests methodsFor: 'tests' stamp: 'jcm 11/4/2024 10:00:30'!
test03GivenAnEmptyCartWhenNBookAreAddedThenThereAreNBooksInTheCart

	"Nombre creado con la metodologia:
	Given[setup] when [exercise] then [verification]"

	"Refactor posible seria usar un diccionario pero no entiendo como agregar un elemento"
	
	| cart book1 |
	
	cart := Cart create.
	book1 := Book new.
	
	cart addToCart: 3 of: book1.
	
	self assert: cart size equals: 3.
	self assert: cart includes: book1.
	! !

!CartTests methodsFor: 'tests' stamp: 'jcm 11/4/2024 10:09:58'!
test04ItCannotBeAddedLessThanOneBookToACart

	"Nombre creado con la metodologia:
	Given[setup] when [exercise] then [verification]"

	"Refactor posible seria usar un diccionario pero no entiendo como agregar un elemento"
	
	| cart book1 |
	
	cart := Cart create.
	book1 := Book new.
	
	self should: [cart addToCart: 0 of: book1 ] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | self assert: error messageText equals: (Cart cannotBeAddedLessThanOneBookToACart)]
! !


!classDefinition: #Book category: #'TusLibros-Solucion'!
Object subclass: #Book
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!


!classDefinition: #Cart category: #'TusLibros-Solucion'!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!Cart methodsFor: 'instance creation' stamp: 'jcm 11/4/2024 09:27:25'!
initializeCart
	
	
	
	 books := OrderedCollection new.! !


!Cart methodsFor: 'tests' stamp: 'jcm 11/4/2024 09:38:42'!
includes: aBook 
	
	
	^books includes: aBook! !

!Cart methodsFor: 'tests' stamp: 'jcm 11/4/2024 09:31:47'!
isEmpty
	
	
	^books isEmpty ! !

!Cart methodsFor: 'tests' stamp: 'jcm 11/4/2024 09:38:00'!
size

	^books size! !


!Cart methodsFor: 'add' stamp: 'jcm 11/4/2024 10:09:27'!
addToCart: anAmountOfBooks of: aBook
	
	self class assertThatTheAmountOfBooksIsMoreThan0: anAmountOfBooks .
	 anAmountOfBooks timesRepeat: [books add: aBook]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Solucion'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'assert' stamp: 'jcm 11/4/2024 10:11:11'!
assertThatTheAmountOfBooksIsMoreThan0: anAmountOfBooks

	anAmountOfBooks > 0 ifFalse:[self error: self cannotBeAddedLessThanOneBookToACart ]

	! !


!Cart class methodsFor: 'error' stamp: 'jcm 11/4/2024 10:09:06'!
cannotBeAddedLessThanOneBookToACart

	^'Cannot be added less than one book to a cart'! !


!Cart class methodsFor: 'instance creation' stamp: 'jcm 11/4/2024 09:26:29'!
create
	
	^self new initializeCart! !
