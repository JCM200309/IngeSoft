!classDefinition: #Tests category: #'Parcial2024-2C'!
TestCase subclass: #Tests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2024-2C'!

!Tests methodsFor: 'developers' stamp: 'JCM 11/16/2024 13:08:50'!
alanKay

	^Developer named: 'Alan Kay' dedicates: (6 * hour) / day costs: 80*dollar / hour! !

!Tests methodsFor: 'developers' stamp: 'JCM 11/16/2024 13:07:36'!
danIngals

	^Developer named: 'Dan Ingalls' dedicates: (8 * hour) / day costs: 60*dollar / hour.! !

!Tests methodsFor: 'developers' stamp: 'JCM 11/16/2024 15:36:05'!
startDate

	^November/16/2024.! !

!Tests methodsFor: 'developers' stamp: 'JCM 11/16/2024 15:35:31'!
taskA

	^Task 
		named: 'Task A' 
		inResponsabilityOf: self danIngals
		wantedStart: self startDate 
		effortNeeded: (8 * hour)
		neededTasks: OrderedCollection new.! !


!Tests methodsFor: 'tests' stamp: 'JCM 11/18/2024 16:08:21'!
test01ATaskWithTheSameEffortOfItsUniqueDeveloperEndsTheSameDayItStarted

	| task |
	
	task :=  Task 
		named: 'Task A' 
		inResponsabilityOf: self danIngals 
		wantedStart: self startDate
		effortNeeded: (8 * hour) 
		neededTasks: OrderedCollection new.
		
	self assert: task endingDate equals: self startDate .! !

!Tests methodsFor: 'tests' stamp: 'JCM 11/18/2024 16:11:28'!
test02ATaskWithWithMoreNeededEffortThanThanTheEffortOfItsUniqueDevelopersEndsADifferentDay

	| task |
		
	task := Task 
		named: 'Task A' 
		inResponsabilityOf: self danIngals 
		wantedStart: self startDate
		effortNeeded: (9 * hour) 
		neededTasks: OrderedCollection new.
		
	self assert: task endingDate equals: November/17/2024.! !

!Tests methodsFor: 'tests' stamp: 'JCM 11/16/2024 14:52:40'!
test03ATaskWithMoreThanOneDeveloperEndsWithTheSlowestDevelopersTime

	| developerA startDate task developerB teamOfDevelopers team1 |
	
	developerA := self danIngals .
	developerB := self alanKay .
	
	team1 := Team named: 'TeamA' conformedBy: (OrderedCollection with: developerA with:developerB).
	
	teamOfDevelopers := OrderedCollection new.
	teamOfDevelopers add: developerA.
	teamOfDevelopers add: developerB.
	
	startDate := November/16/2024.
	
	task := Task 
		named: 'Tarea A' 
		inResponsabilityOf: team1
		wantedStart: startDate 
		effortNeeded: (8 * hour) 
		neededTasks: OrderedCollection new.
		
	self assert: task endingDate equals: November/17/2024.! !

!Tests methodsFor: 'tests' stamp: 'JCM 11/18/2024 16:30:08'!
test04ATaskWithDependentTasksBegginsWhenTheOtherFinish

	| developerA startDate developerB taskA taskB taskC team1 |
	
	developerA := self danIngals .
	developerB := self alanKay .
	
	team1:=Team named: 'Team1' conformedBy: (OrderedCollection with: developerA with:developerB).
	
	startDate := November/16/2024.
	
	taskA := Task 
		named: 'Tarea A' 
		inResponsabilityOf: team1 
		wantedStart: startDate 
		effortNeeded: (8 * hour) 
		neededTasks: OrderedCollection new.
	
	taskB := Task 
		named: 'Tarea A' 
		inResponsabilityOf: team1 
		wantedStart: startDate 
		effortNeeded: (16 * hour) 
		neededTasks: OrderedCollection new.

	taskC := Task 
		named: 'Tarea A' 
		inResponsabilityOf: team1 
		wantedStart: startDate 
		effortNeeded: (16 * hour) 
		neededTasks: (OrderedCollection with: taskA with: taskB).
	
	self assert: taskC beggingDate equals: (November/19/2024).
	self assert: taskC endingDate equals: November/21/2024.! !

!Tests methodsFor: 'tests' stamp: 'JCM 11/16/2024 15:30:44'!
test05AnProyectWithOneTaskBegginsTheSameDayAsTheTaskDoes

	| proyect developerA startDate task |
	
	developerA := self danIngals.
	startDate := November/16/2024.
	
	task := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerA
		wantedStart: startDate 
		effortNeeded: (8 * hour)
		neededTasks: OrderedCollection new.
	
	proyect := Project named: 'Proyecto 1' with: (OrderedCollection with: task).
		
	self assert: proyect beggingDate equals: November/16/2024.
	! !

