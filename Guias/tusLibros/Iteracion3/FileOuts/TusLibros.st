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

!CartInterfaceTest methodsFor: 'tests' stamp: 'jcm 11/12/2024 12:29:39'!
test02UserWithValidCredentialsCanCreateAnEmptyCart

	| clientAutenticator clientId password cartInterface cartId |
	
	clientId := testObjectsFactory validUserId .
	password := testObjectsFactory validUserPassword .
	
	clientAutenticator := testObjectsFactory createClientAutenticator.
	
	cartInterface := CartInterface with: testObjectsFactory .
	
	cartId := cartInterface createCartTo: clientId with: password  throught: clientAutenticator.
	
	self assert: (cartInterface listCart: cartId) isEmpty. 
	! !

!CartInterfaceTest methodsFor: 'tests' stamp: 'jcm 11/12/2024 12:33:33'!
test03ItCannotBeAddedToAnUnknownCart


	| clientAutenticator clientId password cartInterface unknownCartId previousNumberOfCarts |
	
	clientId := testObjectsFactory validUserId .
	password := testObjectsFactory validUserPassword .
	
	clientAutenticator := testObjectsFactory createClientAutenticator.
	
	cartInterface := CartInterface with: testObjectsFactory .

	cartInterface createCartTo: clientId with: password  throught: clientAutenticator.
	
	previousNumberOfCarts := cartInterface numberOfCarts.
	
	unknownCartId := cartInterface createCartId.
	
	self 
		should: [ cartInterface add: 3 Of: testObjectsFactory itemSellByTheStore To: unknownCartId  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CartInterface unknownCartId.
			self assert: previousNumberOfCarts = cartInterface numberOfCarts]
	
	! !

!CartInterfaceTest methodsFor: 'tests' stamp: 'jcm 11/12/2024 13:45:50'!
test04aKnownCartRemebersItsItemsAndQuantities

	

	| clientAutenticator clientId password cartInterface cartId cartItems |
	
	clientId := testObjectsFactory validUserId .
	password := testObjectsFactory validUserPassword .
	
	clientAutenticator := testObjectsFactory createClientAutenticator.
	
	cartInterface := CartInterface with: testObjectsFactory .
	
	cartId := cartInterface createCartTo: clientId with: password  throught: clientAutenticator.
	
	cartInterface add: 2 Of: testObjectsFactory itemSellByTheStore To: cartId.
	
	
	cartItems := (Dictionary new).
	cartItems at: testObjectsFactory itemSellByTheStore put:2.
	"self assert: (cartInterface includes: 2 Of: testObjectsFactory itemSellByTheStore On: cartId)."
	
	self assert: (cartInterface listCart: cartId) equals: cartItems.
	self assert: cartInterface numberOfCarts equals: 1.! !

!CartInterfaceTest methodsFor: 'tests' stamp: 'jcm 11/12/2024 13:17:51'!
test05anUnknownCartCannotBeListedAndTheOtherCartsRemainsTheSame


	| clientAutenticator clientId password cartInterface unknownCartId knownCartId previousNumberOfCarts |
	
	clientId := testObjectsFactory validUserId .
	password := testObjectsFactory validUserPassword .
	
	clientAutenticator := testObjectsFactory createClientAutenticator.
	
	cartInterface := CartInterface with: testObjectsFactory .
	
	knownCartId := cartInterface createCartTo: clientId with: password  throught: clientAutenticator.
	
	previousNumberOfCarts := cartInterface numberOfCarts.
	
	unknownCartId := cartInterface createCartId.
	
	self 
		should: [ cartInterface listCart: unknownCartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CartInterface unknownCartId.
			self assert: (cartInterface listCart: knownCartId) isEmpty.
			self assert: cartInterface numberOfCarts = previousNumberOfCarts]

	! !

!CartInterfaceTest methodsFor: 'tests' stamp: 'jcm 11/12/2024 15:07:17'!
test06aKnownCartCanBeCheckedOut


	| clientAutenticator clientId password cartInterface cartId validCreditCardExpirationDate validCreditCardNumber validCreditCardOwnersName receipt |
	
	clientId := testObjectsFactory validUserId .
	password := testObjectsFactory validUserPassword .
	
	clientAutenticator := testObjectsFactory createClientAutenticator.
	
	cartInterface := CartInterface with: testObjectsFactory .
	
	cartId := cartInterface createCartTo: clientId with: password  throught: clientAutenticator.
	
	cartInterface add: 2 Of: testObjectsFactory itemSellByTheStore To: cartId.
	
	validCreditCardNumber := testObjectsFactory validCreditCardNumber.
	validCreditCardExpirationDate := testObjectsFactory validCreditCardExpirationDate .
	validCreditCardOwnersName := testObjectsFactory validCreditCardOwnersName .
	
	
	"Tendria que hacer el checkOutCart para que le mande a la interfaz y esta cree el cashier y forwardee a cart para que pueda hacer el checkout"
	
	receipt := cartInterface 
		checkOutCart: cartId 
		withCardNumber: validCreditCardNumber 
		withExpirationDate: validCreditCardExpirationDate 
		withOwnerName: validCreditCardOwnersName.
	
	
	"Por ahora asumo que checkOutCart devuelve el total de los productos por ahora"
	self assert: receipt total equals: (testObjectsFactory itemSellByTheStorePrice * 2)
	! !

