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


!Tests methodsFor: 'tests' stamp: 'JCM 11/16/2024 15:37:20'!
test01ATaskWithTheSameEffortOfItsUniqueDeveloperEndsTheSameDayItStarted

	| task |
	
	task :=  Task 
		named: 'Task A' 
		inResponsabilityOf: self danIngals 
		wantedStart: self startDate
		effortNeeded: (8 * hour) 
		neededTasks: OrderedCollection new.
		
	self assert: task endingDate equals: November/16/2024.! !

!Tests methodsFor: 'tests' stamp: 'JCM 11/16/2024 15:36:48'!
test02ATaskWithTheMoreNeededEffortOfItsUniqueDeveloperEndsADifferentDay

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

!Tests methodsFor: 'tests' stamp: 'JCM 11/16/2024 14:43:24'!
test04ATaskWithDependentTaskCannotBegginIfTheDependentDoesntFinish

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

!Tests methodsFor: 'tests' stamp: 'JCM 11/16/2024 16:32:46'!
test09AWorkSheetKnowsTheDaysADeveloperIsOverallocated

	| proyect developerA developerB task1 taskB proyect2 worksheet teamB danIngalsOverallocation |
	
	developerA := self danIngals.
	developerB := self alanKay .
	
	teamB := Team named: 'TeamB' conformedBy: (OrderedCollection with: developerA with: developerB).
	
	task1 := Task 
		named: 'Tarea A' 
		inResponsabilityOf: developerA
		wantedStart: November/16/2024 
		effortNeeded: (8 * hour)
		neededTasks: OrderedCollection new.
		
	taskB := Task 
		named: 'Tarea A' 
		inResponsabilityOf: teamB 
		wantedStart: November/16/2024 
		effortNeeded: (16 * hour) 
		neededTasks: OrderedCollection new.
		
	proyect2 := Project named: 'Proyecto 2' with: (OrderedCollection with:task1 with: taskB).
	
	proyect := Project named: 'Proyecto 1' with: (OrderedCollection with: proyect2).
	
	worksheet := Worksheet for: proyect.
	
	danIngalsOverallocation := OrderedCollection new.
	danIngalsOverallocation add: November/16/2024.
	
	self assert: (worksheet overallocationOf: self danIngals) equals: (danIngalsOverallocation).
	
	
	! !


!classDefinition: #Developer category: #'Parcial2024-2C'!
Object subclass: #Developer
	instanceVariableNames: 'name dedication cost'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2024-2C'!

!Developer methodsFor: 'time to complete' stamp: 'JCM 11/16/2024 13:57:05'!
neededTimeToCompleteTask: timeToComplete.
	
	^(timeToComplete / dedication) ceiling.! !


!Developer methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 12:09:37'!
initializeNamed: developersName dedicates: dedicationTime costs: costOfDeveloper 
	
	name := developersName.
	dedication:= dedicationTime.
	cost := costOfDeveloper.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Developer class' category: #'Parcial2024-2C'!
Developer class
	instanceVariableNames: ''!

!Developer class methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 12:08:51'!
named: developersName dedicates: dedicationTime costs: costOfDeveloper 
	
	^self new initializeNamed: developersName dedicates: dedicationTime costs: costOfDeveloper ! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Project class' category: #'Parcial2024-2C'!
Project class
	instanceVariableNames: ''!

!Project class methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 15:11:27'!
named: aProyectsName with: aTask
	
	^self new initializeNamed: aProyectsName with: aTask.! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Task class' category: #'Parcial2024-2C'!
Task class
	instanceVariableNames: ''!

!Task class methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 12:11:36'!
named: aTaskName inResponsabilityOf: developers wantedStart: astartDate effortNeeded: timeToCompleteTask neededTasks: aDependedTasks
	
	^self new initializeNamed: aTaskName inResponsabilityOf: developers wantedStart: astartDate effortNeeded: timeToCompleteTask neededTasks: aDependedTasks ! !


!classDefinition: #Team category: #'Parcial2024-2C'!
Object subclass: #Team
	instanceVariableNames: 'teamsName effort members'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2024-2C'!

!Team methodsFor: 'needed time' stamp: 'JCM 11/16/2024 14:54:16'!
neededTimeToCompleteTask: timeToCompleteTask

	^members max:[:developer | developer neededTimeToCompleteTask: timeToCompleteTask]! !


!Team methodsFor: 'initialization' stamp: 'JCM 11/16/2024 14:49:16'!
initializeNamed: aTeamsName conformedBy: membersOfTheTeam

	teamsName := aTeamsName.
	members := membersOfTheTeam .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Team class' category: #'Parcial2024-2C'!
Team class
	instanceVariableNames: ''!

!Team class methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 14:44:06'!
named: aTeamsName conformedBy: developers
	
	^self new initializeNamed: aTeamsName conformedBy: developers ! !


!classDefinition: #Worksheet category: #'Parcial2024-2C'!
Object subclass: #Worksheet
	instanceVariableNames: 'proyect developersData'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial2024-2C'!

!Worksheet methodsFor: 'overallocation' stamp: 'JCM 11/16/2024 16:33:07'!
overallocationOf: aDeveloper! !

!Worksheet methodsFor: 'overallocation' stamp: 'JCM 11/16/2024 16:13:14'!
proyectHasOverallocations

	

	! !


!Worksheet methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 16:13:10'!
initializeFor: aProyect 
	
	proyect := aProyect.
	developersData := Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Worksheet class' category: #'Parcial2024-2C'!
Worksheet class
	instanceVariableNames: ''!

!Worksheet class methodsFor: 'instance creation' stamp: 'JCM 11/16/2024 16:10:39'!
for: aProyect 
	
	^self new initializeFor: aProyect ! !