!Tests methodsFor: 'tests' stamp: 'JCM 11/16/2024 15:30:32'!
test06AnProyectWithOneTaskEndsTheSameDayAsTheTaskDoes

	| proyect developerA startDate task |
	
	developerA := self danIngals.
	startDate := November/16/2024.
	
	task := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerA
		wantedStart: startDate 
		effortNeeded: (8 * hour)
		neededTasks: OrderedCollection new.
	
	proyect := Project named: 'Proyecto 1' with: (OrderedCollection with: task).
		
	self assert: proyect endingDate equals: task endingDate.
	! !

!Tests methodsFor: 'tests' stamp: 'JCM 11/16/2024 15:24:44'!
test07AProyectWithMoreThanOneTasksBegginsTheEarliestBegginingTaskDate

	| proyect developerA developerB task1 taskB |
	
	developerA := self danIngals.
	developerB := self alanKay .
	
	
	task1 := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerA
		wantedStart: November/16/2024 
		effortNeeded: (8 * hour)
		neededTasks: OrderedCollection new.
		
	taskB := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerB 
		wantedStart: November/20/2024 
		effortNeeded: (16 * hour) 
		neededTasks: OrderedCollection new.
	
	proyect := Project named: 'Proyecto 1' with: (OrderedCollection with: task1 with: taskB).
		
	self assert: proyect beggingDate equals: November/16/2024.
	! !

!Tests methodsFor: 'tests' stamp: 'JCM 11/16/2024 15:33:31'!
test08AProyectWithMoreThanOneTasksEndsTheFarthestBegginingTaskDate

	| proyect developerA developerB task1 taskB |
	
	developerA := self danIngals.
	developerB := self alanKay .
	
	
	task1 := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerA
		wantedStart: November/16/2024 
		effortNeeded: (8 * hour)
		neededTasks: OrderedCollection new.
		
	taskB := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerB 
		wantedStart: November/20/2024 
		effortNeeded: (16 * hour) 
		neededTasks: OrderedCollection new.
	
	proyect := Project named: 'Proyecto 1' with: (OrderedCollection with: task1 with: taskB).
		
	self assert: proyect endingDate equals: November/22/2024.
	! !

!Tests methodsFor: 'tests' stamp: 'JCM 11/18/2024 18:20:26'!
test09AWorkSheetKnowsTheDatesADeveloperIsOverllocated

	| proyect developerA task1 taskB worksheet danIngalsOverallocation overAllocationsOfDanIngals |
	
	developerA := self danIngals.
		
	task1 := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerA
		wantedStart: November/16/2024 
		effortNeeded: (8 * hour)
		neededTasks: OrderedCollection new.
		
	taskB := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerA 
		wantedStart: November/16/2024 
		effortNeeded: (16 * hour) 
		neededTasks: OrderedCollection new.
	
	proyect := Project named: 'Proyecto 1' with: (OrderedCollection with:task1 with: taskB).
	
	worksheet := Worksheet for: proyect.
	
	danIngalsOverallocation := OrderedCollection new.
	danIngalsOverallocation add: November/16/2024.
	
	worksheet lookForOverallocation.
	
	overAllocationsOfDanIngals := worksheet overallocationOf: 'Dan Ingalls'.
	
	self assert: overAllocationsOfDanIngals size = 2.
	self assert: (overAllocationsOfDanIngals occurrencesOf: November/16/2024) equals: 2
	
	
	! !

