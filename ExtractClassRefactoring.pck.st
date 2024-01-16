'From Cuis 6.0 [latest update: #5981] on 16 January 2024 at 2:38:45 am'!
'Description '!
!provides: 'ExtractClassRefactoring' 1 17!
SystemOrganization addCategory: 'ExtractClassRefactoring'!


!classDefinition: #ExtractClassForm category: 'ExtractClassRefactoring'!
SystemWindow subclass: #ExtractClassForm
	instanceVariableNames: 'messageSendingListSection newClassNameModel variableNameToAccessNewClassModel indexVariableList variableList messageList indexMessageList labelHasReferencesToVariables'
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


!ExtractClassForm methodsFor: 'initialization' stamp: 'mc 1/7/2024 23:55:41'!
initializeWithModel: aModel 

	super model: aModel.
	
	self setLabel: 'Extract class refactoring for ', aModel classToRefactorName .
	
	indexVariableList := 0.
	indexMessageList := 0.
	variableList := self variableListAsString collect: [:ea | false].
	messageList := self selectorList collect: [:ea | false].
	! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
canDiscardEdits
	^true! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 02:01:05'!
hasVariablesSelected: aMessage
	"self halt."
	^self instanceVariablesToExtract anySatisfy: [ :anInstanceVariable | 
		(model compiledMethodAt: aMessage) accessesInstanceVariable: anInstanceVariable].
	! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
indexVariableList
	^indexVariableList! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
indexVariableList: anIndex
	indexVariableList := anIndex! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/7/2024 23:55:41'!
instanceVariableList
	^self variableListAsString collect: [ :aVariable | 
		(Text fromString: aVariable) color: self colorForInstVar ]! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
instanceVariableListIndex
	^indexVariableList ! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
instanceVariableListIndex: anIndex 
	indexVariableList := anIndex ! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/7/2024 23:55:41'!
instanceVariablesToExtract
	| retval |
	"self halt."
	retval := OrderedCollection new.
	self variableListAsString with: variableList do: [ :str :sel | sel ifTrue: [ retval add: str ]].
	^retval! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/7/2024 01:12:55'!
messageList
	"self halt."
	labelHasReferencesToVariables ifNotNil: [labelHasReferencesToVariables visible: (self selectorList anySatisfy: [ :aMessage | self hasVariablesSelected: aMessage])].
	^self selectorList collect: [ :aMessage | 
		"self halt."
		(self hasVariablesSelected: aMessage)
			ifTrue: [(Text fromString: aMessage) color: Color blue]
			ifFalse: [Text fromString: aMessage]
	]! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
messageListMenu
	! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
messagelistSelectionAt: anIndex
	^messageList at: anIndex ! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
messagelistSelectionAt: anIndex put: aBoolean 
	messageList at: anIndex put: aBoolean ! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 02:28:51'!
methodsToExtract
	| retval |
	retval := OrderedCollection new.
	self selectorList with: messageList do: [ :str :sel | sel ifTrue: [ retval add: str ]].
	^retval! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
selectedSuite
	^indexMessageList! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
selectedSuite: anInteger
	indexMessageList := anInteger ! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
selectorList
	^model selectorList! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/7/2024 23:55:41'!
variableListAsString

	^ model instanceVariableList sort! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
variablelistSelectionAt: anIndex
	^variableList at: anIndex ! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
variablelistSelectionAt: anIndex put: aBoolean 
	variableList at: anIndex put: aBoolean.
	messageSendingListSection updateList; redrawNeeded
	! !

!ExtractClassForm methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
windowColor
	^Color lightGray! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/5/2024 01:23:50'!
addFocusReceiver: anInnerTextMorph

	! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/5/2024 01:23:50'!
backgroundColor

	^Color lightGray! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/15/2024 01:37:48'!
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
	self layoutMorph addMorph: section.
	
	! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/15/2024 01:19:16'!
buildCancelButton

	| button |

	button := IndependentlyColoredButton model: self action: #cancelButtonClicked label: 'Cancel'.
	button color: Theme current cancelButton.
	^button! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/16/2024 01:44:01'!
