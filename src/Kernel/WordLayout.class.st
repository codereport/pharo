"
I am a raw data layout that holds words (32 bits ).
"
Class {
	#name : #WordLayout,
	#superclass : #BitsLayout,
	#category : #'Kernel-Layout'
}

{ #category : #'instance creation' }
WordLayout class >> extending: superLayout scope: aScope host: aClass [
	^ superLayout extendWord
		host: aClass;
		yourself
]

{ #category : #description }
WordLayout class >> mcTypeSymbol [ 
	^ #words
]

{ #category : #description }
WordLayout class >> subclassDefiningSymbol [
	^#variableWordSubclass:
]

{ #category : #accessing }
WordLayout >> bytesPerSlot [
	
	^ 4
]

{ #category : #extending }
WordLayout >> extendWord [
	^ WordLayout new
]

{ #category : #format }
WordLayout >> instanceSpecification [
	^ 10
]

{ #category : #testing }
WordLayout >> isWords [
	^ true
]
