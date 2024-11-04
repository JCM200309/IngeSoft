!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 13:31:00'!
test16PortfolioWithoutAccountsKnowsItsAccountSummary

	
	| mainPortfolio report |
	
	mainPortfolio := Portfolio new.
	report := Report report: mainPortfolio .
	
	self assert: report accountSummary equals: ''.
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 13:31:32'!
test17PortfolioWithAReceptiveAccountKnowsItsAccountSummary

	
	| mainPortfolio account1 report |
	
	account1 := ReceptiveAccount new.
	Deposit register: 20 on: account1.
	Withdraw register: 10 on: account1.
	
	mainPortfolio := Portfolio with: account1.
	
	report := Report report: mainPortfolio .
	
	self assert: report accountSummary equals: 
	'Depósito por 20.' , String lfString ,
	'Extracción por 10.' , String lfString ,
	'Balance = 10'..
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 13:32:32'!
test18PortfolioWithMoreThanOneReceptiveAccountKnowsItsAccountSummary

	
	| mainPortfolio account1 account2 portfolio1 report |
	
	account1 := ReceptiveAccount new.
	Deposit register: 20 on: account1.
	Withdraw register: 10 on: account1.
	
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account2.
	
	Transfer from: account2 to: account1 anAmountOfMoney: 50.
	
	portfolio1 := Portfolio with: account2.
	
	mainPortfolio := Portfolio with: account1.
	mainPortfolio add: portfolio1.	
	
	report := Report report: mainPortfolio .
	
	self assert: report accountSummary equals: 
	'Depósito por 20.' , String lfString ,
	'Extracción por 10.' , String lfString ,
	'Entrada por transferencia de 50.' , String lfString ,
	'Balance = 60' , 
	
	'Depósito por 100.' , String lfString ,
	'Salida por transferencia de 50.' , String lfString , 
	'Balance = 50'.
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 15:15:10'!
test19PortfolioWithoutAccountsKnowsItsTransferNet

	
	| mainPortfolio report |
	
	mainPortfolio := Portfolio new.
	
	report := Report report: mainPortfolio.
	
	self assert: report transferNet equals: 0.
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 15:17:30'!
test20PortfolioWithAReceptiveAccountKnowsItsTransferNet

	
	| mainPortfolio account1 account2 report |
	
	account1 := ReceptiveAccount new.
	Deposit register: 20 on: account1.
	Withdraw register: 10 on: account1.
	
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	
	Transfer from:  account2 to: account1 anAmountOfMoney: 50.
	
	mainPortfolio := Portfolio with: account1.
	
	report := Report report: mainPortfolio.
	
	self assert: report transferNet equals: 50.
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 15:17:45'!
test21PortfolioWithMoreThanOneAccountKnowsItsTransferNet

	
	| mainPortfolio account1 account2 portfolio1 report |
	
	account1 := ReceptiveAccount new.
	Deposit register: 20 on: account1.
	Withdraw register: 10 on: account1.
	
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account2.
	
	Transfer from: account2 to: account1 anAmountOfMoney: 50.
	Transfer from: account1 to: account2 anAmountOfMoney: 20.
	
	portfolio1 := Portfolio with: account2.
	
	mainPortfolio := Portfolio with: account1.
	mainPortfolio add: portfolio1.	
	
	report := Report report: mainPortfolio.
	
	self assert: report transferNet equals: 0.
	
	
	! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/26/2024 13:55:34'!
test08AnAccountTransfersAnAmountOfMoneyToAnotherAccount

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Deposit register: 70 on: account2.
	
	Transfer from: account1 to: account2 anAmountOfMoney: 20.
	
	
	self assert: 80 equals: account1 balance.
	self assert: 90 equals: account2 balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/27/2024 12:57:09'!