buildMethodsToMoveListSection
	| list methodsToMoveTitle |
	"self halt."
	list := PluggableListMorphOfMany
				model: self
				listGetter: #messageList
				primarySelectionGetter: #selectedSuite
				primarySelectionSetter: #selectedSuite:
				listSelectionGetter: #messagelistSelectionAt:
				listSelectionSetter: #messagelistSelectionAt:put:
				mainView: self
				menuGetter: nil
				keystrokeAction: nil.
	
	list color: Color white.
	list layoutSpec: (LayoutSpec proportionalWidth: 1.0).
	
	methodsToMoveTitle := LabelMorph contents: 'Select methods to move:'.
	methodsToMoveTitle layoutSpec offAxisEdgeWeight: 0.0.
	self layoutMorph addMorph: methodsToMoveTitle.
	messageSendingListSection := list.
	self layoutMorph addMorph: messageSendingListSection.
	! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/16/2024 00:28:48'!
buildMorphicWindow
	
	self 
		setConfigurationOnLayoutMorph;
		buildNewClassNameSection;
		buildVariableToAccessNewClassSection;
		buildinstanceVariableListSection;
		buildMethodsToMoveListSection;
		buildReferencesToVariablesLabel;
		buildActionButtonsSection;
		setExtents
	! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/15/2024 02:02:56'!
buildNewClassNameSection

	| maxLabelWidth newClassNameInput |

	maxLabelWidth := self recommendedWidthForLabels: #('New class name' 'Variable name to access new class').
	newClassNameModel := TextModel withText: (((Text fromString: 'NameOfNewClass') color: self colorForClassName) bold).

	newClassNameInput := LabeledInput 
					withLabel: 'New class name'
					withLabelFixedWidth: maxLabelWidth
					withModel: newClassNameModel
					usingAs: self.
	self layoutMorph addMorph: newClassNameInput.
	! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/15/2024 01:36:56'!
buildReferencesToVariablesLabel

	labelHasReferencesToVariables := LabelMorph new.
	labelHasReferencesToVariables contents: '*Reference to selected instance variables'.
	labelHasReferencesToVariables color: Color blue.
	labelHasReferencesToVariables layoutSpec offAxisEdgeWeight: 0.0.
	labelHasReferencesToVariables visible: false.
	self layoutMorph addMorph: labelHasReferencesToVariables! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/5/2024 01:23:50'!
buildSubmitButton

	| submitButton |

	submitButton := IndependentlyColoredButton model: self action: #submitButtonClicked label: 'Refactor'.
	submitButton color: Theme current acceptButton.
	^submitButton! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/15/2024 02:01:59'!
buildVariableToAccessNewClassSection

	| maxLabelWidth variableNameInput |

	maxLabelWidth := self recommendedWidthForLabels: #('New class name' 'Variable name to access new class').
	
	variableNameToAccessNewClassModel := TextModel withText: 'aNameOfVariable'.
	variableNameToAccessNewClassModel actualContents color: self colorForInstVar .
	variableNameInput := LabeledInput 
					withLabel: 'Variable name to access new class'
					withLabelFixedWidth: maxLabelWidth
					withModel: variableNameToAccessNewClassModel
					usingAs: self.
	
	
	self layoutMorph addMorph: variableNameInput.
	
! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/15/2024 01:28:19'!
buildinstanceVariableListSection
	| list instanceVariablesToMoveTitle |
	
	list := PluggableListMorphOfMany
				model: self
				listGetter: #instanceVariableList
				primarySelectionGetter: #instanceVariableListIndex
				primarySelectionSetter: #instanceVariableListIndex:
				listSelectionGetter: #variablelistSelectionAt:
				listSelectionSetter: #variablelistSelectionAt:put:
				mainView: self
				menuGetter: nil
				keystrokeAction: nil.
	
	list color: Color white.
	list layoutSpec: (LayoutSpec proportionalWidth: 1.0 fixedHeight: IntroduceNullObjectForm fontProportionalUnitOfReferenceForHeight * 7).
	instanceVariablesToMoveTitle := LabelMorph contents: 'Select instance variables to move:'.
	instanceVariablesToMoveTitle layoutSpec offAxisEdgeWeight: 0.0.
	self layoutMorph addMorph: instanceVariablesToMoveTitle.
	self layoutMorph addMorph: list.
! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/5/2024 01:23:50'!
colorForClassName

	^ Color blue! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/5/2024 01:23:50'!
colorForInstVar

	^ Color magenta muchDarker! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/5/2024 01:23:50'!
recommendedWidthForLabels: labels

	| rightMargin |

	rightMargin := 20.
	^(labels collect: [:aLabel | FontFamily defaultFamilyAndPointSize widthOfString: aLabel]) max + rightMargin! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/16/2024 00:28:37'!
setConfigurationOnLayoutMorph

	self layoutMorph separation: 5; color: self backgroundColor.
	
	self layoutMorph color: self backgroundColor.
	self layoutMorph axisEdgeWeight: #columnTop! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/5/2024 01:23:50'!
setExtents
	| requiredExtent |
	requiredExtent := 636.7669122572003@834.6393034159412.
	self layoutMorph morphExtent: requiredExtent.
	"scrollPane scroller morphExtent: requiredExtent."! !

!ExtractClassForm methodsFor: 'GUI building' stamp: 'mc 1/5/2024 01:23:50'!
showFormForMessage: anIndex
	^self
! !

!ExtractClassForm methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:50'!
deleteDiscardingEdits

	super delete.! !

!ExtractClassForm methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 02:37:43'!
moveFrom: aTabPassingInnerTextMorph 
	"this method is to disable tab key"! !

!ExtractClassForm methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:50'!
widgetsColor: aColor
	! !

!ExtractClassForm methodsFor: 'actions' stamp: 'mc 1/5/2024 01:23:50'!
cancelButtonClicked
	
	model cancel.! !

!ExtractClassForm methodsFor: 'actions' stamp: 'mc 1/5/2024 01:23:50'!
submitButtonClicked
	
	| request |
	"self halt."
	request := ExtractClassObjectRequest 
					newWithNameModel: newClassNameModel
					methodsToMoveModel: self
					instanceVariableListModel: self
					variableNameToAccessThroughModel: variableNameToAccessNewClassModel .
	model userSubmitted: request.
	self deleteDiscardingEdits! !

!ExtractClassForm class methodsFor: 'instance creation' stamp: 'mc 1/5/2024 01:23:50'!
open: aModel label: aString

	|  window |
	"self halt."
	window := self withModel: aModel.
	window buildMorphicWindow.
	aString ifNotNil: [ window setLabel: aString ].
	window openInWorld.
	^window! !

!ExtractClassForm class methodsFor: 'instance creation' stamp: 'mc 1/5/2024 01:23:50'!
withModel: aModel

	^self new initializeWithModel: aModel! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
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

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
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

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
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

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
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

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
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

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
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

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
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

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
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

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
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

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
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

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
test101GivenSourceClassAndOneInstanceVariableWhenExtractClassThenInstanceVariableShouldBeInTargetClass
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract refactoring targetClass |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	instVarsToExtract add: 'iv1'.
	
	refactoring := ExtractClassRefactoring 
						from: sourceClass
						to: targetClassName
						instanceVariableNamed: 'aTargetClass' 
						instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	targetClass := Smalltalk classNamed: #TargetClass.
	self assert: [ targetClass notNil ].
	self assert: 1 equals: targetClass instVarNames size.
	self assert: 'iv1' equals: targetClass instVarNames first.! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
test102GivenSourceClassAndTwoInstanceVariableWhenExtractClassThenInstanceVariableShouldBeInTargetClass
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract refactoring targetClass |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1 iv2'.
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	instVarsToExtract add: 'iv1'.
	instVarsToExtract add: 'iv2'.
	
	refactoring := ExtractClassRefactoring 
						from: sourceClass
						to: targetClassName
						instanceVariableNamed: 'aTargetClass' 
						instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	targetClass := Smalltalk classNamed: #TargetClass.
	self assert: [ targetClass notNil ].
	self assert: 2 equals: targetClass instVarNames size.
	self assert: targetClass instVarNames includes: 'iv1'.
	self assert: targetClass instVarNames includes: 'iv2'.! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