!CartInterfaceTest methodsFor: 'tests' stamp: 'jcm 11/12/2024 13:18:53'!
test07anUnknownCartCannotBeCheckedOut


	| clientAutenticator clientId password cartInterface cartId validCreditCardExpirationDate validCreditCardNumber validCreditCardOwnersName previousNumberOfCarts unknownCartId |
	
	clientId := testObjectsFactory validUserId .
	password := testObjectsFactory validUserPassword .
	
	clientAutenticator := testObjectsFactory createClientAutenticator.
	
	cartInterface := CartInterface with: testObjectsFactory .
	
	cartId := cartInterface createCartTo: clientId with: password  throught: clientAutenticator.
	
	cartInterface add: 2 Of: testObjectsFactory itemSellByTheStore To: cartId.
	
	validCreditCardNumber := testObjectsFactory validCreditCardNumber.
	validCreditCardExpirationDate := testObjectsFactory validCreditCardExpirationDate .
	validCreditCardOwnersName := testObjectsFactory validCreditCardOwnersName .
	
	previousNumberOfCarts := cartInterface numberOfCarts.
	
	unknownCartId := cartInterface createCartId.
	
	
	self 
		should: [ cartInterface 
			checkOutCart:  unknownCartId
			withCardNumber:  validCreditCardNumber 
			withExpirationDate:  validCreditCardExpirationDate 
			withOwnerName: validCreditCardOwnersName ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CartInterface unknownCartId.
			self assert: cartInterface numberOfCarts = previousNumberOfCarts]
	! !

!CartInterfaceTest methodsFor: 'tests' stamp: 'jcm 11/12/2024 15:37:05'!
test08aValidCustomerKnowsItsPurchaseRecord


	| clientAutenticator clientId password cartInterface cartId validCreditCardExpirationDate validCreditCardNumber validCreditCardOwnersName cartId2 |
	
	clientId := testObjectsFactory validUserId .
	password := testObjectsFactory validUserPassword .
	
	clientAutenticator := testObjectsFactory createClientAutenticator.
	
	cartInterface := CartInterface with: testObjectsFactory .
	
	cartId := cartInterface createCartTo: clientId with: password  throught: clientAutenticator.
	
	cartInterface add: 2 Of: testObjectsFactory itemSellByTheStore To: cartId.
	
	validCreditCardNumber := testObjectsFactory validCreditCardNumber.
	validCreditCardExpirationDate := testObjectsFactory validCreditCardExpirationDate .
	validCreditCardOwnersName := testObjectsFactory validCreditCardOwnersName .
	
	cartId2 := cartInterface createCartTo: clientId with: password  throught: clientAutenticator.
	
	cartInterface add: 1 Of: testObjectsFactory itemSellByTheStore To: cartId2.
	
	"Ahora si tengo que crear una estructura para almacenar las Sales por cada cliente"
	
	cartInterface 
		checkOutCart: cartId 
		withCardNumber: validCreditCardNumber 
		withExpirationDate: validCreditCardExpirationDate 
		withOwnerName: validCreditCardOwnersName.
		
	cartInterface 
		checkOutCart: cartId2
		withCardNumber: validCreditCardNumber 
		withExpirationDate: validCreditCardExpirationDate 
		withOwnerName: validCreditCardOwnersName.
	

	self assert: (cartInterface listPurchasesOf: clientId with: password) equals: 'validBook|3|30'.
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