!Tests methodsFor: 'tests' stamp: 'JCM 11/18/2024 18:18:47'!
test10ATeamThatAreResponsableOfTheSameTwoTasksHaveEqualOverallocation

	| proyect developerA task1 taskB worksheet developerB team overAllocationsOfAlanKay overAllocationsOfDanIngalls |
	
	developerA := self danIngals.
	developerB := self alanKay.
	
	team := Team named: 'Team A' conformedBy: (OrderedCollection with: developerA with:developerB).
		
	task1 := Task 
		named: 'Tarea A' 
		inResponsabilityOf: team
		wantedStart: November/16/2024 
		effortNeeded: (12 * hour)
		neededTasks: OrderedCollection new.
		
	taskB := Task 
		named: 'Tarea A' 
		inResponsabilityOf: team 
		wantedStart: November/16/2024 
		effortNeeded: (16 * hour) 
		neededTasks: OrderedCollection new.
	
	proyect := Project named: 'Proyecto 1' with: (OrderedCollection with:task1 with: taskB).
	
	worksheet := Worksheet for: proyect.
	
	worksheet lookForOverallocation.
	
	overAllocationsOfDanIngalls := worksheet overallocationOf: 'Dan Ingalls'.
	overAllocationsOfAlanKay := worksheet overallocationOf: 'Alan Kay'.
	
	self assert: overAllocationsOfDanIngalls size = 4.
	self assert: (overAllocationsOfDanIngalls occurrencesOf: November/16/2024) equals: 2.
	self assert: (overAllocationsOfDanIngalls occurrencesOf: November/17/2024) equals: 2.
	self assert: (overAllocationsOfAlanKay = overAllocationsOfDanIngalls )
	
	
	
	! !

!Tests methodsFor: 'tests' stamp: 'JCM 11/18/2024 18:23:19'!
test11ANotOverallocatedDeveloperDoesNotAppearInTheWorksheetAsOverallocated

	| proyect developerA task1 taskB worksheet developerB overAllocationsOfDanIngalls |
	
	"Este en realidad tendria que ser el test 10"
	
	developerA := self danIngals.
	developerB := self alanKay.
	
	task1 := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerA 
		wantedStart: November/16/2024 
		effortNeeded: (12 * hour)
		neededTasks: OrderedCollection new.
		
	taskB := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerB 
		wantedStart: November/16/2024 
		effortNeeded: (16 * hour) 
		neededTasks: OrderedCollection new.
	
	proyect := Project named: 'Proyecto 1' with: (OrderedCollection with:task1 with: taskB).
	
	worksheet := Worksheet for: proyect.
	
	worksheet lookForOverallocation.
	
	overAllocationsOfDanIngalls := worksheet overallocationOf: 'Dan Ingalls'.
	
	self assert: overAllocationsOfDanIngalls isEmpty 
	
	
	
	
	
	
	! !

!Tests methodsFor: 'tests' stamp: 'JCM 11/18/2024 18:33:20'!
test12AWorksheetKnowsIfAProjectWithOverallocationsIsNotOverallocated

	| proyect developerA task1 taskB worksheet developerB |
	
	developerA := self danIngals.
	developerB := self alanKay.
	
	
	task1 := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerA
		wantedStart: November/16/2024 
		effortNeeded: (12 * hour)
		neededTasks: OrderedCollection new.
		
	taskB := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerB 
		wantedStart: November/16/2024 
		effortNeeded: (16 * hour) 
		neededTasks: OrderedCollection new.
	
	proyect := Project named: 'Proyecto 1' with: (OrderedCollection with:task1 with: taskB).
	
	worksheet := Worksheet for: proyect.
	
	worksheet lookForOverallocation.
	
	self deny: (worksheet hasOverallocatedProject)
	
	
	
	
	
	! !

!Tests methodsFor: 'tests' stamp: 'JCM 11/18/2024 20:47:05'!
test13AWorksheetKnowsIfAProjectWithOverallocationsIsOverallocated

	| proyect developerA task1 taskB worksheet developerB team |
	
	developerA := self danIngals.
	developerB := self alanKay.
	
	team := Team named: 'Team A' conformedBy: (OrderedCollection with: developerA with:developerB).
		
	task1 := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerA
		wantedStart: November/16/2024 
		effortNeeded: (12 * hour)
		neededTasks: OrderedCollection new.
		
	taskB := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerA 
		wantedStart: November/16/2024 
		effortNeeded: (16 * hour) 
		neededTasks: OrderedCollection new.
	
	proyect := Project named: 'Proyecto 1' with: (OrderedCollection with:task1 with: taskB).
	
	worksheet := Worksheet for: proyect.
	
	worksheet lookForOverallocation.
	
	self assert: (worksheet hasOverallocatedProject)
	
	
	
	
	
	! !


!classDefinition: #Project category: #'Parcial2024-2C'!
Object subclass: #Project
	instanceVariableNames: 'name tasks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2024-2C'!

!Project methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 15:38:21'!
initializeNamed: aProyectsName with: projectTasks
	
	name := aProyectsName.
	tasks := projectTasks.! !


!Project methodsFor: 'time' stamp: 'JCM 11/16/2024 15:29:41'!
beggingDate
	
	"violo encapsulamiento"
	
	^tasks min:[:task | task startDate]

	! !

!Project methodsFor: 'time' stamp: 'JCM 11/16/2024 15:34:04'!
endingDate
	
	^tasks max:[:task | task endingDate]! !


