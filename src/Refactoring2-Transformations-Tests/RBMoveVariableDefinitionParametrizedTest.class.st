Class {
	#name : #RBMoveVariableDefinitionParametrizedTest,
	#superclass : #RBAbstractRefactoringTest,
	#category : #'Refactoring2-Transformations-Tests-Parametrized'
}

{ #category : #tests }
RBMoveVariableDefinitionParametrizedTest class >> testParameters [
	^ ParametrizedTestMatrix new
		addCase: { #rbClass -> RBMoveVariableDefinitionRefactoring };
		yourself
]

{ #category : #accessing }
RBMoveVariableDefinitionParametrizedTest >> constructor [ 
	^ #bindTight:in:selector:
]

{ #category : #'failure tests' }
RBMoveVariableDefinitionParametrizedTest >> testInvalidSelector [
	self shouldFail: (self createRefactoringWithArguments:
		{ (21 to: 24) . RBRefactoryTestDataApp . #caller3 })
]

{ #category : #tests }
RBMoveVariableDefinitionParametrizedTest >> testMoveDefinition [
	| refactoring |
	refactoring := self createRefactoringWithArguments: 
		{ (19 to: 22) . RBRefactoryTestDataApp . #moveDefinition }.
	self executeRefactoring: refactoring.

	self assert: ((refactoring model classNamed: #RBRefactoryTestDataApp) parseTreeFor: #moveDefinition) equals: (self parseMethod: 'moveDefinition
								^(self collect: 
										[:each | 
										| temp |
										temp := each printString.
										temp , temp]) 
									select: 
										[:each | 
										| temp |
										temp := each size.
										temp odd]')
]

{ #category : #tests }
RBMoveVariableDefinitionParametrizedTest >> testMoveDefinitionIntoBlockThatIsAReceiverOfACascadedMessage [
	| refactoring |
	refactoring := self createRefactoringWithArguments:
		{ (48 to: 58) . RBRefactoryTestDataApp . #referencesConditionFor: }.
	self executeRefactoring: refactoring.
	self assert: ((refactoring model classNamed: #RBRefactoryTestDataApp) parseTreeFor: #referencesConditionFor:) equals: (self parseMethod: 'referencesConditionFor: aClass 
								| environment  |
								^(RBCondition withBlock: 
										[| association |association := Smalltalk globals associationAt: aClass name
													ifAbsent: [self refactoringError: ''Could not find class''].
										environment := (self environment referencesTo: association) 
													| (self environment referencesTo: aClass name).
										environment isEmpty])
									errorMacro: aClass , '' is referenced.<n>Browse references?'';
									errorBlock: [environment openEditor];
									yourself')
]

{ #category : #'failure tests' }
RBMoveVariableDefinitionParametrizedTest >> testNoMoveDefinition [
	self shouldFail: (self createRefactoringWithArguments:
		{ (21 to: 24) . RBRefactoryTestDataApp . #noMoveDefinition })
]

{ #category : #'failure tests' }
RBMoveVariableDefinitionParametrizedTest >> testNonExistantName [
	self shouldFail:
		(self createRefactoringWithArguments: { (1 to: 10) . RBLintRuleTestData . #name1 }).
	self shouldFail:
		(self createRefactoringWithArguments: { (44 to: 54) . RBLintRuleTestData . #displayName }).
	self shouldFail:
		(self createRefactoringWithArguments: { (16 to: 25) . RBLintRuleTestData . #displayName })
]
