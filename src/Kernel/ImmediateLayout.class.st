"
I am the special layout for SmallIntegers.

SmallIntegers are typically implemented as tagged pointers and thus require a special format.
"
Class {
	#name : #ImmediateLayout,
	#superclass : #ObjectLayout,
	#category : #'Kernel-Layout'
}

{ #category : #'instance creation' }
ImmediateLayout class >> extending: superLayout scope: aScope host: aClass [
	^ superLayout extendImmediate
		host: aClass;
		yourself
]

{ #category : #description }
ImmediateLayout class >> mcTypeSymbol [ 	
	^ #immediate
]

{ #category : #description }
ImmediateLayout class >> subclassDefiningSymbol [
	^#immediateSubclass:
]

{ #category : #extending }
ImmediateLayout >> extend [
	self error: 'ImmediateLayout can not be extendend'
]

{ #category : #extending }
ImmediateLayout >> extend: newScope [
	^ FixedLayout new slotScope: newScope
]

{ #category : #initialization }
ImmediateLayout >> initialize [
	super initialize.
	self host: SmallInteger.
]

{ #category : #format }
ImmediateLayout >> instanceSpecification [
	^ 7
]