test09ReceptiveAccountKnowsItsTransfers

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Deposit register: 70 on: account2.
	
	transfer := Transfer from: account1 to: account2 anAmountOfMoney: 20.
	
	self assert: (account1 hasRegistered: transfer withdrawLeg).
	self assert: (account2 hasRegistered: transfer depositLeg).
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/27/2024 19:27:46'!
test10WeCanNavegateFromWithdrawLegToDepositLegAndViceVersa

	| account1 account2 transfer depositsLeg withdrawsLeg |
	
	"VER DIBUJO"
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Deposit register: 70 on: account2.
	
	transfer := Transfer from: account1 to: account2 anAmountOfMoney: 20.
	withdrawsLeg := transfer withdrawLeg.
	depositsLeg := transfer depositLeg.
	
	self assert: ((withdrawsLeg transfer) depositLeg) equals: depositsLeg.
	self assert: ((depositsLeg transfer) withdrawLeg) equals: withdrawsLeg.
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/26/2024 21:25:43'!
test11ReceptiveAccountCantMakeATransferWithNegativeAmount

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Deposit register: 70 on: account2.
	
	self should:  [Transfer from: account1 to: account2 anAmountOfMoney: -10]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:error | self assert: error messageText equals: Transfer cannotTransferWithNegativeAmount]
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 10/26/2024 21:33:23'!
test12ReceptiveAccountCantMakeATransferToItself

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Deposit register: 70 on: account2.
	
	self should:  [Transfer from: account1 to: account1 anAmountOfMoney: 10]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:error | self assert: error messageText equals: Transfer cannotTransferToItself]
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 12:57:11'!
test13ReceptiveAccountWithoutTransactionsKnowsItsAccountSummary

	| account1 report |
	
	account1 := ReceptiveAccount new.
	report := Report report: account1.
	
	self assert: report accountSummary equals: 'Balance = 0'.
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 13:08:56'!
test14ReceptiveAccountWithADepositKnowsItsAccountSummary

	| account1 report |
	
	account1 := ReceptiveAccount new.
	Deposit register: 20 on: account1.
	
	report := Report report: account1.
	
	self assert: report accountSummary equals: 
	'Depósito por 20.' , String lfString , 'Balance = 20'.
	
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 13:09:23'!
test15ReceptiveAccountWithAWithdrawKnowsItsAccountSummary

	| account1 report |
	
	account1 := ReceptiveAccount new.
	Withdraw register: 20 on: account1.
	
	report := Report report: account1.
	
	self assert: report accountSummary equals: 
	'Extracción por 20.' , String lfString , 'Balance = -20'.
	
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 13:09:57'!
test16ReceptiveAccountWithAWithdrawFromTransferKnowsItsAccountSummary

	| account1 account2 report |

	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	
	Transfer from: account1 to:  account2 anAmountOfMoney: 20.
	
	report := Report report: account1.
	
	self assert: report accountSummary equals: 
	'Salida por transferencia de 20.' , String lfString , 'Balance = -20'.
	
	
	
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 13:11:44'!
test17ReceptiveAccountWithADepositFromTransferKnowsItsAccountSummary

	| account1 account2 report |

	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	
	Transfer from: account1 to:  account2 anAmountOfMoney: 20.
	
	report := Report report: account2.
	
	self assert: report accountSummary equals: 
	'Entrada por transferencia de 20.' , String lfString , 'Balance = 20'.
	
	
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 13:12:18'!
test18ReceptiveAccountWithMoreThanOneTransactionsKnowsItsAccountSummary

	| account1 account2 report |

	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Transfer from: account1 to:  account2 anAmountOfMoney: 20.
	Transfer from: account2 to:  account1 anAmountOfMoney: 30.
	
	report := Report report: account1.
	
	self assert: report accountSummary equals: 
	'Depósito por 100.' , String lfString ,
	'Extracción por 50.' , String lfString ,
	'Salida por transferencia de 20.' , String lfString , 
	'Entrada por transferencia de 30.' , String lfString ,
	'Balance = 60'.
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 13:16:48'!
test19ReceptiveAccountCeroTransfersKnowsItsTransferNet

	
	| account1 report |

	
	account1 := ReceptiveAccount new.
	
	report := Report report: account1.
	
	self assert: report transferNet equals: 0
	
	
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 13:17:34'!
test20ReceptiveAccountWithADepositFromTransferKnowsItsTransferNet

	| account1 account2 report |

	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	
	Transfer from: account1 to:  account2 anAmountOfMoney: 20.
	
	report := Report report: account2.
	
	self assert: report transferNet equals: 20
	

	
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 13:17:50'!
test21ReceptiveAccountWithAWithdrawFromTransferKnowsItsTransferNet

	| account1 account2 report |

	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	
	Transfer from: account1 to:  account2 anAmountOfMoney: 20.
	
	report := Report report: account1.
	
	self assert: report transferNet equals: -20
	
	
	
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcm 11/1/2024 13:18:04'!
test22ReceptiveAccountWithMoreThanOneTransferMovementKnowsItsTransferNet

	| account1 account2 report |

	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	
	Transfer from: account1 to:  account2 anAmountOfMoney: 20.
	Transfer from: account2 to: account1 anAmountOfMoney: 30.
	
	report := Report report: account1.
	
	self assert: report transferNet equals: 10
	
	
	! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'AccountSummary' stamp: 'jcm 11/1/2024 13:28:34'!
accountSummaryOn: aReport
	
	^aReport accountSummaryOfAPortfolioWith: accounts! !


