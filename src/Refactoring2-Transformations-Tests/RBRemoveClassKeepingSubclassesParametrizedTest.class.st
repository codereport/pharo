Class {
	#name : #RBRemoveClassKeepingSubclassesParametrizedTest,
	#superclass : #RBAbstractRefactoringTest,
	#category : #'Refactoring2-Transformations-Tests-Parametrized'
}

{ #category : #tests }
RBRemoveClassKeepingSubclassesParametrizedTest class >> testParameters [
	^ ParametrizedTestMatrix new
		addCase: { #rbClass -> RBRemoveClassKeepingSubclassesRefactoring };
		yourself
]

{ #category : #accessing }
RBRemoveClassKeepingSubclassesParametrizedTest >> constructor [ 
	^ #classNames:
]

{ #category : #'failure tests' }
RBRemoveClassKeepingSubclassesParametrizedTest >> testRemoveClassWithReferencesRaisesRBRefactoringError [
	self shouldFail: (self createRefactoringWithArguments:
		{#(#RBBasicLintRuleTestData )})
]

{ #category : #tests }
RBRemoveClassKeepingSubclassesParametrizedTest >> testRemoveNotEmptySuperclass [

	| refactoring class removedClass subclass |
	
	removedClass := ('RBTransformation' , 'RuleTestData1') asSymbol.
	subclass := ('RBTransformation' , 'RuleTestData2') asSymbol.
	refactoring := self createRefactoringWithArguments: { {removedClass} }. 
	class := refactoring model classNamed: subclass.
	self deny: (class directlyDefinesMethod: #foo).
	
	self executeRefactoring: refactoring.
	
	self assert: (refactoring model classNamed: removedClass) isNil.
	self assert: class superclass
		equals: (refactoring model classNamed: #RBFooLintRuleTestData1).
	self assert: (class directlyDefinesMethod: #foo)
]
