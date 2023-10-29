'From Cuis 6.0 [latest update: #5981] on 29 October 2023 at 3:37:41 pm'!
'Description '!
!provides: 'ExtractClassRefactoring' 1 5!
SystemOrganization addCategory: 'ExtractClassRefactoring'!


!classDefinition: #CodeExtractorWithoutTemporariesVisitor category: 'ExtractClassRefactoring'!
ParseNodeVisitor subclass: #CodeExtractorWithoutTemporariesVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ExtractClassRefactoring'!
!classDefinition: 'CodeExtractorWithoutTemporariesVisitor class' category: 'ExtractClassRefactoring'!
CodeExtractorWithoutTemporariesVisitor class
	instanceVariableNames: ''!

!classDefinition: #ExtractClassForm category: 'ExtractClassRefactoring'!
SystemWindow subclass: #ExtractClassForm
	instanceVariableNames: 'scrollPane formLayout newClassNameSection messageSendingListSection actionButtonsSection messageListModel introduceNullObjectRequest instanceVariableListSection instanceVariableListModel newClassNameModel variableNameToAccessNewClassModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ExtractClassRefactoring'!
!classDefinition: 'ExtractClassForm class' category: 'ExtractClassRefactoring'!
ExtractClassForm class
	instanceVariableNames: ''!

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
	instanceVariableNames: 'sourceClass targetClassName instVarsToExtract methodsToExtract variableToAccessToNewClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ExtractClassRefactoring'!
!classDefinition: 'ExtractClassRefactoring class' category: 'ExtractClassRefactoring'!
ExtractClassRefactoring class
	instanceVariableNames: ''!

!classDefinition: #ExtractClassApplier category: 'ExtractClassRefactoring'!
RefactoringApplier subclass: #ExtractClassApplier
	instanceVariableNames: 'class classToRefactor form extractClassRequest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ExtractClassRefactoring'!
!classDefinition: 'ExtractClassApplier class' category: 'ExtractClassRefactoring'!
ExtractClassApplier class
	instanceVariableNames: ''!

!classDefinition: #ClassAllInstanceVariableListModel category: 'ExtractClassRefactoring'!
Object subclass: #ClassAllInstanceVariableListModel
	instanceVariableNames: 'extractClassForm index list'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ExtractClassRefactoring'!
!classDefinition: 'ClassAllInstanceVariableListModel class' category: 'ExtractClassRefactoring'!
ClassAllInstanceVariableListModel class
	instanceVariableNames: ''!

!classDefinition: #ClassAllMessageListModel category: 'ExtractClassRefactoring'!
Object subclass: #ClassAllMessageListModel
	instanceVariableNames: 'extractClassForm index list'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ExtractClassRefactoring'!
!classDefinition: 'ClassAllMessageListModel class' category: 'ExtractClassRefactoring'!
ClassAllMessageListModel class
	instanceVariableNames: ''!

!classDefinition: #ExtractClassObjectRequest category: 'ExtractClassRefactoring'!
Object subclass: #ExtractClassObjectRequest
	instanceVariableNames: 'newClassNameModel methodsToMoveModel instanceVariblesToMoveModel messageListModel instanceVariableListModel variableNameToAccessNewClassModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ExtractClassRefactoring'!
!classDefinition: 'ExtractClassObjectRequest class' category: 'ExtractClassRefactoring'!
ExtractClassObjectRequest class
	instanceVariableNames: ''!

!classDefinition: #TesisExtractClassRefactoringMenu category: 'ExtractClassRefactoring'!
Object subclass: #TesisExtractClassRefactoringMenu
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ExtractClassRefactoring'!
!classDefinition: 'TesisExtractClassRefactoringMenu class' category: 'ExtractClassRefactoring'!
TesisExtractClassRefactoringMenu class
	instanceVariableNames: ''!


!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/17/2023 00:49:56'!
addFocusReceiver: anInnerTextMorph

	! !

!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/10/2023 23:52:49'!
backgroundColor

	^Color lightGray! !