test103GivenMethodAndInstanceVariableWhenExtractClassThenInstanceVariableShouldBeInTargetClass
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract refactoring targetClass |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'iv1'.
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	instVarsToExtract add: 'iv1'.
	sourceClass compile: 'm1 ^iv1+1.' .
	
	refactoring := ExtractClassRefactoring 
						from: sourceClass
						to: targetClassName
						instanceVariableNamed: 'aTargetClass' 
						instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	targetClass := Smalltalk classNamed: #TargetClass.
	self assert: [ targetClass notNil ].
	self assert: 1 equals: targetClass instVarNames size.
	self assert: targetClass instVarNames includes: 'iv1'.
	self assert: 'm1 ^aTargetClass iv1+1.' equals: (sourceClass sourceCodeAt: #m1).! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
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
						instanceVariableNamed: 'aTargetClass' 
						instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	targetClass := Smalltalk classNamed: #TargetClass.
	self assert: [ targetClass notNil ].
	self assert: 0 equals: targetClass instVarNames size.
	self assert: 'm1
	^aTargetClass m1: self.' equals: (sourceClass sourceCodeAt: #m1).
	self assert: 'm1: aSourceClass ^aSourceClass iv1+1.' equals: (targetClass sourceCodeAt: #m1:).! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
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
						instanceVariableNamed: 'aTargetClass' 
						instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	targetClass := (Smalltalk classNamed: #TargetClass).
	self assert: [ targetClass notNil ].
	self assert: 0 equals: targetClass instVarNames size.
	self assert: 'm1
	^aTargetClass m1: self.' equals: (sourceClass sourceCodeAt: #m1).
	self assert: 'm1: aSourceClass ^aSourceClass iv1+1.' equals: (targetClass sourceCodeAt: #m1:).
	self assert: 'm2
	^aTargetClass m2.' equals: (sourceClass sourceCodeAt: #m2).
	self assert: 'm2 ^1.' equals: (targetClass sourceCodeAt: #m2).! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
test106GivenAMethodsAndInstvarWithSameNameWhenExtractClassThenGettersShouldHaveADifferentName
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract refactoring targetClass |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'cbu'.
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	sourceClass compile: 'cbu ^cbu.' .
	sourceClass compile: 'cbuPlusOne ^cbu+1 .' .
	methodsToExtract add: #cbu.
	instVarsToExtract add: 'cbu'.
	
	refactoring := ExtractClassRefactoring 
						from: sourceClass
						to: targetClassName
						instanceVariableNamed: 'aCbu' 
						instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	targetClass := (Smalltalk classNamed: #TargetClass).
	self assert: [ targetClass notNil ].
	self assert: 1 equals: targetClass instVarNames size.
	self assert: 'cbu
	^aCbu cbu.' equals: (sourceClass sourceCodeAt: #cbu).
	self assert: 'cbuPlusOne ^aCbu cbuGetter+1 .' equals: (sourceClass sourceCodeAt: #cbuPlusOne).
	self assert: 'cbuGetter
	^cbu' equals: (targetClass sourceCodeAt: #cbuGetter).
	! !

!ExtractClassRefactoringTest methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
test107GivenAMethodsAndInstvarWithSameNameWhenExtractClassThenSettersShouldHaveADifferentName
	
	| targetClassName sourceClass instVarsToExtract methodsToExtract refactoring targetClass |
	targetClassName := #TargetClass.
	sourceClass := self createClassNamed: #SourceClass instanceVariableNames: 'counter'.
	instVarsToExtract := OrderedCollection new.
	methodsToExtract := OrderedCollection new.
	sourceClass compile: 'counter: anInt ^counter := anInt.' .
	sourceClass compile: 'counterReset
	counter := 1.
	^counter' .
	methodsToExtract add: #counter:.
	instVarsToExtract add: 'counter'.
	
	refactoring := ExtractClassRefactoring 
						from: sourceClass
						to: targetClassName
						instanceVariableNamed: 'aCounter' 
						instVarToExtract: instVarsToExtract
						methodToExtract: methodsToExtract.
	refactoring apply.
	
	targetClass := (Smalltalk classNamed: #TargetClass).
	self assert: [ targetClass notNil ].
	self assert: 1 equals: targetClass instVarNames size.
	self assert: 'counter: anInt
	^aCounter counter: anInt.' equals: (sourceClass sourceCodeAt: #counter:).
	self assert: 'counterReset
	aCounter counterSetter: 1.
	^aCounter counter' equals: (sourceClass sourceCodeAt: #counterReset).
	self assert: 'counterSetter: anObject
	^counter := anObject.' equals: (targetClass sourceCodeAt: #counterSetter:).
	! !

!ExtractClassRefactoring methodsFor: 'initialization' stamp: 'mc 1/5/2024 01:23:51'!
initializeFrom: aSourceClassName to: aTargetClassName instanceVariableNamed: anInstanceVariableNameForSourceClass instVarToExtract: collectionOfInstVarsToExtract methodToExtract: collectionOfMethodsToExtract  
	sourceClass := aSourceClassName.
	targetClassName := aTargetClassName.
	instVarsToExtract := collectionOfInstVarsToExtract.
	methodsToExtract := collectionOfMethodsToExtract.
	variableToAccessToNewClass := anInstanceVariableNameForSourceClass.
	! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 1/5/2024 01:23:51'!
addInstanceVariableToAccessNewClass

	^ sourceClass addInstVarName: variableToAccessToNewClass! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 1/5/2024 01:23:50'!
apply
	
	self 
		createNewClass;
		initializeNewObject;
		addInstanceVariableToAccessNewClass;
		moveInstanceVariables;
		moveMethods.
		! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 1/5/2024 01:23:51'!
createNewClass

	^ Object 
		subclass: targetClassName 
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: sourceClass category! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 1/5/2024 01:23:51'!
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

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 1/5/2024 01:23:51'!
moveInstanceVariables

	| newGetter newSetter |
	"self halt."
	^ instVarsToExtract do: [ :anInstanceVariableToMove | 
		
		(methodsToExtract includes: anInstanceVariableToMove asSymbol) 
			ifTrue: [newGetter := (anInstanceVariableToMove, 'Getter') asSymbol.]
			ifFalse: [newGetter := anInstanceVariableToMove asSymbol].
		
		(methodsToExtract includes: (anInstanceVariableToMove, ':') asSymbol) 
			ifTrue: [newSetter := (anInstanceVariableToMove, 'Setter:') asSymbol.]
			ifFalse: [newSetter := (anInstanceVariableToMove, ':') asSymbol].

		(MoveInstanceVariableRefactoring 
			named: anInstanceVariableToMove
			from: sourceClass
			to: (Smalltalk classNamed: targetClassName) 
			accessingThrough: variableToAccessToNewClass
			usingGetter: newGetter
			usingSetter: newSetter) apply.
		]! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 1/5/2024 01:23:51'!
moveMethods
	"self halt."
	^ methodsToExtract do: [ :aMethodToMove | |extraParameter|
		(MoveMethodRefactoring needParameterNameToMove: aMethodToMove from: sourceClass accessingThrough: variableToAccessToNewClass)
			ifTrue: [
				aMethodToMove isKeyword 
					ifTrue: [extraParameter := ExtraParameterNameNeededAndExtraKeyword parameterName: ('a', sourceClass name) extraKeyword: ('with', sourceClass name) ]
					ifFalse: [extraParameter := ExtraParameterNameNeeded parameterName: ('a', sourceClass name).]]
			ifFalse: [extraParameter := NonExtraParameterNameNeeded new].
		
		
		(MoveMethodRefactoring 
			methodNamed: aMethodToMove
			from: sourceClass 
			to: (Smalltalk classNamed: targetClassName)
			accessingThrough: variableToAccessToNewClass
			parameterNeeded: extraParameter) apply.]! !

!ExtractClassRefactoring methodsFor: 'applying' stamp: 'mc 1/5/2024 01:23:51'!
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

!ExtractClassRefactoring class methodsFor: 'instance creation' stamp: 'mc 1/5/2024 01:23:51'!
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

!ExtractClassRefactoring class methodsFor: 'message handling' stamp: 'mc 1/5/2024 01:23:51'!
instanceVariable: anInsVarName shouldExistsOn: aClassName 
	^'instance variable ', anInsVarName, ' should exists on ', aClassName! !

!ExtractClassRefactoring class methodsFor: 'message handling' stamp: 'mc 1/5/2024 01:23:51'!
instanceVariableToExtractShouldExistsOnSourceClass
	^'instance variable to extract should exists on source class'.! !

!ExtractClassRefactoring class methodsFor: 'message handling' stamp: 'mc 1/5/2024 01:23:51'!
selector: aSelector shouldExistsOn: aClassName 
	^'selector ', aSelector, ' should exists on ', aClassName! !

!ExtractClassRefactoring class methodsFor: 'message handling' stamp: 'mc 1/5/2024 01:23:51'!
targetClassShouldNotExistsErrorMessage
	^'Target class should not exists'! !

!ExtractClassRefactoring class methodsFor: 'message handling' stamp: 'mc 1/5/2024 01:23:51'!
variableToAccessNewClassShouldNotBeInUseErrorMessage
	^'variable to access new class should not be in use'! !

!ExtractClassRefactoring class methodsFor: 'message handling' stamp: 'mc 1/5/2024 01:23:51'!
variableToAccessNewClassShouldNotBeNilErrorMessage
	^'variable to access new class should not be nil'! !

!ExtractClassApplier methodsFor: 'initialization' stamp: 'mc 1/5/2024 01:23:50'!
initializeToApplyOn: aClass

	classToRefactor := aClass.! !

!ExtractClassApplier methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:50'!
cancel
	form delete.! !

!ExtractClassApplier methodsFor: 'as yet unclassified' stamp: 'mc 1/13/2024 01:58:48'!
createRefactoring
	"self halt."
	
	^ExtractClassRefactoring 
		from: classToRefactor 
		to: extractClassRequest newClassName
		instanceVariableNamed: extractClassRequest variableNameToAccessNewClass
		instVarToExtract: extractClassRequest instanceVariablesToExtract
		methodToExtract: extractClassRequest methodsToExtract.! !

!ExtractClassApplier methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:50'!
value
	self requestRefactoringParametersHandlingRefactoringExceptions.! !

!ExtractClassApplier methodsFor: 'refactoring - parameters request' stamp: 'mc 1/5/2024 01:23:50'!
requestRefactoringParameters

	"ver si hay que agregar check si la clase esta vacia"
"	self chooseInstanceVariable.

	instanceVariable ifNil: [^self].

	ifNilChecks := (IfNilChecksFinder on: classToRefactor for: instanceVariable) value.

	ifNilChecks ifEmpty: [^self inform: ('There are no ifNil checks on ', instanceVariable)].
"
	form := ExtractClassForm open: self.! !

!ExtractClassApplier methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
classToRefactorName
	^classToRefactor name! !

!ExtractClassApplier methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
compiledMethodAt: aMessage 
	^classToRefactor compiledMethodAt: aMessage! !

!ExtractClassApplier methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
instanceVariableList
	^classToRefactor instVarNames ! !

!ExtractClassApplier methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
selectorList
	^classToRefactor selectors sort! !

!ExtractClassApplier methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
userSubmitted: request 
	
	extractClassRequest := request.
	self createRefactoringHandlingRefactoringExceptions.
	refactoring ifNotNil: [self applyRefactoring].
	! !

!ExtractClassApplier class methodsFor: 'instance creation' stamp: 'mc 1/5/2024 01:23:50'!
applyOn: aClass 
	
	^self new initializeToApplyOn: aClass! !

!ExtractClassObjectRequest methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
instanceVariablesToExtract

	^instanceVariableListModel instanceVariablesToExtract! !

!ExtractClassObjectRequest methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
methodsToExtract
	^messageListModel methodsToExtract! !

!ExtractClassObjectRequest methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
newClassName
	^newClassNameModel actualContents asString asSymbol ! !

!ExtractClassObjectRequest methodsFor: 'accessing' stamp: 'mc 1/5/2024 01:23:50'!
variableNameToAccessNewClass
	^variableNameToAccessNewClassModel actualContents string ! !

!ExtractClassObjectRequest methodsFor: 'initialization' stamp: 'mc 1/5/2024 01:23:50'!
initializeNewWithNameModel: aNewClassNameModel methodsToMoveModel: aMessageListModel instanceVariableListModel: anInstanceVariableListModel variableNameToAccessThroughModel: aVariableNameToAccessNewClassModel 
	newClassNameModel := aNewClassNameModel.
	messageListModel := aMessageListModel.
	instanceVariableListModel := anInstanceVariableListModel.
	variableNameToAccessNewClassModel := aVariableNameToAccessNewClassModel.! !

!ExtractClassObjectRequest class methodsFor: 'instance creation' stamp: 'mc 1/5/2024 01:23:50'!
newWithNameModel: aNewClassNameModel methodsToMoveModel: aMessageListModel instanceVariableListModel: anInstanceVariableListModel variableNameToAccessThroughModel: aVariableNameToAccessNewClassModel 
	^self new 
		initializeNewWithNameModel: aNewClassNameModel 
		methodsToMoveModel: aMessageListModel 
		instanceVariableListModel: anInstanceVariableListModel 
		variableNameToAccessThroughModel: aVariableNameToAccessNewClassModel ! !

!TesisExtractClassRefactoringMenu class methodsFor: 'as yet unclassified' stamp: 'mc 1/5/2024 01:23:51'!
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

!LabeledInput methodsFor: '*ExtractClassRefactoring-as yet unclassified' stamp: 'mc 12/28/2023 12:16:43'!
withLabel: aLabel withLabelFixedWidth: aWidth withModel: aTextModel usingAs: focusMover

	| labelLayoutSpec inputMorphLayoutSpec |

	"self separation: 5."
	self layoutSpec: (LayoutSpec proportionalWidth: 1.0 fixedHeight: LabeledInput recommendedHeight).

	labelMorph := LabelMorph contents: aLabel.
	labelLayoutSpec := LayoutSpec
		fixedWidth: aWidth
		fixedHeight: labelMorph morphHeight
		offAxisEdgeWeight: #center.
	self addMorph: labelMorph layoutSpec: labelLayoutSpec.

	inputMorph := TabPassingTextModelMorph withModel: aTextModel.
	inputMorph innerTextMorph focusMover: focusMover.
	focusMover addFocusReceiver: inputMorph innerTextMorph.
	inputMorph hideScrollBarsIndefinitely.
	inputMorphLayoutSpec :=
		LayoutSpec
			proportionalWidth: 1.0
			fixedHeight: labelMorph morphHeight + 2.
	self addMorph: inputMorph layoutSpec: inputMorphLayoutSpec.



	! !

!LabeledInput class methodsFor: '*ExtractClassRefactoring-instance creation' stamp: 'mc 12/28/2023 12:13:39'!
withLabel: aLabel withLabelFixedWidth: aWidth withModel: aPreviewModel usingAs: aFocusMover

	^self newRow withLabel: aLabel withLabelFixedWidth: aWidth withModel: aPreviewModel usingAs: aFocusMover! !

!BrowserWindow methodsFor: '*ExtractClassRefactoring' stamp: 'mc 10/18/2023 01:10:37'!
contextualExtractClass

	| classToRefactor |
	"self halt."
	classToRefactor := model selectedClassOrMetaClass.

	classToRefactor ifNotNil: [(ExtractClassApplier applyOn: classToRefactor) value.].! !
