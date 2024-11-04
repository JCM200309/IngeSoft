!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/16/2024 15:09:54'!
createPortfolioWithMoreThanOneAccount

	| account1 account2 portfolio2Accounts portfolio1Accounts portfolio2 |
	
	account1 := ReceptiveAccount  new.
	Deposit register: 50 on: account1.
	account2 := ReceptiveAccount new.
	Deposit register: 70 on: account2.
	
	
	portfolio2Accounts := OrderedCollection new.
	portfolio2Accounts add: account1 .
	portfolio2Accounts add: account2.
	
	portfolio2 := Portfolio with: portfolio2Accounts .	
	
	portfolio1Accounts := OrderedCollection new.
	portfolio1Accounts add: portfolio2.
	
	
	^Portfolio with: portfolio1Accounts .
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/16/2024 15:03:08'!
createPortfolioWithOneAccount

	| account accounts deposit|
	
	account := ReceptiveAccount  new.
	
	deposit :=  Deposit register: (200) on: account.
	
	
	accounts := OrderedCollection new.
	accounts add: account.
	
	^Portfolio with: accounts.
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/16/2024 15:05:07'!
createPortfolioWithOneAccount: anAccount

	| accounts |
	
	
	accounts := OrderedCollection new.
	accounts add: anAccount .
	
	^Portfolio with: accounts.
	
	
! !

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/16/2024 11:38:34'!
test08PortfolioEmptyBalanceIsCero

	| portfolio accounts|
	
	"Aca tuve que modificar el test ya que antes hacia esto
	portfolio := Portfolio new."
	
	accounts := OrderedCollection new.
	portfolio := Portfolio with: accounts.
	self assert: 0 equals: portfolio balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/16/2024 15:08:35'!
test09PortfolioWithOneReceptiveAccountBalance

	| portfolio account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio := self createPortfolioWithOneAccount: account.
	
	self assert: 100 equals: portfolio balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/16/2024 15:02:34'!
test10PortfolioWithMoreThanOneReceptiveAccountBalance

	| portfolio1 |
	
	
	portfolio1 := self createPortfolioWithMoreThanOneAccount .

	
	self assert: 120 equals: portfolio1 balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/16/2024 13:18:14'!
test11PortfolioEmptyDoNotKnowAnyRegisteredTransaction

	| portfolio accounts deposit|

	
	accounts := OrderedCollection new.
	portfolio := Portfolio with: accounts.
	deposit :=  Deposit for: 200.
	
	self deny: (portfolio hasRegistered: deposit)
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/16/2024 15:07:53'!
test12PortfolioWithOneReceptiveAccountKnowRegisteredTransaction

	| portfolio account deposit|
	
	account := ReceptiveAccount  new.
	deposit :=  Deposit register: (200) on: account.
	
	portfolio := self createPortfolioWithOneAccount: account.
	
	
	
	self assert: (portfolio hasRegistered: deposit).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/16/2024 15:02:34'!
test13PortfolioWithMoreThanOneReceptiveAccountDoNotKnowsOneRegisteredTransaction

	| portfolio1 deposit|	

	deposit := Deposit for: 500.
	
	portfolio1 := self createPortfolioWithMoreThanOneAccount .

	self deny: (portfolio1 hasRegistered: deposit).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/16/2024 13:21:24'!
test14PortfolioEmptyHave0Transactions

	| portfolio accounts |

	
	accounts := OrderedCollection new.
	portfolio := Portfolio with: accounts.
	
	self assert: 0 equals: portfolio transactions size.
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/16/2024 15:07:10'!
test15PortfolioWithOneReceptiveAccountKnowsItsTransactions

	| portfolio account deposit|
	
	account := ReceptiveAccount  new.
	
	deposit :=  Deposit register: (200) on: account.
	
	portfolio := self createPortfolioWithOneAccount: account.
	
	self assert: 1 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: deposit)
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/16/2024 15:10:26'!
test16PortfolioWithMoreThanOneReceptiveAccountKnowsItsTransactions

	| portfolio1 portfolio2 portfolio1Accounts account1 account2 portfolio2Accounts deposit1 deposit2 |
	
	"En esta no lo pude abstraer porque tenia que guardarme los deposits para ver si pertenecian"
	
	account1 := ReceptiveAccount  new.
	deposit1 := Deposit register: 50 on: account1.
	account2 := ReceptiveAccount new.
	deposit2 := Deposit register: 70 on: account2.
	
	
	portfolio2Accounts := OrderedCollection new.
	portfolio2Accounts add: account1 .
	portfolio2Accounts add: account2.
	
	portfolio2 := Portfolio with: portfolio2Accounts .	
	
	portfolio1Accounts := OrderedCollection new.
	portfolio1Accounts add: portfolio2.
	
	
	portfolio1 := Portfolio with: portfolio1Accounts .

	self assert: 2 equals: portfolio1 transactions size.
	self assert: (portfolio1 transactions includes: deposit1).
	self assert: (portfolio1 transactions includes: deposit2)
	
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


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'transactions' stamp: 'jcm 10/16/2024 13:02:21'!
hasRegistered: aTransaction
	
	"^accounts ifNil:[false] ifNotNil:[accounts hasRegistered: aTransaction]."
	^accounts ifEmpty:[false] ifNotEmpty:[
		accounts allSatisfy: [:account | account hasRegistered: aTransaction]]! !

!Portfolio methodsFor: 'transactions' stamp: 'jcm 10/16/2024 13:40:30'!
transactions
	| transactions |
	transactions := OrderedCollection new.
	accounts do: [:account | transactions addAll: (account transactions)].
	^transactions 
	
	! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'jcm 10/16/2024 12:19:18'!
balance

	^accounts sum: [:account | account balance]  ifEmpty: [0]! !


!Portfolio methodsFor: 'initialize' stamp: 'jcm 10/16/2024 12:16:12'!
initializeWith: anAccount 

	accounts := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'jcm 10/16/2024 11:16:29'!
balance
	self shouldBeImplemented.! !


!Portfolio class methodsFor: 'instance creation' stamp: 'jcm 10/16/2024 11:22:14'!
with: anAccount 

	^self new initializeWith: anAccount ! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
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


!ReceptiveAccount methodsFor: 'testing' stamp: 'jcm 10/16/2024 12:53:08'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
