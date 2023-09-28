'From Cuis 6.0 [latest update: #5981] on 27 September 2023 at 10:40:56 pm'!
'Description '!
!provides: 'ExtractClassRefactoring' 1 0!
SystemOrganization addCategory: 'ExtractClassRefactoring'!


!classDefinition: #ExtractClassRefactoringTest category: 'ExtractClassRefactoring'!
RefactoringTest subclass: #ExtractClassRefactoringTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ExtractClassRefactoring'!
!classDefinition: 'ExtractClassRefactoringTest class' category: 'ExtractClassRefactoring'!
ExtractClassRefactoringTest class
	instanceVariableNames: ''!

!classDefinition: #ExtractClassRefactoring category: 'ExtractClassRefactoring'!
Refactoring subclass: #ExtractClassRefactoring
	instanceVariableNames: 'sourceClass targetClassName instVarsToExtract methodsToExtract'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ExtractClassRefactoring'!
!classDefinition: 'ExtractClassRefactoring class' category: 'ExtractClassRefactoring'!
ExtractClassRefactoring class
	instanceVariableNames: ''!


!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/23/2023 18:53:34'!
test001TargetClassShouldNotExist
	
	| targetClassName instVarToExtract sourceClass |
	self createClassNamed: #TargetClass.
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass.
	instVarToExtract := OrderedCollection new.
	
	self
		assertCreation: [ExtractClassRefactoring from: sourceClass to: targetClassName instVarToExtract: instVarToExtract methodToExtract: OrderedCollection new ] 
		failsWith: [ExtractClassRefactoring targetClassShouldNotExistsErrorMessage].
	! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/21/2023 01:09:09'!
test002InstanceVariableToExtractShouldExists
	
	| targetClassName sourceClass instVarToExtract |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass.
	instVarToExtract := OrderedCollection new.
	instVarToExtract add: 'iv1'.
	
	
	self
		assertCreation: [ExtractClassRefactoring from: sourceClass to: targetClassName instVarToExtract: instVarToExtract methodToExtract: OrderedCollection new ] 
		failsWith: [ExtractClassRefactoring instanceVariable: 'iv1' shouldExistsOn: 'SourceClass'].
	! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/21/2023 01:09:09'!
test003InstanceVariableToExtractShouldExists
	
	| targetClassName sourceClass instVarToExtract |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	instVarToExtract := OrderedCollection new.
	instVarToExtract add: 'iv1'.
	instVarToExtract add: 'iv2'.
	
	
	self
		assertCreation: [ExtractClassRefactoring from: sourceClass to: targetClassName instVarToExtract: instVarToExtract methodToExtract: OrderedCollection new ] 
		failsWith: [ExtractClassRefactoring instanceVariable: 'iv2' shouldExistsOn: 'SourceClass'].
	! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/21/2023 01:11:50'!