!CashierTest methodsFor: 'tests' stamp: 'jcm 11/11/2024 16:17:08'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory createValidCreditCard 
			throught: (MerchantProcesor with: testObjectsFactory defaultDebitBehavior)
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/12/2024 15:05:22'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory createValidCreditCard 
		throught: (MerchantProcesor with: testObjectsFactory defaultDebitBehavior)
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut total equals: (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/11/2024 16:20:22'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory createInvalidCreditCard 
				throught: (MerchantProcesor with: testObjectsFactory defaultDebitBehavior)
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/12/2024 15:05:51'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory createValidCreditCard 
		throught: (MerchantProcesor with: testObjectsFactory defaultDebitBehavior)
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut total.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/12/2024 15:06:02'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory createValidCreditCard .
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: (MerchantProcesor with:  [ :anAmount :aCreditCard | debitedAmout := anAmount.debitedCreditCard := aCreditCard ])
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut total.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/12/2024 15:06:17'!
test05WithMock_CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard merchantProcessor mpReceivedMessages debitFromMessage |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory createValidCreditCard .
	salesBook := OrderedCollection new.
	merchantProcessor := Mock onlyCollecting.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: merchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut total.
	mpReceivedMessages := merchantProcessor receivedMessages.
					
	self assert: 1 equals: mpReceivedMessages size.
	debitFromMessage := mpReceivedMessages first.
	self assert: debitFromMessage selector equals: #debit:from:.
	self assert: debitFromMessage arguments first equals: total.
	self assert: debitFromMessage arguments second equals: creditCard 
	! !

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/11/2024 16:20:52'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory createValidCreditCard .
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

!CashierTest methodsFor: 'tests' stamp: 'jcm 11/11/2024 16:20:56'!
test06WithMock_CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard merchantProcessor |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory createValidCreditCard .
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


!Cart methodsFor: 'items' stamp: 'jcm 11/12/2024 15:03:03'!
items

	^items copy
	! !

!Cart methodsFor: 'items' stamp: 'jcm 11/9/2024 15:49:37'!
itemsAsString

	| string |
	
	string := ''.
	
	items keysDo: [:keys | string := string , keys ].
	
	^string
	! !

!Cart methodsFor: 'items' stamp: 'jcm 11/12/2024 12:29:09'!
listItems

	^items copy
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
	instanceVariableNames: 'cartId carts objectsFactory transactions receipts cartOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartInterface methodsFor: 'adding' stamp: 'jcm 11/12/2024 15:34:23'!
addReceipt: aReceipt to: anUserId


	(receipts includesKey: anUserId) 
		ifTrue: [(receipts at: anUserId) add: aReceipt]
		ifFalse:[receipts at: anUserId put: (OrderedCollection with: aReceipt)]! !


!CartInterface methodsFor: 'createCart' stamp: 'jcm 11/9/2024 14:13:18'!
createCartId

	cartId := cartId  + 1.
	
	^cartId  - 1! !

!CartInterface methodsFor: 'createCart' stamp: 'jcm 11/12/2024 14:50:07'!
createCartTo: clientId with: password throught: clientAutenticator 
	
	
	| currentCartId |
	clientAutenticator assertValidClientId: clientId and: password.
	"Aca pense en crear un servicio aparte que me de el id del carrito pero me parecio mucho"
	currentCartId := self createCartId.
	carts add: objectsFactory createCart.
	cartOwner at: currentCartId put: clientId.
	
	^currentCartId ! !


!CartInterface methodsFor: 'list' stamp: 'jcm 11/9/2024 15:51:58'!
listCart: aCartId
	| cart |
	
	self assertValidCartId: aCartId.
	 
	cart := carts at: aCartId.
	
	
	^cart listItems.
	! !

!CartInterface methodsFor: 'list' stamp: 'jcm 11/12/2024 15:47:21'!
listPurchasesOf: aClientId with: aClientsPassword

	"Habria que acceder al recibo y devolver por ahi el string que contenga los items y el total"
	
	
	|totalAmount |
	
	totalAmount := (receipts at: aClientId) sum:[:receipt | receipt total].
	
	"De todos los recibos quisiera como armar uno solo, en donde tenga de todas las compras por cada libro, la cantidad que compre en total"
	
	"Para esto itero receipts y voy agregando los elementos a un nuevo diccionario"
	"purchasedItems := Dictionary new.
	
	
	^(receipts at: aClientId) do:[:receipt | receipt ]."
	
	
	
	
	! !

!CartInterface methodsFor: 'list' stamp: 'jcm 11/12/2024 12:31:52'!
numberOfCarts

	^carts size! !


!CartInterface methodsFor: 'assert' stamp: 'jcm 11/9/2024 14:39:34'!
assertValidCartId: aCartId.

	carts size < aCartId ifTrue:[self error: self class unknownCartId]! !


!CartInterface methodsFor: 'instance creation' stamp: 'jcm 11/12/2024 14:50:01'!
initializeWith: anObjectsFactory 
	
	objectsFactory := anObjectsFactory.
	cartId := 1.
	carts := OrderedCollection new.
	receipts := Dictionary new.
	cartOwner := Dictionary new.! !


!CartInterface methodsFor: 'checkOutCart' stamp: 'jcm 11/12/2024 15:26:35'!
checkOutCart: cartsId withCardNumber: creditCardNumber withExpirationDate: creditCardExpirationDate withOwnerName: creditCardOwnersName

	| creditCard merchantProcesor cashier cart receipt userId |
	
	self assertValidCartId: cartsId.
	
	creditCard := CreditCard number: creditCardNumber expiringOn: creditCardExpirationDate ownersName: creditCardOwnersName .
	merchantProcesor := MerchantProcesor with: objectsFactory defaultDebitBehavior.
	cart := carts at: cartsId.
	cashier := Cashier toCheckout: cart charging: creditCard throught: merchantProcesor on: objectsFactory today registeringOn: OrderedCollection new.
	
	
	"Asumo que transaction ID no es la el id de la transaccion de la tarjeta de credito para trascear la transaccion, sino que es el id del supermercado para poder trascear el recibo"
	
	"La idea es hacer que cashier checkout me devuelva un recibo para asi poder almacenarlo en un diccionario bajo el id del cliente"
	
	
	
	receipt := cashier checkOut.
	
	"Ahora habria que almacenar este recibo en una lista de recibos que puedan ser encontradas por el userId"
	
	"Modifique cartInterface para que almacene un diccionario con CartsId cuyos valores sean los ids del usuario que los creo"
	
	userId := cartOwner at: cartsId.
	
	self addReceipt: receipt to: userId.
	
	
	
	^receipt
	 
	! !


!CartInterface methodsFor: 'cart' stamp: 'jcm 11/12/2024 13:44:58'!
add: anAmountOfItems Of: aTypeOfItem To: aCartId 

	| cart |
	
	self assertValidCartId: aCartId.
	
	cart := carts at: aCartId.
	
	cart add: anAmountOfItems of: aTypeOfItem.
	
	
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


!Cashier methodsFor: 'checkout' stamp: 'jcm 11/12/2024 14:55:54'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ Receipt purchasedItems: cart items withTotal: total! !


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
	instanceVariableNames: 'expiration ownersName number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'jcm 11/11/2024 16:16:32'!
initializeWith: aCardNumber with: anExpirationDate and: theOwnersName

	ownersName := theOwnersName.
	number := aCardNumber.
	expiration := anExpirationDate 

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !

!CreditCard class methodsFor: 'instance creation' stamp: 'jcm 11/11/2024 16:15:31'!
number: aCardNumber expiringOn: anExpirationDate ownersName: theOwnersName


	^self new initializeWith: aCardNumber with: anExpirationDate and:theOwnersName.! !


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


!classDefinition: #Receipt category: #TusLibros!
Object subclass: #Receipt
	instanceVariableNames: 'items total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!Receipt methodsFor: 'instance creation' stamp: 'jcm 11/12/2024 14:59:09'!
initializeWith: cartItems with:aSaleTotal

	items := cartItems.
	total := aSaleTotal.! !

!Receipt methodsFor: 'instance creation' stamp: 'jcm 11/12/2024 15:05:13'!
total
	
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Receipt class' category: #TusLibros!
Receipt class
	instanceVariableNames: ''!

!Receipt class methodsFor: 'as yet unclassified' stamp: 'jcm 11/12/2024 14:57:03'!
purchasedItems: cartItems withTotal: aSaleTotal

	^self new initializeWith: cartItems with:aSaleTotal.! !


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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'jcm 11/11/2024 16:18:58'!
createInvalidCreditCard

	^CreditCard number: self invalidCreditCardNumber expiringOn: (Month month: today monthIndex year: today yearNumber - 1) ownersName: self invalidCreditCardOwnersName.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'jcm 11/11/2024 16:13:28'!
createValidCreditCard

	^CreditCard number: self validCreditCardNumber expiringOn: (Month month: today monthIndex year: today yearNumber + 1) ownersName: self validCreditCardOwnersName.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'jcm 11/11/2024 16:18:38'!
invalidCreditCardNumber

	^123456789 ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'jcm 11/11/2024 16:18:48'!
invalidCreditCardOwnersName

	^'Juan Cruz'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'jcm 11/11/2024 16:23:32'!
validCreditCardExpirationDate
	
	^Month month: today monthIndex year: today yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'jcm 11/11/2024 16:13:06'!
validCreditCardNumber

	^1234567891234567 ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'jcm 11/11/2024 16:13:23'!
validCreditCardOwnersName

	^'Pepe'! !


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