!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/12/2023 01:02:26'!
buildActionButtonsSection

	| section sectionLayoutSpec submorphsWidth sectionWidth submorphsHeight |

	section := LayoutMorph newRow.
	section separation: 10.
	section color: self backgroundColor.

	section addMorph: self buildCancelButton.
	section addMorph: self buildSubmitButton.

	submorphsWidth := (section submorphs collect: [:aSubmorph | aSubmorph layoutSpec fixedOrMinimumLayoutWidth]) sum.
	sectionWidth := submorphsWidth + (section xSeparation * (section submorphs size + 1)).
	submorphsHeight := (section submorphs collect: [:aSubmorph | aSubmorph layoutSpec fixedOrMinimumLayoutHeight]) max.
	sectionLayoutSpec := LayoutSpec fixedWidth: sectionWidth fixedHeight: submorphsHeight * 2.
	sectionLayoutSpec offAxisEdgeWeight: 0.95.

	section layoutSpec: sectionLayoutSpec.

	^section.
	! !

!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/12/2023 01:02:54'!
buildCancelButton

	| button buttonLayoutSpec |

	button := IndependentlyColoredButton model: self action: #cancelButtonClicked label: 'Cancel'.
	button color: Theme current cancelButton.

	buttonLayoutSpec := LayoutSpec
		fixedWidth: button morphWidth
		fixedHeight: ExtractToMethodObjectForm fontProportionalUnitOfReferenceForHeight  * 2.
	buttonLayoutSpec offAxisEdgeWeight: 0.85.
	button layoutSpec: buttonLayoutSpec.

	^button! !

!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/20/2023 01:43:38'!
buildMethodsToMoveListSection
	| list |
"
	list := PluggableListMorph
		model: messageListModel
		listGetter: #messageList
		indexGetter: #messageListIndex
		indexSetter: #messageListIndex:
		mainView: self
		menuGetter: #messageListMenu
		keystrokeAction: #messageListKey:from:.
"

	list := PluggableListMorphOfMany
				model: messageListModel
				listGetter: #messageList
				primarySelectionGetter: #selectedSuite
				primarySelectionSetter: #selectedSuite:
				listSelectionGetter: #listSelectionAt:
				listSelectionSetter: #listSelectionAt:put:
				mainView: self
				menuGetter: #messageListMenu
				keystrokeAction: #messageListKey:from:.
	
	list color: Color white.
	list layoutSpec: (LayoutSpec proportionalWidth: 1.0 fixedHeight: IntroduceNullObjectForm fontProportionalUnitOfReferenceForHeight * 7).

	^list! !

!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/20/2023 01:43:38'!
buildMorphicWindow
	
	self initializeScrollableContainer.
	self initializeFormLayout.
	scrollPane scroller addMorph: formLayout.
	formLayout axisEdgeWeight: #columnTop.

	newClassNameSection := self buildNullObjectHierarchyClassesSection.
	formLayout addMorph: newClassNameSection.

	instanceVariableListSection := self buildinstanceVariableListSection.
	formLayout addMorph: instanceVariableListSection.

	messageSendingListSection := self buildMethodsToMoveListSection.
	formLayout addMorph: messageSendingListSection.
	

"
	self buildIfNilChecksFormsFor: ifNilChecks.
"

	actionButtonsSection := self buildActionButtonsSection.
	formLayout addMorph: actionButtonsSection.


	self setExtents.

	self showFormForMessage: messageListModel selectedSuite.
	
	! !

!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/26/2023 22:47:08'!
buildNullObjectHierarchyClassesSection

	| section maxLabelWidth nullClassInput variableNameInput |

	section := FormSection withTitle: 'Extract class title' withColor: self backgroundColor.

self halt.
	maxLabelWidth := self recommendedWidthForLabels: #('New class name').
	newClassNameModel := TextModel withText: 'NameOfNewClass'.
	nullClassInput := LabeledInput 
					withLabel: 'New class name'
					withWidth: maxLabelWidth
					withModel: newClassNameModel
					usingAs: self.

	variableNameToAccessNewClassModel := TextModel withText: 'NameOfVariable'.
	variableNameInput := LabeledInput 
					withLabel: 'variable name to access new class'
					withWidth: maxLabelWidth
					withModel: variableNameToAccessNewClassModel
					usingAs: self.

	section addMorph: nullClassInput.
	section addMorph: variableNameInput.
	section layoutSpec: (self layoutSpecForSection: section).

	^section
! !

!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/12/2023 01:04:18'!
buildSubmitButton

	| submitButton submitButtonLayoutSpec |

	submitButton := IndependentlyColoredButton model: self action: #submitButtonClicked label: 'Refactor'.
	submitButton color: Theme current acceptButton.

	submitButtonLayoutSpec := LayoutSpec
		fixedWidth: submitButton morphWidth
		fixedHeight: ExtractToMethodObjectForm fontProportionalUnitOfReferenceForHeight  * 2.
	submitButtonLayoutSpec offAxisEdgeWeight: 0.95.
	submitButton layoutSpec: submitButtonLayoutSpec.

	^submitButton! !