test004methodToExtractShouldExists
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	methodsToExtract add: #m1.
	
	self
		assertCreation: [ ExtractClassRefactoring from: sourceClass to: targetClassName instVarToExtract: instVarsToExtract methodToExtract: methodsToExtract ] 
		failsWith: [ExtractClassRefactoring selector: #m1 shouldExistsOn: 'SourceClass'].
	! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/21/2023 23:31:45'!
test005methodToExtractShouldExists
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	sourceClass compile: 'm1 ^self.' .
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	methodsToExtract add: #m1.
	methodsToExtract add: #m2.
	
	self
		assertCreation: [ ExtractClassRefactoring from: sourceClass to: targetClassName instVarToExtract: instVarsToExtract methodToExtract: methodsToExtract ] 
		failsWith: [ExtractClassRefactoring selector: #m2 shouldExistsOn: 'SourceClass'].
	! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/24/2023 03:02:16'!
test100extractClassWithNoVariablesAndNoMethodShouldOnlyCreateClass
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract refactoring |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	sourceClass compile: 'm1 ^self.' .
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	
	refactoring := ExtractClassRefactoring 
						from: sourceClass
						to: targetClassName
						instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	self assert: [(Smalltalk classNamed: #TargetClass) notNil ]! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/26/2023 00:36:26'!
test101GivenSourceClassAndOneInstanceVariableWhenExtractClassThenInstanceVariableShouldBeInTargetClass
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract refactoring |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	instVarsToExtract add: 'iv1'.
	
	refactoring := ExtractClassRefactoring 
						from: sourceClass
						to: targetClassName
						instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	self assert: [ (Smalltalk classNamed: #TargetClass) notNil ].
	self assert: 1 equals: (Smalltalk classNamed: #TargetClass) instVarNames size.
	self assert: 'iv1' equals: (Smalltalk classNamed: #TargetClass) instVarNames first.! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/26/2023 23:33:50'!
test102GivenSourceClassAndTwoInstanceVariableWhenExtractClassThenInstanceVariableShouldBeInTargetClass
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract refactoring |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1 iv2'.
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	instVarsToExtract add: 'iv1'.
	instVarsToExtract add: 'iv2'.
	
	refactoring := ExtractClassRefactoring 
						from: sourceClass
						to: targetClassName
						instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	self assert: [ (Smalltalk classNamed: #TargetClass) notNil ].
	self assert: 2 equals: (Smalltalk classNamed: #TargetClass) instVarNames size.
	self assert: (Smalltalk classNamed: #TargetClass) instVarNames includes: 'iv1'.
	self assert: (Smalltalk classNamed: #TargetClass) instVarNames includes: 'iv2'.! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/27/2023 00:36:24'!
test103GivenMethodAndInstanceVariableWhenExtractClassThenInstanceVariableShouldBeInTargetClass
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract refactoring |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	instVarsToExtract add: 'iv1'.
	sourceClass compile: 'm1 ^iv1+1.' .
	
	refactoring := ExtractClassRefactoring 
						from: sourceClass
						to: targetClassName
						instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	self assert: [ (Smalltalk classNamed: #TargetClass) notNil ].
	self assert: 1 equals: (Smalltalk classNamed: #TargetClass) instVarNames size.
	self assert: (Smalltalk classNamed: #TargetClass) instVarNames includes: 'iv1'.! !

!ExtractClassRefactoring methodsFor: 'initialization' stamp: 'mc 9/24/2023 03:09:26'!
initializeFrom: aSourceClassName to: aTargetClassName instVarToExtract: collectionOfInstVarsToExtract methodToExtract: collectionOfMethodsToExtract 
	sourceClass := aSourceClassName.
	targetClassName := aTargetClassName.
	instVarsToExtract := collectionOfInstVarsToExtract.
	methodsToExtract := collectionOfMethodsToExtract.! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 9/26/2023 23:34:38'!
apply
	Object 
		subclass: targetClassName 
		instanceVariableNames: (instVarsToExtract inject: '' into: [:sum :each | sum , ' ', each])
		classVariableNames: ''
		poolDictionaries: ''
		category: sourceClass category .! !

!ExtractClassRefactoring class methodsFor: 'instance creation' stamp: 'mc 9/24/2023 03:03:46'!
from: sourceClass to: targetClassName instVarToExtract: instVarToExtract methodToExtract: methodsToExtract  
	
	Smalltalk
		at: targetClassName 
		ifPresent: [ :actualClass | self refactoringError: self targetClassShouldNotExistsErrorMessage. ]
		ifAbsent: [].
	
	(sourceClass instVarNames includesAllOf: instVarToExtract) ifFalse: [ self refactoringError: (self instanceVariable: ((instVarToExtract difference: sourceClass instVarNames) first) shouldExistsOn: sourceClass name) ].
	
	(sourceClass selectors includesAllOf: methodsToExtract) ifFalse: [self refactoringError: ( self selector: ((methodsToExtract difference: sourceClass selectors) first) shouldExistsOn: 'SourceClass' )].
	"self refactoringError: (self selector: methodsToExtract first shouldExistsOn: sourceClass name)."
	^self new initializeFrom: sourceClass to: targetClassName instVarToExtract: instVarToExtract methodToExtract: methodsToExtract  ! !

!ExtractClassRefactoring class methodsFor: 'message handling' stamp: 'mc 9/21/2023 00:47:54'!
instanceVariable: anInsVarName shouldExistsOn: aClassName 
	^'instance variable ', anInsVarName, ' should exists on ', aClassName! !

!ExtractClassRefactoring class methodsFor: 'message handling' stamp: 'mc 9/21/2023 00:34:28'!
instanceVariableToExtractShouldExistsOnSourceClass
	^'instance variable to extract should exists on source class'.! !

!ExtractClassRefactoring class methodsFor: 'message handling' stamp: 'mc 9/21/2023 01:14:52'!
selector: aSelector shouldExistsOn: aClassName 
	^'selector ', aSelector, ' should exists on ', aClassName! !

!ExtractClassRefactoring class methodsFor: 'message handling' stamp: 'mc 9/18/2023 23:19:13'!
targetClassShouldNotExistsErrorMessage
	^'Target class should not exists'! !
