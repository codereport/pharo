"
I am the default layout for objects.

I contain a fixed number of Slots.
Instances of classes using this kind of layout have always the same size.
"
Class {
	#name : #FixedLayout,
	#superclass : #PointerLayout,
	#category : #'Kernel-Layout'
}

{ #category : #'instance creation' }
FixedLayout class >> extending: superLayout scope: aScope host: aClass [
	^ (superLayout extend: aScope)
		host: aClass;
		yourself
]

{ #category : #description }
FixedLayout class >> mcTypeSymbol [ 
	^ #normal
]

{ #category : #format }
FixedLayout >> instanceSpecification [
	^ self hasFields
		ifTrue: [ 1 ]
		ifFalse: [ 0 ]
]

{ #category : #testing }
FixedLayout >> isFixedLayout [
	^true
]
