Class {
	#name : #BaselineOfUnifiedFFI,
	#superclass : #BaselineOf,
	#instVars : [
		'initializersEnabled'
	],
	#classVars : [
		'Initialized'
	],
	#category : #BaselineOfUnifiedFFI
}

{ #category : #baseline }
BaselineOfUnifiedFFI >> baseline: spec [
	<baseline>
	
	spec for: #common do: [
		spec preLoadDoIt: #'preload:package:'.
		spec postLoadDoIt: #'postload:package:'.
		spec 
			"unified ffi"
			package: 'UnifiedFFI';
			package: 'UnifiedFFI-Tests' with: [ spec requires: #('UnifiedFFI') ];
			package: 'UnifiedFFI-Legacy' with: [ spec requires: #('UnifiedFFI') ];
			package: 'System-OSEnvironments' with: [ spec requires: #('UnifiedFFI') ].
			
		spec 
			group: 'default' with: #('core' 'legacy');
			group: 'minimal' with: #('UnifiedFFI' 'System-OSEnvironments');
			group: 'core' with: #('minimal' 'UnifiedFFI-Tests');
			group: 'legacy' with: #('UnifiedFFI-Legacy') ]
]

{ #category : #actions }
BaselineOfUnifiedFFI >> postload: loader package: packageSpec [

	"Ignore pre and post loads if already executed"
	Initialized = true ifTrue: [ ^ self ].

	MCMethodDefinition initializersEnabled: initializersEnabled.
	
	
]

{ #category : #actions }
BaselineOfUnifiedFFI >> preload: loader package: packageSpec [

	"Ignore pre and post loads if already executed"
	Initialized = true ifTrue: [ ^ self ].

	initializersEnabled := MCMethodDefinition initializersEnabled.
	MCMethodDefinition initializersEnabled: true.
	

	

]
