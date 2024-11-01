!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jcm 10/25/2024 15:07:23'!
test01PortfolioWithOneReceptiveAccountBalance

	| portfolio account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: 100 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jcm 10/25/2024 15:07:30'!
test02PortfolioWithMoreThanOneReceptiveAccountBalance

	| portfolio1 portfolio2 account1 account2|
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	account2 := ReceptiveAccount  new.
	Withdraw register: 50 on: account2.
	
	portfolio1 := Portfolio new.
	portfolio1 add: account1.
	portfolio1 add: account2.
	
	portfolio2 := Portfolio new.
	portfolio2 add: portfolio1.
	
	
	self assert: 50 equals: portfolio1 balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jcm 10/25/2024 15:07:36'!
test03PortfolioEmptyDoNotKnowAnyRegisteredTransaction

	| portfolio deposit|

	portfolio := Portfolio new.
	deposit :=  Deposit for: 200.
	
	self deny: (portfolio hasRegistered: deposit)
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jcm 10/25/2024 15:07:41'!
test04PortfolioWithOneReceptiveAccountKnowRegisteredTransaction

	| portfolio account deposit|
	
	account := ReceptiveAccount  new.
	deposit :=  Deposit register: (200) on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	
	
	self assert: (portfolio hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jcm 10/25/2024 15:07:47'!
test05PortfolioWithMoreThanOneReceptiveAccountDoNotKnowsOneRegisteredTransaction

	| portfolio1 deposit account1 account2 portfolio2 |	
	
	account1 := ReceptiveAccount  new.
	Deposit register: 50 on: account1.
	account2 := ReceptiveAccount new.
	Deposit register: 70 on: account2.
	
	deposit := Deposit for: 500.
	
	portfolio1 := Portfolio new.
	portfolio1 add: account1.
	portfolio1 add: account2.
	
	portfolio2 := Portfolio new.
	portfolio2 add: portfolio1.

	self deny: (portfolio2 hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jcm 10/25/2024 15:07:52'!
test06PortfolioEmptyHave0Transactions

	| portfolio|

	portfolio := Portfolio new.
	
	
	self assert: portfolio transactions isEmpty .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jcm 10/25/2024 15:07:56'!
test07PortfolioWithOneReceptiveAccountKnowsItsTransactions

	| portfolio account deposit|
	
	account := ReceptiveAccount new.
	
	deposit :=  Deposit register: (200) on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: 1 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: deposit)
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jcm 10/25/2024 15:08:01'!
test08PortfolioWithMoreThanOneReceptiveAccountKnowsItsTransactions

	| portfolio1 portfolio2 account1 account2 deposit1 deposit2 |
	
	
	account1 := ReceptiveAccount  new.
	deposit1 := Deposit register: 50 on: account1.
	account2 := ReceptiveAccount new.
	deposit2 := Deposit register: 70 on: account2.
	
	
	portfolio1 := Portfolio new.
	portfolio1 add: account1.
	portfolio1 add: account2.	
	
	
	portfolio2 := Portfolio new.
	portfolio2 add: portfolio1.

	self assert: 2 equals: portfolio2 transactions size.
	self assert: (portfolio2 transactions includes: deposit1).
	self assert: (portfolio2 transactions includes: deposit2)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jcm 10/25/2024 15:08:06'!
test09CannotAddARepeatedReceptiveAccountToAPortfolioWithOneAccount

	| portfolio1 account1 |
	
	
	account1 := ReceptiveAccount  new.
	Deposit register: 50 on: account1.
	
	
	portfolio1 := Portfolio new.
	portfolio1 add: account1.
	

	
	self should: [portfolio1 add: account1] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: portfolio1 class cannotAddARepeatedReceptiveAccountMessageError]
		! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jcm 10/25/2024 15:08:11'!
test10CannotAddARepeatedReceptiveAccountToAPortfolioWithMoreThanOneAccount

	| portfolio1 account1 account2 |
	
	
	account1 := ReceptiveAccount  new.
	Deposit register: 50 on: account1.
	account2 := ReceptiveAccount  new.
	Withdraw register: 20 on: account1.
	
	
	portfolio1 := Portfolio new.
	portfolio1 add: account1.
	portfolio1 add: account2.
	

	
	self should: [portfolio1 add: account2] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: portfolio1 class cannotAddARepeatedReceptiveAccountMessageError]
		! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jcm 10/25/2024 15:08:16'!
