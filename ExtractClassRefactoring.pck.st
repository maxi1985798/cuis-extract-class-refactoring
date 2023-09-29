'From Cuis 6.0 [latest update: #5981] on 29 September 2023 at 1:00:02 am'!
'Description '!
!provides: 'ExtractClassRefactoring' 1 1!
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
	instanceVariableNames: 'sourceClass targetClassName instVarsToExtract methodsToExtract variableToAccessToNewClass sourceClass_CHANGE_ME targetClassName_CHANGE_ME instanceVariableNameForSourceClass instVarToExtract_CHANGE_ME methodsToExtract_CHANGE_ME'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ExtractClassRefactoring'!
!classDefinition: 'ExtractClassRefactoring class' category: 'ExtractClassRefactoring'!
ExtractClassRefactoring class
	instanceVariableNames: ''!


!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/28/2023 00:07:15'!
test001TargetClassShouldNotExist
	
	| targetClassName instVarToExtract sourceClass |
	self createClassNamed: #TargetClass.
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass.
	instVarToExtract := OrderedCollection new.
	
	self
		assertCreation: [ExtractClassRefactoring from: sourceClass to: targetClassName instanceVariableNamed: 'aTargetClass' instVarToExtract: instVarToExtract methodToExtract: OrderedCollection new ] 
		failsWith: [ExtractClassRefactoring targetClassShouldNotExistsErrorMessage].
	! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/28/2023 00:07:15'!
test002InstanceVariableToExtractShouldExists
	
	| targetClassName sourceClass instVarToExtract |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass.
	instVarToExtract := OrderedCollection new.
	instVarToExtract add: 'iv1'.
	
	
	self
		assertCreation: [ExtractClassRefactoring from: sourceClass to: targetClassName instanceVariableNamed: 'aTargetClass' instVarToExtract: instVarToExtract methodToExtract: OrderedCollection new ] 
		failsWith: [ExtractClassRefactoring instanceVariable: 'iv1' shouldExistsOn: 'SourceClass'].
	! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/28/2023 00:07:15'!
test003InstanceVariableToExtractShouldExists
	
	| targetClassName sourceClass instVarToExtract |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	instVarToExtract := OrderedCollection new.
	instVarToExtract add: 'iv1'.
	instVarToExtract add: 'iv2'.
	
	
	self
		assertCreation: [ExtractClassRefactoring from: sourceClass to: targetClassName instanceVariableNamed: 'aTargetClass' instVarToExtract: instVarToExtract methodToExtract: OrderedCollection new ] 
		failsWith: [ExtractClassRefactoring instanceVariable: 'iv2' shouldExistsOn: 'SourceClass'].
	! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/28/2023 00:07:15'!
