!classDefinition: #Tests category: #TusLibros!
TestCase subclass: #Tests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Tests methodsFor: 'support' stamp: 'jcm 11/5/2024 21:28:24'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalogWithPrices! !

!Tests methodsFor: 'support' stamp: 'jcm 11/5/2024 21:28:30'!
defaultCatalogWithPrices
	
	| priceList |
	
	priceList := Dictionary newFromPairs: {'validBook' . 5*peso. 'validBook2' .7*peso}.
	
	
	^priceList! !

!Tests methodsFor: 'support' stamp: 'jcm 11/5/2024 21:15:17'!
defaultPriceList
	
	| priceList |
	
	priceList := Dictionary newFromPairs: {'validBook' . 5*peso. 'validBook2' .7*peso}.
	
	
	^priceList! !

!Tests methodsFor: 'support' stamp: 'jcm 11/5/2024 20:19:04'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!Tests methodsFor: 'support' stamp: 'jcm 11/5/2024 20:19:02'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CartTest category: #TusLibros!
Tests subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:35'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSellByTheStore withOcurrences: 0  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:46'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add:  self itemNotSellByTheStore withOcurrences: 2  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:59'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !



!classDefinition: #CashierTest category: #TusLibros!
Tests subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/5/2024 20:27:18'!
test01ACashierCannotMakeACheckoutToAnEmptyCart

	| cart cashier |
	
	cashier := Cashier new.
	cart := self createCart.
	
	self should: [cashier checkout: cart] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assert: error messageText equals: Cashier cannotMakeACheckoutWithAnEmptyCart.
		self assert: cart isEmpty]! !

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/5/2024 21:09:27'!
test02AValidCheckoutMadeToACartWithOneItemReturnsTheItemsPrice

	| cart cashier priceList |
	
	priceList := self defaultPriceList .
	cashier := Cashier with: priceList.
	cart := self createCart.
	cart add: 'validBook'.

	
	self assert: (cashier checkout: cart) equals: 5*peso.
	! !

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/5/2024 21:20:29'!
test03AValidCheckoutMadeToACartWithMoreThanOneItemReturnsTheItemsPrice

	| cart cashier priceList |
	
	priceList := self defaultPriceList .
	cashier := Cashier with: priceList.
	cart := self createCart.
	cart add: 'validBook'.
	cart add: 'validBook2'.

	
	self assert: (cashier checkout: cart) equals: 12*peso.
	! !

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/5/2024 21:23:59'!
test04AValidCheckoutMadeWithAnExpiredCreditCart

	| cart cashier priceList |
	
	priceList := self defaultPriceList .
	cashier := Cashier with: priceList.
	cart := self createCart.
	cart add: 'validBook'.
	cart add: 'validBook2'.

	
	self assert: (cashier checkout: cart) equals: 12*peso.
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'jcm 11/5/2024 21:35:17'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'jcm 11/5/2024 21:33:16'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'jcm 11/5/2024 21:20:17'!
totalWith: itemsPrices

	^items sum:[:item | itemsPrices at: item]! !


!Cart methodsFor: 'adding' stamp: 'jcm 11/5/2024 21:33:31'!
add: anItem

	^ self add: anItem withOcurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:19'!
add: anItem withOcurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'itemsPrices priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'assertions' stamp: 'jcm 11/5/2024 20:25:09'!
assertCartIsNotEmpty: aCart

	aCart isEmpty ifTrue:[self error: self class cannotMakeACheckoutWithAnEmptyCart]! !


!Cashier methodsFor: 'initialize' stamp: 'jcm 11/5/2024 21:00:36'!
initializeWith: aPriceList


	priceList := aPriceList.! !


!Cashier methodsFor: 'checkout' stamp: 'jcm 11/5/2024 21:07:57'!
checkout: aCart


	self assertCartIsNotEmpty: aCart.
	
	^aCart totalWith: priceList 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'jcm 11/5/2024 20:26:09'!
cannotMakeACheckoutWithAnEmptyCart

	'A checkout cannot be made to an empty cart'! !


!Cashier class methodsFor: 'instance creation' stamp: 'jcm 11/5/2024 21:01:07'!
with: aPriceList 

	^self new initializeWith: aPriceList 
! !