test11CannotAddAPortfolioThatIncludesARepeatedReceptiveAccount

	| portfolio1 account1 portfolio2 |
	
	
	account1 := ReceptiveAccount  new.
	Deposit register: 50 on: account1.
	
	
	portfolio1 := Portfolio new.
	portfolio1 add: account1.
	
	portfolio2 := Portfolio new.
	portfolio2 add: account1.
	

	
	self should: [portfolio1 add: portfolio2] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: portfolio1 class cannotAddARepeatedReceptiveAccountMessageError]
		! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jcm 10/25/2024 15:08:20'!
test12CannotAddAPortfolioThatIncludesAReceptiveAccountInTheFatherPortfolio

	| portfolio1 account1 portfolio2 portfolio3 |
	
	
	account1 := ReceptiveAccount  new.
	Deposit register: 50 on: account1.
		
	
	portfolio2 := Portfolio new.
	
	portfolio1 := Portfolio new.
	portfolio1 add: account1.
	portfolio1 add: portfolio2.
	
	portfolio3 := Portfolio new.
	portfolio3 add: account1.
	

	self should: [portfolio2 add: portfolio3] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: portfolio1 class cannotAddARepeatedReceptiveAccountMessageError]
		! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jcm 10/25/2024 15:08:25'!
test13CannotAddAPortfolioThatIncludesAReceptiveAccountInTheGreatFatherPortfolio

	| portfolio1 account1 portfolio2 account2 portfolio3 |
	
	
	account1 := ReceptiveAccount  new.
	Deposit register: 50 on: account1.
	account2 := ReceptiveAccount  new.
	Withdraw register: 50 on: account1.
	
	portfolio2 := Portfolio new.
	
	portfolio1 := Portfolio new.
	portfolio1 add: account1.
	portfolio1 add: portfolio2.
	
	portfolio3 := Portfolio new.
	
	portfolio2 add: account2.
	portfolio2 add: portfolio3.
	


	self should: [portfolio3 add: account1] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: portfolio1 class cannotAddARepeatedReceptiveAccountMessageError]
		! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jcm 10/25/2024 15:15:53'!
test14General

	| portfolio1 account1 portfolio2 account2 portfolio3 |
	
	
	account1 := ReceptiveAccount  new.
	Deposit register: 50 on: account1.
	account2 := ReceptiveAccount  new.
	Withdraw register: 50 on: account1.
	
	portfolio2 := Portfolio new.
	
	portfolio1 := Portfolio new.
	portfolio1 add: account1.
	
	
	portfolio3 := Portfolio new.
	portfolio3 add: account1.
	
	portfolio2 add: account2.
	portfolio2 add: portfolio3.
	


	self should: [portfolio1 add: portfolio2] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: portfolio1 class cannotAddARepeatedReceptiveAccountMessageError]
		! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'L C 10/15/2024 21:42:50'!
valueForBalance

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'L C 10/15/2024 21:30:06'!
valueForBalance
	
	^ value! !


!Deposit methodsFor: 'balance' stamp: 'L C 10/15/2024 21:46:58'!
updateBalance: balanceActual 
	
	^ balanceActual +  value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'L C 10/15/2024 21:46:58'!
updateBalance: balanceActual 
	
	^ balanceActual - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankActive category: #'Portfolio-Ejercicio'!
Object subclass: #BankActive
	instanceVariableNames: 'parentPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankActive methodsFor: 'accounts' stamp: 'jcm 10/25/2024 15:09:21'!
accounts

	self subclassResponsibility! !


!BankActive methodsFor: 'balance' stamp: 'jcm 10/25/2024 15:09:40'!
balance

	self subclassResponsibility! !


!BankActive methodsFor: 'transactions' stamp: 'jcm 10/25/2024 15:10:07'!
hasRegistered: aTransaction

	self subclassResponsibility! !

!BankActive methodsFor: 'transactions' stamp: 'jcm 10/25/2024 15:10:57'!
transactions

	self subclassResponsibility! !


!BankActive methodsFor: 'included' stamp: 'jcm 10/25/2024 15:10:20'!
includes: aBankActiveAccounts

	self subclassResponsibility! !


!BankActive methodsFor: 'initialize' stamp: 'jcm 10/25/2024 15:10:28'!
initialize

	self subclassResponsibility! !