!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/19/2023 01:21:31'!
buildinstanceVariableListSection
	| list |
"
	list := PluggableListMorph
		model: instanceVariableListModel
		listGetter: #instanceVariableList
		indexGetter: #instanceVariableListIndex
		indexSetter: #instanceVariableListIndex:
		mainView: self
		menuGetter: #messageListMenu
		keystrokeAction: #messageListKey:from:.
"

	list := PluggableListMorphOfMany
				model: instanceVariableListModel
				listGetter: #instanceVariableList
				primarySelectionGetter: #instanceVariableListIndex
				primarySelectionSetter: #instanceVariableListIndex:
				listSelectionGetter: #listSelectionAt:
				listSelectionSetter: #listSelectionAt:put:
				mainView: self
				menuGetter: #messageListMenu
				keystrokeAction: #messageListKey:from:.
	
	list color: Color white.
	list layoutSpec: (LayoutSpec proportionalWidth: 1.0 fixedHeight: IntroduceNullObjectForm fontProportionalUnitOfReferenceForHeight * 7).

	^list! !

!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/10/2023 23:54:56'!
initializeFormLayout

	formLayout := LayoutMorph newColumn.
	formLayout separation: 10; color: self backgroundColor.! !

!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/10/2023 23:51:34'!
initializeScrollableContainer

	scrollPane := ColoredScrollPane initializedInstance.
	scrollPane scroller color: self backgroundColor.
	scrollPane scroller layoutSpec: LayoutSpec useAll.
	scrollPane color: self backgroundColor.
	self layoutMorph addMorphUseAll: scrollPane.! !

!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/20/2023 01:40:56'!
initializeWithModel: aModel 

	super model: aModel.
	
	self setLabel: 'Extract class refactoring'.
	
	messageListModel := ClassAllMessageListModel withForm: self.
	instanceVariableListModel := ClassAllInstanceVariableListModel withForm: self.! !

!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/12/2023 00:28:15'!
layoutSpecForSection: aSection

	^LayoutSpec proportionalWidth: 1.0 fixedHeight: aSection recommendedHeight! !

!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/11/2023 23:50:55'!
recommendedWidthForLabels: labels

	| rightMargin |

	rightMargin := 20.
	^(labels collect: [:aLabel | FontFamily defaultFamilyAndPointSize widthOfString: aLabel]) max + rightMargin! !

!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 10/16/2023 02:11:18'!
showFormForMessage: anIndex
	^self
! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 10/17/2023 23:27:40'!
cancelButtonClicked
	
	model cancel.! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 10/18/2023 01:01:40'!
instanceVariableList
	^model instanceVariableList! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 10/18/2023 00:42:31'!
selectorList
	^model selectorList! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 10/17/2023 01:47:33'!
setExtents
	| requiredExtent |
	requiredExtent := 636.7669122572003@834.6393034159412.
	formLayout morphExtent: requiredExtent.
	scrollPane scroller morphExtent: requiredExtent.! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 10/29/2023 15:31:30'!
submitButtonClicked
	
	| request |
	self halt.
	request := ExtractClassObjectRequest 
					newWithNameModel: newClassNameModel
					methodsToMoveModel: messageListModel
					instanceVariableListModel: instanceVariableListModel
					variableNameToAccessThroughModel: variableNameToAccessNewClassModel .
	model userSubmitted: request.
	self deleteDiscardingEdits! !

!ExtractClassForm methodsFor: 'as yet unclassified' stamp: 'mc 10/20/2023 01:40:49'!
deleteDiscardingEdits

	super delete.! !

!ExtractClassForm class methodsFor: 'instance creation' stamp: 'mc 10/10/2023 23:43:58'!
open: aModel label: aString

	|  window |

	window := self withModel: aModel.
	window buildMorphicWindow.
	aString ifNotNil: [ window setLabel: aString ].
	window openInWorld.
	^window! !

!ExtractClassForm class methodsFor: 'instance creation' stamp: 'mc 10/10/2023 23:44:26'!
withModel: aModel

	^self new initializeWithModel: aModel! !

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

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 10/3/2023 00:01:15'!
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
	aTargetClass := TargetClass new.
	super initialize.' equals: (sourceClass sourceCodeAt: #initialize).! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 10/3/2023 22:46:07'!
