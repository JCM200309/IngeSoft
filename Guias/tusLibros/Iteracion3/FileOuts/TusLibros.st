!classDefinition: #CartInterfaceTest category: #TusLibros!
TestCase subclass: #CartInterfaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartInterfaceTest methodsFor: 'setup' stamp: 'jcm 11/8/2024 20:44:13'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!CartInterfaceTest methodsFor: 'tests' stamp: 'jcm 11/9/2024 16:06:15'!
test01UserWithInvalidCredentialsCannotCreateACart

	| clientAutenticator clientId password cartInterface |
	
	clientId := testObjectsFactory invalidUserId .
	password := testObjectsFactory invalidUserPassword .
	
	clientAutenticator := testObjectsFactory createClientAutenticator .
	
	cartInterface := CartInterface new.
	
	self 
		should: [ cartInterface createCartTo: clientId with: password throught: clientAutenticator]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = ClientAutenticator invalidAutenticationErrorMensage ]
	! !

!CartInterfaceTest methodsFor: 'tests' stamp: 'jcm 11/9/2024 16:06:32'!
test02UserWithValidCredentialsCanCreateAnEmptyCart

	| clientAutenticator clientId password cartInterface cartId |
	
	clientId := testObjectsFactory validUserId .
	password := testObjectsFactory validUserPassword .
	
	clientAutenticator := testObjectsFactory createClientAutenticator.
	
	cartInterface := CartInterface with: testObjectsFactory .
	
	cartId := cartInterface createCartTo: clientId with: password  throught: clientAutenticator.
	
	self assert: (cartInterface listCart: cartId) equals: ''. 
	! !

!CartInterfaceTest methodsFor: 'tests' stamp: 'jcm 11/9/2024 16:04:11'!
test03ItCannotBeAddedToAnUnknownCart


	| clientAutenticator clientId password cartInterface unknownCartId |
	
	clientId := testObjectsFactory validUserId .
	password := testObjectsFactory validUserPassword .
	
	clientAutenticator := testObjectsFactory createClientAutenticator.
	
	cartInterface := CartInterface with: testObjectsFactory .
	
	cartInterface createCartTo: clientId with: password  throught: clientAutenticator.
	unknownCartId := cartInterface createCartId.
	
	self 
		should: [ cartInterface add: 3 Of: testObjectsFactory itemSellByTheStore To: unknownCartId  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CartInterface unknownCartId ]
	
	! !

!CartInterfaceTest methodsFor: 'tests' stamp: 'jcm 11/9/2024 16:07:36'!
test04aKnownCartRemebersItsItemsAndQuantities

	

	| clientAutenticator clientId password cartInterface cartId |
	
	clientId := testObjectsFactory validUserId .
	password := testObjectsFactory validUserPassword .
	
	clientAutenticator := testObjectsFactory createClientAutenticator.
	
	cartInterface := CartInterface with: testObjectsFactory .
	
	cartId := cartInterface createCartTo: clientId with: password  throught: clientAutenticator.
	
	cartInterface add: 2 Of: testObjectsFactory itemSellByTheStore To: cartId.
	
	
	"self assert: (cartInterface includes: 2 Of: testObjectsFactory itemSellByTheStore On: cartId)."
	
	self assert: (cartInterface listCart: cartId) equals: (testObjectsFactory itemSellByTheStore , '|2')! !

!CartInterfaceTest methodsFor: 'tests' stamp: 'jcm 11/9/2024 16:10:21'!
test05anUnknownCartCannotBeListedAndTheOtherCartsRemainsTheSame


	| clientAutenticator clientId password cartInterface unknownCartId knownCartId |
	
	clientId := testObjectsFactory validUserId .
	password := testObjectsFactory validUserPassword .
	
	clientAutenticator := testObjectsFactory createClientAutenticator.
	
	cartInterface := CartInterface with: testObjectsFactory .
	
	knownCartId := cartInterface createCartTo: clientId with: password  throught: clientAutenticator.
	unknownCartId := cartInterface createCartId.
	
	self 
		should: [ cartInterface listCart: unknownCartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CartInterface unknownCartId.
			self assert: (cartInterface listCart: knownCartId) equals: '']

	! !