!Portfolio methodsFor: 'transfer Net' stamp: 'jcm 11/1/2024 12:01:23'!
transferNet
	
	^accounts inject: 0 into: [:portfolioAccountSummary :account | portfolioAccountSummary + (account transferNet ) ] ! !

!Portfolio methodsFor: 'transfer Net' stamp: 'jcm 11/1/2024 15:15:57'!
transferNetOn: aReport
	
		^aReport transferNetOfAPortfolioWith: accounts ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'transferNet' stamp: 'jcm 11/1/2024 13:15:21'!
transferNetOn: aReport

	^aReport transferNetOfAReceptiveAccountWith: transactions! !


!ReceptiveAccount methodsFor: 'accountSummary' stamp: 'jcm 11/1/2024 13:38:54'!
accountSummaryOn: aReport
	
	^aReport accountSummaryOfAReceptiveAccountWith: transactions and: self balance.! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #Report category: #'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'instance creation' stamp: 'jcm 11/1/2024 12:57:59'!
initializeReport: anAccount 
	
	account := anAccount.! !


!Report methodsFor: 'transfer net' stamp: 'jcm 11/1/2024 13:14:01'!
transferNet

	^account transferNetOn: self! !

!Report methodsFor: 'transfer net' stamp: 'jcm 11/1/2024 15:30:37'!
transferNetOfAPortfolioWith: accounts

	
	^accounts inject: 0 into: [:portfolioAccountSummary :accountPortfolio | portfolioAccountSummary + (accountPortfolio transferNetOn: self) ] 
		! !

!Report methodsFor: 'transfer net' stamp: 'jcm 11/1/2024 13:15:37'!
transferNetOfAReceptiveAccountWith: transactions

	^transactions inject: 0 into: [:currentTransferNet :transaction | currentTransferNet + transaction transferNet]
		! !


!Report methodsFor: 'Account Summary' stamp: 'jcm 11/1/2024 13:01:40'!
accountSummary
	
	^account accountSummaryOn: self! !

!Report methodsFor: 'Account Summary' stamp: 'jcm 11/1/2024 13:29:53'!
accountSummaryOfAPortfolioWith: portfolioAccounts

	

	^portfolioAccounts inject: '' into: [:portfolioAccountSummary :portfolioAccount | portfolioAccountSummary , (portfolioAccount accountSummaryOn:self) ] ! !

!Report methodsFor: 'Account Summary' stamp: 'jcm 11/1/2024 13:38:35'!
accountSummaryOfAReceptiveAccountWith: transactions and: balance

	^(transactions inject: '' into:[:summaryString :transaction | summaryString , (transaction stringOfTransaction)])
	, ('Balance = ' , balance asString).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: #'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'jcm 11/1/2024 12:57:38'!
report: anAccount
	
	^self new initializeReport: anAccount! !


!classDefinition: #Transactions category: #'Portfolio-Solucion'!
Object subclass: #Transactions
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transactions methodsFor: 'accountSummary' stamp: 'jcm 11/1/2024 09:38:15'!
stringOfTransaction

	self subclassResponsibility! !


!Transactions methodsFor: 'value' stamp: 'jcm 10/29/2024 12:05:09'!
value
	
	self subclassResponsibility ! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Transactions subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'jcm 10/29/2024 12:00:47'!
value

	^value! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'transfer Net' stamp: 'jcm 11/1/2024 11:57:38'!
transferNet

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'accountSummary' stamp: 'jcm 11/1/2024 09:38:15'!
stringOfTransaction

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'jcm 10/27/2024 19:17:10'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'jcm 10/29/2024 12:15:59'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'accountSummary' stamp: 'jcm 11/1/2024 09:38:15'!
stringOfTransaction

	^'Depósito por ' , self value asString , '.' , String lfString! !


!Deposit methodsFor: 'transfer Net' stamp: 'jcm 11/1/2024 11:57:45'!
transferNet

	^0! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'accountSummary' stamp: 'jcm 11/1/2024 09:38:15'!
stringOfTransaction

	^'Extracción por ' , self value asString , '.' , String lfString! !


!Withdraw methodsFor: 'transfer Net' stamp: 'jcm 11/1/2024 11:57:49'!
transferNet

	^0! !


!classDefinition: #TransferTransactions category: #'Portfolio-Solucion'!
Transactions subclass: #TransferTransactions
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransactions methodsFor: 'Transfer' stamp: 'jcm 10/27/2024 19:16:00'!
transfer

	^transfer! !


!TransferTransactions methodsFor: 'value' stamp: 'jcm 10/29/2024 12:05:26'!
value

	^transfer value! !