!BankActive methodsFor: 'parentPortfolio' stamp: 'jcm 10/25/2024 15:10:42'!
parentPortfolio

	^parentPortfolio
						
	! !

!BankActive methodsFor: 'parentPortfolio' stamp: 'jcm 10/25/2024 15:10:47'!
parentPortfolio: aParentPortfolio

	parentPortfolio := aParentPortfolio 
						
	! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
BankActive subclass: #Portfolio
	instanceVariableNames: 'bankActives'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'transactions' stamp: 'jcm 10/18/2024 21:06:02'!
hasRegistered: aTransaction
	
	
	^bankActives anySatisfy: [:aBankActive | aBankActive hasRegistered: aTransaction]! !

!Portfolio methodsFor: 'transactions' stamp: 'jcm 10/18/2024 21:52:29'!
transactions

	| transactions |
	
	"Mejorar el orden de la complejidad"
	
	transactions := OrderedCollection new.
	bankActives do: [:aBankActive | transactions addAll: (aBankActive transactions)].
	^transactions 
	
	! !


!Portfolio methodsFor: 'add' stamp: 'jcm 10/25/2024 14:13:00'!
add: aBankActive

	self assertIsNotIncluded: aBankActive.
						
	bankActives add: aBankActive.
	aBankActive parentPortfolio: self
	! !


!Portfolio methodsFor: 'balance' stamp: 'jcm 10/18/2024 21:06:09'!
balance

	^bankActives sum: [:aBankActive | aBankActive balance]  ifEmpty: [0]! !


!Portfolio methodsFor: 'accounts' stamp: 'jcm 10/25/2024 15:20:43'!
accounts
	
	| accounts |
	accounts := OrderedCollection new.
	
	^bankActives do: [:bankActive | accounts addAll: bankActive accounts].
	! !


!Portfolio methodsFor: 'included' stamp: 'jcm 10/25/2024 15:09:28'!
assertIsNotIncluded: aBankActive

	
	(self isNotIncludedInSucesors: aBankActive) | (self isNotIncludedInPrecesors: aBankActive)
	
	ifTrue:[self error: self class cannotAddARepeatedReceptiveAccountMessageError]
	! !

!Portfolio methodsFor: 'included' stamp: 'jcm 10/23/2024 11:47:00'!
includes: aBankActiveAccounts


	^(aBankActiveAccounts includesAnyOf: (self accounts)) 
	! !

!Portfolio methodsFor: 'included' stamp: 'jcm 10/25/2024 14:53:11'!
isNotIncludedInPrecesors: aBankActive

	"Quiero ir hasta el portfolio que es padre de todos para pedirle las cuentas y verificar si esta"
	
	| actualPortfolio |
	
	actualPortfolio := self .
	
	[actualPortfolio parentPortfolio isNil] whileFalse:[
		actualPortfolio := actualPortfolio parentPortfolio].
	
	^aBankActive includes: (actualPortfolio accounts).
	
	! !

!Portfolio methodsFor: 'included' stamp: 'jcm 10/23/2024 12:12:26'!
isNotIncludedInSucesors: aBankActive

	
	^aBankActive includes: (self accounts)
	! !



!Portfolio methodsFor: 'initialize' stamp: 'jcm 10/18/2024 21:06:13'!
initialize

	bankActives := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error' stamp: 'jcm 10/18/2024 21:22:22'!
cannotAddARepeatedReceptiveAccountMessageError

	^'Account is alredy in portfolio'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
BankActive subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'L C 10/15/2024 21:46:58'!
balance

	^transactions inject: 0 into: [ :balanceActual :transaccion |  transaccion updateBalance: balanceActual ].
		
		
		! !


!ReceptiveAccount methodsFor: 'account' stamp: 'jcm 10/23/2024 11:38:20'!
accounts

	^self! !

!ReceptiveAccount methodsFor: 'account' stamp: 'jcm 10/23/2024 11:18:34'!
includes: aBankActiveAccounts

	^ aBankActiveAccounts includes: self! !

!ReceptiveAccount methodsFor: 'account' stamp: 'jcm 10/23/2024 11:54:32'!
parentPorfolio: aParentPortfolio

	! !



!ReceptiveAccount methodsFor: 'testing' stamp: 'jcm 10/16/2024 12:53:08'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