!CartInterfaceTest methodsFor: 'tests' stamp: 'jcm 11/9/2024 17:38:55'!
test06aKnownCartCanBeCheckedOut


	| clientAutenticator clientId password cartInterface cartId cart cashier salesBook |
	
	clientId := testObjectsFactory validUserId .
	password := testObjectsFactory validUserPassword .
	
	clientAutenticator := testObjectsFactory createClientAutenticator.
	
	cartInterface := CartInterface with: testObjectsFactory .
	
	cartId := cartInterface createCartTo: clientId with: password  throught: clientAutenticator.
	
	cart := cartInterface cartFor: cartId.
	
	cartInterface add: 2 Of: testObjectsFactory itemSellByTheStore To: cartId.
	
	salesBook := OrderedCollection new.
	
	
	cashier := Cashier 
		toCheckout: cart
		charging:  testObjectsFactory notExpiredCreditCard
		throught: (MerchantProcesor with: testObjectsFactory defaultDebitBehavior)
		on:  testObjectsFactory today
		registeringOn: salesBook.
	
	
	"Tendria que hacer el checkOutCart para que le mande a la interfaz y esta cree el cashier y forwardee a cart para que pueda hacer el checkout"
	! !


!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'jcm 11/9/2024 15:20:27'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setup' stamp: 'jcm 11/9/2024 16:33:01'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!CashierTest methodsFor: 'tests' stamp: 'jcm 11/9/2024 16:49:05'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: (MerchantProcesor with: testObjectsFactory defaultDebitBehavior)
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/9/2024 16:42:00'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: (MerchantProcesor with: testObjectsFactory defaultDebitBehavior)
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut equals: (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/9/2024 16:53:16'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: (MerchantProcesor with: testObjectsFactory defaultDebitBehavior)
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/9/2024 16:53:31'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: (MerchantProcesor with: testObjectsFactory defaultDebitBehavior)
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/9/2024 16:56:33'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: (MerchantProcesor with:  [ :anAmount :aCreditCard | debitedAmout := anAmount.debitedCreditCard := aCreditCard ])
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HAW 11/8/2024 13:46:36'!
test05WithMock_CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard merchantProcessor mpReceivedMessages debitFromMessage |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
	merchantProcessor := Mock onlyCollecting.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: merchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
	mpReceivedMessages := merchantProcessor receivedMessages.
					
	self assert: 1 equals: mpReceivedMessages size.
	debitFromMessage := mpReceivedMessages first.
	self assert: debitFromMessage selector equals: #debit:from:.
	self assert: debitFromMessage arguments first equals: total.
	self assert: debitFromMessage arguments second equals: creditCard 
	! !

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/9/2024 16:57:18'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: (MerchantProcesor with: [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage])
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HAW 11/8/2024 13:38:36'!
test06WithMock_CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard merchantProcessor |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	merchantProcessor := Mock whenReceives: #debit:from: do: [ :amount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage ].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: merchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'total' stamp: 'jcm 11/9/2024 16:47:28'!
total
	| total |
	total := 0.
	items keysAndValuesDo: [ :anItem :aQuantity | total := total + ((catalog at: anItem) * aQuantity)].
	
	^total! !


!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'jcm 11/9/2024 15:19:24'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items at: anItem put: aQuantity.! !


!Cart methodsFor: 'testing' stamp: 'jcm 11/9/2024 15:20:36'!
includes: anItem

	^items includesKey: anItem ! !

!Cart methodsFor: 'testing' stamp: 'jcm 11/9/2024 15:27:59'!
includes: anQuantityOfAnItem Of: anItem

	(items includesKey: anItem) ifTrue:[^(items at: anItem) = anQuantityOfAnItem].
	^false
	! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'queries' stamp: 'jcm 11/9/2024 15:20:59'!
occurrencesOf: anItem

	^items at: anItem  ! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'items' stamp: 'jcm 11/9/2024 15:49:37'!
itemsAsString

	| string |
	
	string := ''.
	
	items keysDo: [:keys | string := string , keys ].
	
	^string
	! !

!Cart methodsFor: 'items' stamp: 'jcm 11/9/2024 15:53:52'!
listItems

	| string |
	
	string := ''.
	
	items keysAndValuesDo: [:key :value | string := string , key , '|' , (value asString)].
	
	^string
	! !


!Cart methodsFor: 'initialization' stamp: 'jcm 11/9/2024 15:18:57'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartInterface category: #TusLibros!
Object subclass: #CartInterface
	instanceVariableNames: 'cartId carts objectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartInterface methodsFor: 'createCart' stamp: 'jcm 11/9/2024 14:13:18'!
createCartId

	cartId := cartId  + 1.
	
	^cartId  - 1! !

!CartInterface methodsFor: 'createCart' stamp: 'jcm 11/9/2024 14:24:48'!
createCartTo: clientId with: password throught: clientAutenticator 
	
	
	| currentCartId |
	clientAutenticator assertValidClientId: clientId and: password.
	
	"Aca pense en crear un servicio aparte que me de el id del carrito pero me parecio mucho"
	
	currentCartId := self createCartId.
	carts add: objectsFactory createCart.
	
	^currentCartId 
	
	
	! !


!CartInterface methodsFor: 'listCart' stamp: 'jcm 11/9/2024 15:51:58'!
listCart: aCartId
	| cart |
	
	self assertValidCartId: aCartId.
	 
	cart := carts at: aCartId.
	
	
	^cart listItems.
	! !


!CartInterface methodsFor: 'assert' stamp: 'jcm 11/9/2024 14:39:34'!
assertValidCartId: aCartId.

	carts size < aCartId ifTrue:[self error: self class unknownCartId]! !


!CartInterface methodsFor: 'instance creation' stamp: 'jcm 11/9/2024 14:24:10'!
initializeWith: anObjectsFactory 
	
	objectsFactory := anObjectsFactory.
	cartId := 1.
	carts := OrderedCollection new.! !


!CartInterface methodsFor: 'cart' stamp: 'jcm 11/9/2024 16:05:03'!
add: anAmountOfItems Of: aTypeOfItem To: aCartId 

	| cart |
	
	self assertValidCartId: aCartId.
	
	cart := carts at: aCartId.
	
	cart add: anAmountOfItems of: aTypeOfItem.
	
	^'0|OK'
	! !

!CartInterface methodsFor: 'cart' stamp: 'jcm 11/9/2024 17:21:17'!
cartFor: aCartId

	^carts at: aCartId ! !

!CartInterface methodsFor: 'cart' stamp: 'jcm 11/9/2024 15:15:31'!
includes: anQuantityOfAnItem Of: anItem On: aCartId


	| cart |
	cart := carts at: aCartId.
	
	^cart includes: anQuantityOfAnItem Of: anItem.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartInterface class' category: #TusLibros!
CartInterface class
	instanceVariableNames: ''!

!CartInterface class methodsFor: 'error mensages' stamp: 'jcm 11/9/2024 14:40:37'!
unknownCartId

	^'unknown cart id'! !


!CartInterface class methodsFor: 'instance creation' stamp: 'jcm 11/9/2024 14:23:44'!
with: anObjectsFactory

	^self new initializeWith: anObjectsFactory ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #ClientAutenticator category: #TusLibros!
Object subclass: #ClientAutenticator
	instanceVariableNames: 'validCredentialsCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClientAutenticator methodsFor: 'autenticate' stamp: 'jcm 11/9/2024 14:11:44'!
autenticateFor: clientId and: password 
	"Aca habria que hacer que el client autenticator tenga un registro de los validos y que si no es valido devuelva false"
	(validCredentialsCatalog includesKey: clientId) ifTrue:[((validCredentialsCatalog at:clientId) = password) ifTrue:[^true]].
	
	^false! !


!ClientAutenticator methodsFor: 'assert' stamp: 'jcm 11/8/2024 20:38:13'!
assertValidClientId: clientId and: password 
	
	"no me gusta como esta esto"
	
	(self autenticateFor: clientId and: password) ifFalse:[self error: self class invalidAutenticationErrorMensage]! !


!ClientAutenticator methodsFor: 'instance creation' stamp: 'jcm 11/9/2024 14:06:47'!
initializeWith: aValidCredentialsCatalog 
	
	validCredentialsCatalog := aValidCredentialsCatalog.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClientAutenticator class' category: #TusLibros!
ClientAutenticator class
	instanceVariableNames: ''!

!ClientAutenticator class methodsFor: 'errors' stamp: 'jcm 11/8/2024 20:38:13'!
invalidAutenticationErrorMensage

	^'1|Wrong clientId or password'! !


!ClientAutenticator class methodsFor: 'instance creation' stamp: 'jcm 11/9/2024 14:06:31'!
with: aValidCredentialsCatalog
	
	^self new initializeWith: aValidCredentialsCatalog ! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #MerchantProcesor category: #TusLibros!
Object subclass: #MerchantProcesor
	instanceVariableNames: 'debitBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcesor methodsFor: 'instance creation' stamp: 'jcm 11/9/2024 16:35:11'!
initializeWith: aDebitBehaviour 
	
	debitBehaviour := aDebitBehaviour.! !


!MerchantProcesor methodsFor: 'debit' stamp: 'jcm 11/9/2024 16:40:34'!
debit: anAmount from: aCreditCard 

	^debitBehaviour value: anAmount value: aCreditCard ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcesor class' category: #TusLibros!
MerchantProcesor class
	instanceVariableNames: ''!

!MerchantProcesor class methodsFor: 'instance creation' stamp: 'jcm 11/9/2024 16:34:58'!
with: aDebitBehaviour

	^self new initializeWith: aDebitBehaviour ! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today cartId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'jcm 11/8/2024 20:49:30'!
createCartId
	
	cartId := cartId + 1.
	^cartId - 1! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'jcm 11/8/2024 20:49:44'!
initialize

	today := DateAndTime now.
	cartId := 0.! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !



!StoreTestObjectsFactory methodsFor: 'clientAutenticator' stamp: 'jcm 11/9/2024 14:05:54'!
createClientAutenticator

	^ClientAutenticator with: self validUsersCredentials! !

!StoreTestObjectsFactory methodsFor: 'clientAutenticator' stamp: 'jcm 11/8/2024 20:42:10'!
invalidUserId

	^12345

	! !

!StoreTestObjectsFactory methodsFor: 'clientAutenticator' stamp: 'jcm 11/8/2024 20:42:29'!
invalidUserPassword

	^56789

	! !

!StoreTestObjectsFactory methodsFor: 'clientAutenticator' stamp: 'jcm 11/9/2024 14:03:57'!
invalidUsersCredentials

	^ Dictionary new
		at: self invalidUserId put: self invalidUserPassword;
		yourself 
	! !

!StoreTestObjectsFactory methodsFor: 'clientAutenticator' stamp: 'jcm 11/8/2024 20:55:36'!
validUserId

	^123456

	! !

!StoreTestObjectsFactory methodsFor: 'clientAutenticator' stamp: 'jcm 11/8/2024 20:56:07'!
validUserPassword

	^123456

	! !

!StoreTestObjectsFactory methodsFor: 'clientAutenticator' stamp: 'jcm 11/9/2024 14:04:11'!
validUsersCredentials

	^ Dictionary new
		at: self validUserId put: self validUserPassword;
		yourself 
	! !


!StoreTestObjectsFactory methodsFor: 'merchant procesor' stamp: 'jcm 11/9/2024 16:33:43'!
defaultDebitBehavior

	 ^ [ :anAmount :aCreditCard | ]! !


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!classDefinition: #Mock category: #TusLibros!
ProtoObject subclass: #Mock
	instanceVariableNames: 'receivedMessages blockBySelectors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Mock methodsFor: 'system primitives' stamp: 'HAW 11/8/2024 13:37:50'!
doesNotUnderstand: aMessage

	receivedMessages add: aMessage.
	
	^blockBySelectors 
		at: aMessage selector 
		ifPresent: [ :aBlock | aBlock valueWithArguments: aMessage arguments ]
		ifAbsent: [ self ]! !

!Mock methodsFor: 'system primitives' stamp: 'HAW 11/8/2024 13:32:55'!
inspectorClass
	"Answer the class of the inspector to be used on the receiver.  Called by inspect; 
	use basicInspect to get a normal (less useful) type of inspector."

	^ Inspector! !

!Mock methodsFor: 'system primitives' stamp: 'HAW 11/8/2024 13:33:06'!
instVarAt: index put: anObject
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	Object primitiveFailed! !


!Mock methodsFor: 'initialization' stamp: 'HAW 11/8/2024 13:36:36'!
initializeDoingAll: aBlocksBySelectors 

	blockBySelectors := aBlocksBySelectors.
	receivedMessages := OrderedCollection new! !


!Mock methodsFor: 'received messages' stamp: 'HAW 11/8/2024 13:46:46'!
receivedMessages

	^receivedMessages copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Mock class' category: #TusLibros!
Mock class
	instanceVariableNames: ''!

!Mock class methodsFor: 'instance creation' stamp: 'HAW 11/8/2024 13:36:04'!
doingAll: aBlocksBySelectors

	^self new initializeDoingAll: aBlocksBySelectors ! !

!Mock class methodsFor: 'instance creation' stamp: 'HAW 11/8/2024 13:46:25'!
onlyCollecting

	^self doingAll: Dictionary new! !

!Mock class methodsFor: 'instance creation' stamp: 'HAW 11/8/2024 13:35:40'!
whenReceives: aSelector do: aBlock

	^self doingAll: (Dictionary new
		at: aSelector put: aBlock;
		yourself)! !