test004methodToExtractShouldExists
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	methodsToExtract add: #m1.
	
	self
		assertCreation: [ ExtractClassRefactoring from: sourceClass to: targetClassName instanceVariableNamed: 'aTargetClass' instVarToExtract: instVarsToExtract methodToExtract: methodsToExtract ] 
		failsWith: [ExtractClassRefactoring selector: #m1 shouldExistsOn: 'SourceClass'].
	! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/28/2023 00:07:15'!
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
		assertCreation: [ ExtractClassRefactoring from: sourceClass to: targetClassName instanceVariableNamed: 'aTargetClass' instVarToExtract: instVarsToExtract methodToExtract: methodsToExtract ] 
		failsWith: [ExtractClassRefactoring selector: #m2 shouldExistsOn: 'SourceClass'].
	! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/28/2023 00:49:25'!
test006variableToAccessNewClassShouldNotBeInUse
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	
	self
		assertCreation: [ ExtractClassRefactoring from: sourceClass to: targetClassName instanceVariableNamed: 'iv1' instVarToExtract: instVarsToExtract methodToExtract: methodsToExtract ] 
		failsWith: [ExtractClassRefactoring variableToAccessNewClassShouldNotBeInUseErrorMessage].
	! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/28/2023 00:24:59'!
test006variableToAccessNewClassShouldNotBeNil
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	
	self
		assertCreation: [ ExtractClassRefactoring from: sourceClass to: targetClassName instanceVariableNamed: nil instVarToExtract: instVarsToExtract methodToExtract: methodsToExtract ] 
		failsWith: [ExtractClassRefactoring variableToAccessNewClassShouldNotBeNilErrorMessage].
	! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/29/2023 00:57:44'!
test100extractClassWithNoVariablesAndNoMethodShouldOnlyCreateClass
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract refactoring targetClass |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	sourceClass compile: 'm1 ^self.' .
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	
	refactoring := ExtractClassRefactoring 
						from: sourceClass
						to: targetClassName
						instanceVariableNamed: 'aTargetClass'
						instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	targetClass := Smalltalk classNamed: #TargetClass.
	self assert: [ targetClass notNil ].
	self assert: [sourceClass instVarNames includes: 'aTargetClass'].
	self assert: 'initialize
	aTargetClass := TargetClass new.' equals: (sourceClass sourceCodeAt: #initialize).! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/28/2023 00:07:15'!
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
						instanceVariableNamed: 'aTargetClass' instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	self assert: [ (Smalltalk classNamed: #TargetClass) notNil ].
	self assert: 1 equals: (Smalltalk classNamed: #TargetClass) instVarNames size.
	self assert: 'iv1' equals: (Smalltalk classNamed: #TargetClass) instVarNames first.! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/28/2023 00:07:15'!
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
						instanceVariableNamed: 'aTargetClass' instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	self assert: [ (Smalltalk classNamed: #TargetClass) notNil ].
	self assert: 2 equals: (Smalltalk classNamed: #TargetClass) instVarNames size.
	self assert: (Smalltalk classNamed: #TargetClass) instVarNames includes: 'iv1'.
	self assert: (Smalltalk classNamed: #TargetClass) instVarNames includes: 'iv2'.! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 9/28/2023 00:07:15'!
wip_test103GivenMethodAndInstanceVariableWhenExtractClassThenInstanceVariableShouldBeInTargetClass
	
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
						instanceVariableNamed: 'aTargetClass' instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	self assert: [ (Smalltalk classNamed: #TargetClass) notNil ].
	self assert: 1 equals: (Smalltalk classNamed: #TargetClass) instVarNames size.
	self assert: (Smalltalk classNamed: #TargetClass) instVarNames includes: 'iv1'.! !

!ExtractClassRefactoring methodsFor: 'initialization' stamp: 'mc 9/28/2023 00:18:13'!
initializeFrom: aSourceClassName to: aTargetClassName instanceVariableNamed: anInstanceVariableNameForSourceClass instVarToExtract: collectionOfInstVarsToExtract methodToExtract: collectionOfMethodsToExtract  
	sourceClass := aSourceClassName.
	targetClassName := aTargetClassName.
	instVarsToExtract := collectionOfInstVarsToExtract.
	methodsToExtract := collectionOfMethodsToExtract.
	variableToAccessToNewClass := anInstanceVariableNameForSourceClass! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 9/29/2023 00:57:01'!
apply
	Object 
		subclass: targetClassName 
		instanceVariableNames: (instVarsToExtract inject: '' into: [:sum :each | sum , ' ', each])
		classVariableNames: ''
		poolDictionaries: ''
		category: sourceClass category .
	sourceClass addInstVarName: variableToAccessToNewClass.
	sourceClass compile: 'initialize', String newLineString, String tab, variableToAccessToNewClass, ' := ', targetClassName, ' new.'! !

!ExtractClassRefactoring class methodsFor: 'instance creation' stamp: 'mc 9/28/2023 00:53:32'!
from: sourceClass to: targetClassName instanceVariableNamed: anInstanceVariableNameForSourceClass instVarToExtract: instVarToExtract methodToExtract: methodsToExtract  
	
	Smalltalk
		at: targetClassName 
		ifPresent: [ :actualClass | self refactoringError: self targetClassShouldNotExistsErrorMessage. ]
		ifAbsent: [].
	
	(sourceClass instVarNames includesAllOf: instVarToExtract) ifFalse: [ self refactoringError: (self instanceVariable: ((instVarToExtract difference: sourceClass instVarNames) first) shouldExistsOn: sourceClass name) ].
	
	(sourceClass selectors includesAllOf: methodsToExtract) ifFalse: [self refactoringError: ( self selector: ((methodsToExtract difference: sourceClass selectors) first) shouldExistsOn: 'SourceClass' )].
	"self refactoringError: (self selector: methodsToExtract first shouldExistsOn: sourceClass name)."
	anInstanceVariableNameForSourceClass ifNil: [self refactoringError: self variableToAccessNewClassShouldNotBeNilErrorMessage].
	(sourceClass instVarNames includes: anInstanceVariableNameForSourceClass  ) ifTrue: [self refactoringError: self variableToAccessNewClassShouldNotBeInUseErrorMessage].
	
	^self new initializeFrom: sourceClass to: targetClassName instanceVariableNamed: anInstanceVariableNameForSourceClass instVarToExtract: instVarToExtract methodToExtract: methodsToExtract  ! !

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

!ExtractClassRefactoring class methodsFor: 'message handling' stamp: 'mc 9/28/2023 00:54:15'!
variableToAccessNewClassShouldNotBeInUseErrorMessage
	^'variable to access new class should not be in use'! !

!ExtractClassRefactoring class methodsFor: 'message handling' stamp: 'mc 9/28/2023 00:24:04'!
variableToAccessNewClassShouldNotBeNilErrorMessage
	^'variable to access new class should not be nil'! !
