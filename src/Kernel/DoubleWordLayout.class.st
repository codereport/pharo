"
I am a raw data layout that holds double words (64 bit).
"
Class {
	#name : #DoubleWordLayout,
	#superclass : #BitsLayout,
	#category : #'Kernel-Layout'
}

{ #category : #'instance creation' }
DoubleWordLayout class >> extending: superLayout scope: aScope host: aClass [
	^ superLayout extendDoubleWord
		host: aClass;
		yourself
]

{ #category : #description }
DoubleWordLayout class >> subclassDefiningSymbol [
	^#variableDoubleWordSubclass:
]

{ #category : #extending }
DoubleWordLayout >> extendDoubleWord [
	^ DoubleWordLayout new
]

{ #category : #format }
DoubleWordLayout >> instanceSpecification [
	^ 9
]

{ #category : #testing }
DoubleWordLayout >> isDoubleWords [
	^ true
]