test100_1extractClassShouldReuseInitialize
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract refactoring targetClass |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	sourceClass compile: 'initialize
	^self.' .
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
	aTargetClass := TargetClass new.
	^self.' equals: (sourceClass sourceCodeAt: #initialize).! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 10/3/2023 23:12:04'!
test100_2extractClassShouldReuseInitialize
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract refactoring targetClass |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	sourceClass compile: 'initialize
	| tmpvar |
	tmpvar := 1.
	^self.' .
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
	| tmpvar |
	aTargetClass := TargetClass new.
	tmpvar := 1.
	^self.' equals: (sourceClass sourceCodeAt: #initialize).! !

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

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 10/4/2023 23:00:22'!
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
						instanceVariableNamed: 'aTargetClass' instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	self assert: [ (Smalltalk classNamed: #TargetClass) notNil ].
	self assert: 1 equals: (Smalltalk classNamed: #TargetClass) instVarNames size.
	self assert: (Smalltalk classNamed: #TargetClass) instVarNames includes: 'iv1'.
	self assert: 'm1 ^aTargetClass iv1+1.' equals: (sourceClass sourceCodeAt: #m1).! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 10/9/2023 09:17:29'!
test104GivenMethodWhenExtractClassThenMoveMethodShouldBePerformed
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract refactoring targetClass |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	sourceClass compile: 'm1 ^iv1+1.' .
	methodsToExtract add: #m1.
	
	
	refactoring := ExtractClassRefactoring 
						from: sourceClass
						to: targetClassName
						instanceVariableNamed: 'aTargetClass' instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	targetClass := (Smalltalk classNamed: #TargetClass).
	self assert: [ targetClass notNil ].
	self assert: 0 equals: targetClass instVarNames size.
	self assert: 'm1
	^aTargetClass m1: self.' equals: (sourceClass sourceCodeAt: #m1).
	self assert: 'm1: aSourceObject ^aSourceObject iv1+1.' equals: (targetClass sourceCodeAt: #m1:).! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 10/9/2023 19:49:11'!
test105Given2MethodsWhenExtractClassThenMoveMethodShouldBePerformed
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract refactoring targetClass |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	sourceClass compile: 'm1 ^iv1+1.' .
	sourceClass compile: 'm2 ^1.' .
	methodsToExtract add: #m1.
	methodsToExtract add: #m2.
	
	
	refactoring := ExtractClassRefactoring 
						from: sourceClass
						to: targetClassName
						instanceVariableNamed: 'aTargetClass' instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	targetClass := (Smalltalk classNamed: #TargetClass).
	self assert: [ targetClass notNil ].
	self assert: 0 equals: targetClass instVarNames size.
	self assert: 'm1
	^aTargetClass m1: self.' equals: (sourceClass sourceCodeAt: #m1).
	self assert: 'm1: aSourceObject ^aSourceObject iv1+1.' equals: (targetClass sourceCodeAt: #m1:).
	self assert: 'm2
	^aTargetClass m2.' equals: (sourceClass sourceCodeAt: #m2).
	self assert: 'm2 ^1.' equals: (targetClass sourceCodeAt: #m2).! !

!ExtractClassRefactoring methodsFor: 'initialization' stamp: 'mc 10/9/2023 19:50:02'!
initializeFrom: aSourceClassName to: aTargetClassName instanceVariableNamed: anInstanceVariableNameForSourceClass instVarToExtract: collectionOfInstVarsToExtract methodToExtract: collectionOfMethodsToExtract  
	sourceClass := aSourceClassName.
	targetClassName := aTargetClassName.
	instVarsToExtract := collectionOfInstVarsToExtract.
	methodsToExtract := collectionOfMethodsToExtract.
	variableToAccessToNewClass := anInstanceVariableNameForSourceClass.
	! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 10/26/2023 00:34:05'!
addInstanceVariableToAccessNewClass

	^ sourceClass addInstVarName: variableToAccessToNewClass! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 10/26/2023 00:36:19'!
apply
	
	self 
		createNewClass;
		addInstanceVariableToAccessNewClass;
		moveInstanceVariables;
		moveMethods;
		initializeNewObject.! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 10/26/2023 00:27:56'!
createNewClass

	^ Object 
		subclass: targetClassName 
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: sourceClass category! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 10/26/2023 00:32:15'!
initializeNewObject
	| newSourceInitialize |
	sourceClass methodDict 
		at: #initialize 
		ifPresent:  [ :initializeCompiledMethod |
			newSourceInitialize := self newSourceCodeForInitializeWhenExists: initializeCompiledMethod.
			]
		ifAbsent: [
			newSourceInitialize := 'initialize', String newLineString, String tab, variableToAccessToNewClass, ' := ', targetClassName, ' new.'.
			newSourceInitialize := newSourceInitialize, String newLineString, String tab, 'super initialize.'.
			].
	sourceClass compile: newSourceInitialize! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 10/26/2023 00:36:18'!
moveInstanceVariables

	^ instVarsToExtract do: [ :anInstanceVariableToMove | 
		(MoveInstanceVariableRefactoring 
			named: anInstanceVariableToMove 
			from: sourceClass 
			to: (Smalltalk classNamed: targetClassName) 
			accessingThrough: variableToAccessToNewClass ) apply.]! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 10/26/2023 00:30:05'!
moveMethods

	^ methodsToExtract do: [ :aMethodToMove | |extraParameter|
		(MoveMethodRefactoring needParameterNameToMove: aMethodToMove from: sourceClass)
			ifTrue: [
				aMethodToMove isKeyword 
					ifTrue: [extraParameter := ExtraParameterNameNeededAndExtraKeyword parameterName: 'aSourceObject' extraKeyword: 'withSource' ]
					ifFalse: [extraParameter := ExtraParameterNameNeeded parameterName: 'aSourceObject'.]]
			ifFalse: [extraParameter := NonExtraParameterNameNeeded new].
		
		
		(MoveMethodRefactoring 
			methodNamed: aMethodToMove
			from: sourceClass 
			to: (Smalltalk classNamed: targetClassName)
			accessingThrough: variableToAccessToNewClass
			parameterNeeded: extraParameter) apply.]! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 10/4/2023 00:20:37'!
newSourceCodeForInitializeWhenExists: initializeCompiledMethod 
	| codeForTemporaries newSourceInitialize originalSourceInitialize rangesForTmpVars |
	originalSourceInitialize := sourceClass sourceCodeAt: #initialize.
	rangesForTmpVars := initializeCompiledMethod methodNode 
							completeSourceRangesOf: initializeCompiledMethod methodNode
							temporariesDeclaration ifAbsent: [
								newSourceInitialize := 'initialize', String newLineString, String tab, variableToAccessToNewClass, ' := ', targetClassName, ' new.'.
								newSourceInitialize := newSourceInitialize, (originalSourceInitialize copyFrom: 11 to: originalSourceInitialize size).
								^newSourceInitialize].
	rangesForTmpVars := rangesForTmpVars detectMin: [ :anInterval | anInterval first].
	codeForTemporaries := initializeCompiledMethod sourceCode copyFrom: rangesForTmpVars first to: rangesForTmpVars last.
	newSourceInitialize := 'initialize', String newLineString, String tab, codeForTemporaries, String newLineString, String tab, variableToAccessToNewClass, ' := ', targetClassName, ' new.'.
	newSourceInitialize := newSourceInitialize, (originalSourceInitialize copyFrom: (rangesForTmpVars last + 1) to: originalSourceInitialize size).
	^newSourceInitialize! !

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

!ExtractClassApplier methodsFor: 'initialization' stamp: 'mc 10/10/2023 23:04:03'!
initializeToApplyOn: aClass

	classToRefactor := aClass.! !

!ExtractClassApplier methodsFor: 'as yet unclassified' stamp: 'mc 10/17/2023 23:28:15'!
cancel
	form delete.! !

!ExtractClassApplier methodsFor: 'as yet unclassified' stamp: 'mc 10/29/2023 15:33:44'!
createRefactoring
	self halt.
	
	^ExtractClassRefactoring 
		from: classToRefactor 
		to: extractClassRequest newClassName
		instanceVariableNamed: extractClassRequest variableNameToAccessNewClass
		instVarToExtract: extractClassRequest instanceVariablesToExtract
		methodToExtract: extractClassRequest methodsToExtract.! !

!ExtractClassApplier methodsFor: 'as yet unclassified' stamp: 'mc 10/10/2023 23:05:01'!
value
	self requestRefactoringParametersHandlingRefactoringExceptions.! !

!ExtractClassApplier methodsFor: 'refactoring - parameters request' stamp: 'mc 10/10/2023 23:40:49'!
requestRefactoringParameters

	"ver si hay que agregar check si la clase esta vacia"
"	self chooseInstanceVariable.

	instanceVariable ifNil: [^self].

	ifNilChecks := (IfNilChecksFinder on: classToRefactor for: instanceVariable) value.

	ifNilChecks ifEmpty: [^self inform: ('There are no ifNil checks on ', instanceVariable)].
"
	form := ExtractClassForm open: self.! !

!ExtractClassApplier methodsFor: 'accessing' stamp: 'mc 10/18/2023 01:04:18'!
instanceVariableList
	^classToRefactor instVarNames ! !

!ExtractClassApplier methodsFor: 'accessing' stamp: 'mc 10/18/2023 00:50:43'!
selectorList
	^classToRefactor selectors sort! !

!ExtractClassApplier methodsFor: 'accessing' stamp: 'mc 10/23/2023 02:59:44'!
userSubmitted: request 
	
	extractClassRequest := request.
	self createRefactoringHandlingRefactoringExceptions.
	refactoring ifNotNil: [self applyRefactoring].
	! !

!ExtractClassApplier class methodsFor: 'instance creation' stamp: 'mc 10/10/2023 23:03:08'!
applyOn: aClass 
	
	^self new initializeToApplyOn: aClass! !

!ClassAllInstanceVariableListModel methodsFor: 'initialization' stamp: 'mc 10/19/2023 01:20:40'!
initializeWithForm: anExtractClassForm 
	index := 0.
	extractClassForm := anExtractClassForm.
	list := self instanceVariableList collect: [:ea | false].! !

!ClassAllInstanceVariableListModel methodsFor: 'morphmany' stamp: 'mc 10/18/2023 01:04:28'!
instanceVariableList
	^extractClassForm instanceVariableList sort! !

!ClassAllInstanceVariableListModel methodsFor: 'morphmany' stamp: 'mc 10/18/2023 01:04:53'!
instanceVariableListIndex
	^index ! !

!ClassAllInstanceVariableListModel methodsFor: 'morphmany' stamp: 'mc 10/18/2023 01:06:18'!
instanceVariableListIndex: anIndex 
	index := anIndex ! !

!ClassAllInstanceVariableListModel methodsFor: 'morphmany' stamp: 'mc 10/19/2023 01:21:51'!
listSelectionAt: anIndex
	^list at: anIndex ! !

!ClassAllInstanceVariableListModel methodsFor: 'morphmany' stamp: 'mc 10/19/2023 01:22:01'!
listSelectionAt: anIndex put: aBoolean 
	list at: anIndex put: aBoolean ! !

!ClassAllInstanceVariableListModel methodsFor: 'accessing' stamp: 'mc 10/23/2023 02:12:38'!
instanceVariablesToExtract
	| retval |
	retval := OrderedCollection new.
	self instanceVariableList with: list do: [ :str :sel | sel ifTrue: [ retval add: str ]].
	^retval! !

!ClassAllInstanceVariableListModel class methodsFor: 'instance creation' stamp: 'mc 10/18/2023 00:58:54'!
withForm: anExtractClassForm 
	^self new initializeWithForm: anExtractClassForm ! !

!ClassAllMessageListModel methodsFor: 'initialization' stamp: 'mc 10/19/2023 00:43:54'!
initializeWithForm: anExtractClassForm 
	index := 0.
	extractClassForm := anExtractClassForm.
	list := self messageList collect: [:ea | false].! !

!ClassAllMessageListModel methodsFor: 'morphmany' stamp: 'mc 10/19/2023 00:42:09'!
listSelectionAt: anIndex
	^list at: anIndex ! !

!ClassAllMessageListModel methodsFor: 'morphmany' stamp: 'mc 10/19/2023 01:10:15'!
listSelectionAt: anIndex put: aBoolean 
	list at: anIndex put: aBoolean ! !

!ClassAllMessageListModel methodsFor: 'morphmany' stamp: 'mc 10/18/2023 00:41:24'!
messageList
	^extractClassForm selectorList! !

!ClassAllMessageListModel methodsFor: 'morphmany' stamp: 'mc 10/19/2023 00:41:30'!
selectedSuite
	^index! !

!ClassAllMessageListModel methodsFor: 'morphmany' stamp: 'mc 10/19/2023 00:41:09'!
selectedSuite: anInteger
	index := anInteger ! !

!ClassAllMessageListModel methodsFor: 'accessing' stamp: 'mc 10/23/2023 02:17:31'!
methodsToExtract
	| retval |
	retval := OrderedCollection new.
	self messageList with: list do: [ :str :sel | sel ifTrue: [ retval add: str ]].
	^retval! !

!ClassAllMessageListModel class methodsFor: 'instance creation' stamp: 'mc 10/16/2023 03:27:03'!
withForm: anExtractClassForm

	^self new initializeWithForm: anExtractClassForm ! !

!ExtractClassObjectRequest methodsFor: 'accessing' stamp: 'mc 10/23/2023 01:43:09'!
instanceVariablesToExtract

	^instanceVariableListModel instanceVariablesToExtract! !

!ExtractClassObjectRequest methodsFor: 'accessing' stamp: 'mc 10/23/2023 02:16:17'!
methodsToExtract
	^messageListModel methodsToExtract! !

!ExtractClassObjectRequest methodsFor: 'accessing' stamp: 'mc 10/23/2023 01:32:22'!
newClassName
	^newClassNameModel actualContents asString asSymbol ! !

!ExtractClassObjectRequest methodsFor: 'accessing' stamp: 'mc 10/29/2023 15:34:38'!
variableNameToAccessNewClass
	^variableNameToAccessNewClassModel actualContents string ! !

!ExtractClassObjectRequest methodsFor: 'initialization' stamp: 'mc 10/22/2023 00:17:13'!
initializeNewWithNameModel: aNewClassNameModel methodsToMoveModel: aMessageListModel instanceVariableListModel: anInstanceVariableListModel 
	newClassNameModel := aNewClassNameModel.
	messageListModel := aMessageListModel.
	instanceVariableListModel := anInstanceVariableListModel.! !

!ExtractClassObjectRequest methodsFor: 'initialization' stamp: 'mc 10/29/2023 15:32:35'!
initializeNewWithNameModel: aNewClassNameModel methodsToMoveModel: aMessageListModel instanceVariableListModel: anInstanceVariableListModel variableNameToAccessThroughModel: aVariableNameToAccessNewClassModel 
	newClassNameModel := aNewClassNameModel.
	messageListModel := aMessageListModel.
	instanceVariableListModel := anInstanceVariableListModel.
	variableNameToAccessNewClassModel := aVariableNameToAccessNewClassModel.! !

!ExtractClassObjectRequest class methodsFor: 'instance creation' stamp: 'mc 10/22/2023 00:16:48'!
newWithNameModel: aNewClassNameModel methodsToMoveModel: aMessageListModel instanceVariableListModel: anInstanceVariableListModel 
	^self new initializeNewWithNameModel: aNewClassNameModel methodsToMoveModel: aMessageListModel instanceVariableListModel: anInstanceVariableListModel ! !

!ExtractClassObjectRequest class methodsFor: 'instance creation' stamp: 'mc 10/29/2023 15:32:12'!
newWithNameModel: aNewClassNameModel methodsToMoveModel: aMessageListModel instanceVariableListModel: anInstanceVariableListModel variableNameToAccessThroughModel: aVariableNameToAccessNewClassModel 
	^self new 
		initializeNewWithNameModel: aNewClassNameModel 
		methodsToMoveModel: aMessageListModel 
		instanceVariableListModel: anInstanceVariableListModel 
		variableNameToAccessThroughModel: aVariableNameToAccessNewClassModel ! !

!TesisExtractClassRefactoringMenu class methodsFor: 'as yet unclassified' stamp: 'mc 10/10/2023 01:16:47'!
classListMenuOptions

	^ `{	
			{
				#submenuOf -> RefactoringMenues refactoringsLabel.
				#itemGroup 		-> 		40.
				#itemOrder 		-> 		20.
				#label 			-> 		'Extract class...'.
				#selector 		-> 		#contextualExtractClass.
				#icon 			-> 		#newFolderIcon
			} asDictionary.			
	}`.! !

!BrowserWindow methodsFor: '*ExtractClassRefactoring' stamp: 'mc 10/18/2023 01:10:37'!
contextualExtractClass

	| classToRefactor |
	"self halt."
	classToRefactor := model selectedClassOrMetaClass.

	classToRefactor ifNotNil: [(ExtractClassApplier applyOn: classToRefactor) value.].! !