!Project methodsFor: 'overallocation' stamp: 'JCM 11/18/2024 17:32:55'!
lookForOverallocationIn: aWorksheet 
	
	^tasks do: [:task | task lookForOverallocationIn: aWorksheet]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Project class' category: #'Parcial2024-2C'!
Project class
	instanceVariableNames: ''!

!Project class methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 15:11:27'!
named: aProyectsName with: aTask
	
	^self new initializeNamed: aProyectsName with: aTask.! !


!classDefinition: #Responsables category: #'Parcial2024-2C'!
Object subclass: #Responsables
	instanceVariableNames: 'name effort'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2024-2C'!

!Responsables methodsFor: 'overallocation' stamp: 'JCM 11/18/2024 20:42:37'!
registerWorkingDatesIn: aWorksheet between: aBeggingDate and: anEndingDate

	self subclassResponsibility! !


!Responsables methodsFor: 'instance creation' stamp: 'JCM 11/18/2024 20:42:43'!
initializeNamed: developersName dedicates: dedicationTime costs: costOfDeveloper

	self subclassResponsibility! !


!Responsables methodsFor: 'time to complete' stamp: 'JCM 11/18/2024 20:42:48'!
neededTimeToCompleteTask: timeToComplete

	self subclassResponsibility! !


!classDefinition: #Developer category: #'Parcial2024-2C'!
Responsables subclass: #Developer
	instanceVariableNames: 'cost'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2024-2C'!

!Developer methodsFor: 'time to complete' stamp: 'JCM 11/18/2024 20:42:18'!
neededTimeToCompleteTask: timeToComplete.
	
	^(timeToComplete / effort) ceiling.! !


!Developer methodsFor: 'instance creation' stamp: 'JCM 11/18/2024 20:44:14'!
initializeNamed: developersName dedicates: dedicationTime costs: costOfDeveloper 
	
	name := developersName.
	effort := dedicationTime.
	cost := costOfDeveloper.! !


!Developer methodsFor: 'overallocation' stamp: 'JCM 11/18/2024 17:33:48'!
registerWorkingDatesIn: aWorksheet between: aBeggingDate and: anEndingDate 
	
	^aWorksheet registerWorkingDatesIn: name between: aBeggingDate and: anEndingDate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Developer class' category: #'Parcial2024-2C'!
Developer class
	instanceVariableNames: ''!

!Developer class methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 12:08:51'!
named: developersName dedicates: dedicationTime costs: costOfDeveloper 
	
	^self new initializeNamed: developersName dedicates: dedicationTime costs: costOfDeveloper ! !


!classDefinition: #Team category: #'Parcial2024-2C'!
Responsables subclass: #Team
	instanceVariableNames: 'members'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2024-2C'!

!Team methodsFor: 'needed time' stamp: 'JCM 11/16/2024 14:54:16'!
neededTimeToCompleteTask: timeToCompleteTask

	^members max:[:developer | developer neededTimeToCompleteTask: timeToCompleteTask]! !


!Team methodsFor: 'initialization' stamp: 'JCM 11/18/2024 20:41:41'!
initializeNamed: aTeamsName conformedBy: membersOfTheTeam

	name := aTeamsName.
	members := membersOfTheTeam .! !


!Team methodsFor: 'overallocation' stamp: 'JCM 11/18/2024 18:10:51'!
registerWorkingDatesIn: aWorksheet between: aBeggingDate and: anEndingDate 
	
	^members do: [:developer | developer registerWorkingDatesIn: aWorksheet between: aBeggingDate and: anEndingDate]
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Team class' category: #'Parcial2024-2C'!
Team class
	instanceVariableNames: ''!

!Team class methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 14:44:06'!
named: aTeamsName conformedBy: developers
	
	^self new initializeNamed: aTeamsName conformedBy: developers ! !


!classDefinition: #Task category: #'Parcial2024-2C'!
Object subclass: #Task
	instanceVariableNames: 'name dependedTasks developersInCharge startDate timeToComplete'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2024-2C'!

!Task methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 13:24:19'!
initializeNamed: aTaskName inResponsabilityOf: developers wantedStart: astartDate effortNeeded: timeToCompleteTask neededTasks: aDependedTasks 
	
	name := aTaskName.
	developersInCharge := developers.
	startDate := astartDate.
	timeToComplete := timeToCompleteTask.
	dependedTasks := aDependedTasks.! !