!TransferTransactions methodsFor: 'instance creation' stamp: 'jcm 10/29/2024 11:58:55'!
initializeFor: aTransfer

	transfer := aTransfer! !


!TransferTransactions methodsFor: 'accountSummary' stamp: 'jcm 11/1/2024 09:38:15'!
stringOfTransaction

	self subclassResponsibility! !


!TransferTransactions methodsFor: 'transferNet' stamp: 'jcm 11/1/2024 10:36:55'!
transferNet

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransactions class' category: #'Portfolio-Solucion'!
TransferTransactions class
	instanceVariableNames: ''!

!TransferTransactions class methodsFor: 'instance creation' stamp: 'jcm 10/29/2024 11:59:37'!
for: aTransfer

	^self new initializeFor: aTransfer.! !

!TransferTransactions class methodsFor: 'instance creation' stamp: 'jcm 10/29/2024 11:56:26'!
register: aTransfer on: anAccount 

	| transaction |
	
	transaction := self for: aTransfer.
	anAccount register: transaction.
		
	^ transaction! !


!classDefinition: #DepositLeg category: #'Portfolio-Solucion'!
TransferTransactions subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositLeg methodsFor: 'balance' stamp: 'jcm 10/29/2024 12:05:38'!
affectBalance: aBalance

	^aBalance + self value ! !


!DepositLeg methodsFor: 'accountSummary' stamp: 'jcm 11/1/2024 09:38:15'!
stringOfTransaction

	^'Entrada por transferencia de ' , self value asString , '.' , String lfString! !


!DepositLeg methodsFor: 'transferNet' stamp: 'jcm 11/1/2024 10:40:16'!
transferNet

	^self value! !


!classDefinition: #WithdrawLeg category: #'Portfolio-Solucion'!
TransferTransactions subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawLeg methodsFor: 'balance' stamp: 'jcm 10/29/2024 12:05:45'!
affectBalance: aBalance

	^aBalance - self value ! !


!WithdrawLeg methodsFor: 'accountSummary' stamp: 'jcm 11/1/2024 09:38:15'!
stringOfTransaction

	^'Salida por transferencia de ' , self value asString , '.' , String lfString! !


!WithdrawLeg methodsFor: 'transferNet' stamp: 'jcm 11/1/2024 10:40:32'!
transferNet

	^-1 *self value! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'depositLeg withdrawLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'withdraw' stamp: 'jcm 10/27/2024 12:56:50'!
withdrawLeg

	^withdrawLeg! !


!Transfer methodsFor: 'deposit' stamp: 'jcm 10/27/2024 12:56:56'!
depositLeg

	^depositLeg! !


!Transfer methodsFor: 'value' stamp: 'jcm 10/29/2024 11:57:08'!
value
	
	^value! !


!Transfer methodsFor: 'instance Creation' stamp: 'jcm 10/29/2024 11:58:26'!
initializeFrom: aSourceReceptiveAccount to: aDestionationReceptiveAccount anAmountOfMoney: anAmountOfMoney

	value := anAmountOfMoney.
	withdrawLeg := WithdrawLeg register: self on: aSourceReceptiveAccount.
	depositLeg := DepositLeg register: self on: aDestionationReceptiveAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'jcm 10/26/2024 21:26:26'!
cannotTransferWithNegativeAmount

	^'Cannot transfer a negative amount of money'! !

!Transfer class methodsFor: 'instance creation' stamp: 'jcm 10/26/2024 21:34:41'!
from: aSourceReceptiveAccount to: aDestinationReceptiveAccount anAmountOfMoney: anAmountOfMoney 
	
	self assertPostiveAmountOfMoney: anAmountOfMoney.
	self assert: aSourceReceptiveAccount isDiferentThat: aDestinationReceptiveAccount.
	
	^self new initializeFrom: aSourceReceptiveAccount to: aDestinationReceptiveAccount anAmountOfMoney: anAmountOfMoney.
	
	! !


!Transfer class methodsFor: 'assert' stamp: 'jcm 10/26/2024 21:33:16'!
assert: aReceptiveAccount isDiferentThat: aReceptiveAccountToTransfer

	^aReceptiveAccount = aReceptiveAccountToTransfer ifTrue:[self error: self cannotTransferToItself ]! !

!Transfer class methodsFor: 'assert' stamp: 'jcm 10/26/2024 21:29:55'!
assertPostiveAmountOfMoney: anAmountOfMoney

	anAmountOfMoney > 0 ifFalse: [self error: self cannotTransferWithNegativeAmount ] ! !

!Transfer class methodsFor: 'assert' stamp: 'jcm 10/26/2024 21:31:24'!
cannotTransferToItself

	^'Source account and destination account has to be diferrent'! !
