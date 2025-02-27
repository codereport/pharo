"
It represents the abstract class of a `SignalLogger` that takes the signals going through the `Beacon` and actually does something useful.

The subclasses provide concrete implementations. Each of these sublasses can be used both by directly instantiating the class, or by using the `instance` class variable which holds a global instance of that class.
The global instance of a signal logger is useful to provide a simple means to start and stop without worrying about the instance.

For example, consider:

```
   TranscriptLogger start.
   StringSignal emit: 'test'.
   ...
   TranscriptLogger stop.
```	
Passing stop, unsubscribes the global instance of `TranscriptLogger` from the central `Beacon` instance without having to remember the `TranscriptLogger` object.

One can get signals go to a given logger during the execution of a block with:

```
   (MemoryLogger named: 'loggerA')
       runDuring: [ 
         'Hello' asBeaconSignal emit.
         42 asBeaconSignal emit.
         ContextStackSignal emit.
         ];
       recordings.
```		
This can be done for a specific set of signals with:

```
   (MemoryLogger named: 'loggerA')
      runFor: StringSignal, WrapperSignal 
      during: [ 
         'Hello' asBeaconSignal emit.
         42 asBeaconSignal emit.
         StringSignal emit: 'let me pass'
         ];
      recordings.
```
		
It is possible to have signals go to several loggers by nesting `#runDuring:` blocks.
Now this is not replacing a composite logger.

"
Class {
	#name : #SignalLogger,
	#superclass : #Object,
	#instVars : [
		'beacon',
		'name'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Beacon-Core-Loggers'
}

{ #category : #'instance creation' }
SignalLogger class >> for: aBeacon [
	^ self new 
		beacon: aBeacon
]

{ #category : #accessing }
SignalLogger class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #testing }
SignalLogger class >> isAbstract [

	^ self == SignalLogger
]

{ #category : #accessing }
SignalLogger class >> named: aString [
	^ (Beacon loggersOf: self)
		detect: [ :each | each name = aString ]
		ifNone: [ self new name: aString ]
]

{ #category : #accessing }
SignalLogger class >> resetAllInstances [
	self withAllSubclassesDo: [ :each | each resetInstance ]
]

{ #category : #accessing }
SignalLogger class >> resetInstance [
	instance := nil
]

{ #category : #registering }
SignalLogger class >> runDuring: aBlock [
	^ self instance runDuring: aBlock
]

{ #category : #registering }
SignalLogger class >> start [
	^ self instance start
]

{ #category : #registering }
SignalLogger class >> startFor: anAnnouncementOrASetOfAnnouncements [
	"Start listening to announcements. 
	logger startFor: StringSignal 
	
	to scope the listening consider using 
	logger runFor: StringSignal during: [ ... ]"
	
	^ self instance startFor: anAnnouncementOrASetOfAnnouncements 

]

{ #category : #convenience }
SignalLogger class >> startSingleGlobalLogger [
	"Stop any other loggers and start a global instances of the receiver"

	SignalLogger 
		stopAll;
		resetAllInstances.
	self start.
]

{ #category : #registering }
SignalLogger class >> stop [
	^ self instance stop
]

{ #category : #registering }
SignalLogger class >> stopAll [
	self withAllSubclassesDo: #stop
]

{ #category : #accessing }
SignalLogger >> beacon [
	^ beacon
]

{ #category : #accessing }
SignalLogger >> beacon: anAnnouncer [
	beacon := anAnnouncer
]

{ #category : #initialize }
SignalLogger >> initialize [
	super initialize.
	"by default we hook to the central ==Beacon== instance"
	beacon := Beacon instance.
	name := 'unnamed'
]

{ #category : #testing }
SignalLogger >> isRunning [
	Beacon instance announcer subscriptions 
		subscriptionsOf: self do: [ :x | ^ true ].
	^ false
]

{ #category : #accessing }
SignalLogger >> name [
	^ name
]

{ #category : #accessing }
SignalLogger >> name: aString [
	name := aString
]

{ #category : #registering }
SignalLogger >> nextPut: aSignal [
	"Gets a BeaconSignal into the logger"
	self subclassResponsibility 
]

{ #category : #registering }
SignalLogger >> nextPutAll: aCollection [
	
	aCollection do: [ :each | self nextPut: each ]
]

{ #category : #printing }
SignalLogger >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' named: ';
		nextPutAll: name asString
]

{ #category : #registering }
SignalLogger >> runDuring: aBlock [
	"make all BeaconSignals go to me during aBlock"
	self start.
	[ aBlock value ]
		ensure: [ self stop ]

]

{ #category : #registering }
SignalLogger >> runFor: anAnnouncementOrASetOfAnnouncements during: aBlock [
	"Makes all provided BeaconSignals got to me during aBlock.
	
	logger runFor: StringSignal during: [ ... ]"
	
	self startFor: anAnnouncementOrASetOfAnnouncements.
	[ aBlock value ]
		ensure: [ self stop ]

]

{ #category : #registering }
SignalLogger >> start [
	self startFor: BeaconSignal 
]

{ #category : #registering }
SignalLogger >> startFor: anAnnouncementOrASetOfAnnouncements [
	"Make sure that when anAnnouncementOrASetOfAnnouncements is signaled, I receive them as argument of nextPut:."
	self isRunning ifTrue: [ self stop ].
	self beacon 	
		when: anAnnouncementOrASetOfAnnouncements
		send: #nextPut:
		to: self
]

{ #category : #registering }
SignalLogger >> stop [
	self beacon unsubscribe: self
]