!Task methodsFor: 'time' stamp: 'JCM 11/16/2024 14:54:21'!
endingDate
	
	| neededTime neededTaskTime |
	
	"Estoy rompiendo encapsulamiento creo ya que detectMax me devulve el maximo developer"
	neededTaskTime := self neededTaskTime.
	
	neededTime := (developersInCharge neededTimeToCompleteTask: timeToComplete ).
	
	^(neededTaskTime next: neededTime) previous
	
	
	
	! !

!Task methodsFor: 'time' stamp: 'JCM 11/16/2024 14:16:28'!
neededTaskTime
	
	"TodoMejorar codigo"
	
	^dependedTasks ifEmpty: [^startDate] ifNotEmpty:[^(dependedTasks max:[:aTask | aTask endingDate]) next]
	
	
	
	! !

!Task methodsFor: 'time' stamp: 'JCM 11/16/2024 15:40:47'!
startDate
	
	^startDate 
	
	
	
	! !


!Task methodsFor: 'as yet unclassified' stamp: 'JCM 11/18/2024 16:30:44'!
beggingDate
	
	dependedTasks ifEmpty:[^startDate] ifNotEmpty: [^(dependedTasks max:[:task | task endingDate]) next ]! !


!Task methodsFor: 'overallocation' stamp: 'JCM 11/18/2024 17:33:31'!
lookForOverallocationIn: aWorksheet 
	
	
	^developersInCharge registerWorkingDatesIn: aWorksheet between: self beggingDate and: self endingDate 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Task class' category: #'Parcial2024-2C'!
Task class
	instanceVariableNames: ''!

!Task class methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 12:11:36'!
named: aTaskName inResponsabilityOf: developers wantedStart: astartDate effortNeeded: timeToCompleteTask neededTasks: aDependedTasks
	
	^self new initializeNamed: aTaskName inResponsabilityOf: developers wantedStart: astartDate effortNeeded: timeToCompleteTask neededTasks: aDependedTasks ! !


!classDefinition: #Worksheet category: #'Parcial2024-2C'!
Object subclass: #Worksheet
	instanceVariableNames: 'proyect developersData workingDaysDevelopers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2024-2C'!

!Worksheet methodsFor: 'overallocation' stamp: 'JCM 11/18/2024 17:42:50'!
addWorkingDaysIn: aCollectionOfWorkingDates between: aBeggingDate and: anEndingDate 
	
	| currentDay |
	
	currentDay := aBeggingDate.
	
	[currentDay <= anEndingDate] whileTrue: [aCollectionOfWorkingDates add: currentDay. currentDay := currentDay next].

	
	^aCollectionOfWorkingDates ! !

!Worksheet methodsFor: 'overallocation' stamp: 'JCM 11/18/2024 20:45:13'!
hasOverallocatedProject
	
	
	workingDaysDevelopers valuesDo: [:developersWorkingsDays | 
		(developersWorkingsDays anySatisfy: [:date | 
			((developersWorkingsDays occurrencesOf: date) > 1)]) ifTrue: [^true]].
	
	^false! !

!Worksheet methodsFor: 'overallocation' stamp: 'JCM 11/18/2024 17:32:26'!
lookForOverallocation

	workingDaysDevelopers := Dictionary new.
	
	^proyect lookForOverallocationIn: self.! !

!Worksheet methodsFor: 'overallocation' stamp: 'JCM 11/18/2024 18:05:23'!
overallocationOf: aDeveloper
	
	| workingDaysOfDeveloper |
	workingDaysOfDeveloper := workingDaysDevelopers at: aDeveloper.
	^workingDaysOfDeveloper select:[:dates | (workingDaysOfDeveloper occurrencesOf: dates) > 1]! !


!Worksheet methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 16:13:10'!
initializeFor: aProyect 
	
	proyect := aProyect.
	developersData := Dictionary new.! !


!Worksheet methodsFor: 'registration' stamp: 'JCM 11/18/2024 17:43:42'!
registerWorkingDatesIn: aDeveloper between: aBeggingDate and: anEndingDate 
	
	workingDaysDevelopers at:aDeveloper 
		ifPresent:[:value | self addWorkingDaysIn: value between: aBeggingDate and: anEndingDate ] 
		ifAbsent:[workingDaysDevelopers at: aDeveloper put: (self addWorkingDaysIn: Bag new between: aBeggingDate and: anEndingDate )].
		
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Worksheet class' category: #'Parcial2024-2C'!
Worksheet class
	instanceVariableNames: ''!

!Worksheet class methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 16:10:39'!
for: aProyect 
	
	^self new initializeFor: aProyect ! !
