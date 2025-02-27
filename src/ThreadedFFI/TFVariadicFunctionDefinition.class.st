"
I represent Variadic Argument Functions.
I work the same as my superclass, with the difference that I use a different primitive. 
This primitive uses the libFFI API for variadic functions.

For compatibility reason with older VMs, If the new primitive fails, the old primitive is used instead.
"
Class {
	#name : #TFVariadicFunctionDefinition,
	#superclass : #TFFunctionDefinition,
	#instVars : [
		'fixedArgumentCount'
	],
	#category : #'ThreadedFFI-Base'
}

{ #category : #'instance creation' }
TFVariadicFunctionDefinition class >> parameterTypes: someParameters returnType: returnType [

	^ self error: 'You should use #parameterTypes:returnType:fixedArgumentCount:'
]

{ #category : #'instance creation' }
TFVariadicFunctionDefinition class >> parameterTypes: someParameters returnType: returnType abi: abiType [

	^ self error: 'You should use #parameterTypes:returnType:fixedArgumentCount:abi:'
]

{ #category : #'instance creation' }
TFVariadicFunctionDefinition class >> parameterTypes: someParameters returnType: returnType fixedArgumentCount: fixedArgumentCount [

	^ self
		  parameterTypes: someParameters
		  returnType: returnType
		  fixedArgumentCount: fixedArgumentCount
		  abi: nil
]

{ #category : #'instance creation' }
TFVariadicFunctionDefinition class >> parameterTypes: someParameters returnType: returnType fixedArgumentCount: fixedArgumentCount abi: abiType [

	^ self new
		parameterTypes: someParameters;
		returnType: returnType;
		fixedArgumentCount: fixedArgumentCount;
		abi: abiType;
		autoRelease;
		yourself
]

{ #category : #private }
TFVariadicFunctionDefinition >> doValidate: parameterHandlers [

	abi
		ifNil: [ 
			self
				primDefineFunctionWith: parameterHandlers
				returnType: returnType getHandle
				fixedArgumentsCount: fixedArgumentCount ]
		ifNotNil: [ 
			self
				primDefineFunctionWith: parameterHandlers
				returnType: returnType getHandle
				fixedArgumentsCount: fixedArgumentCount
				abi: abi ]
]

{ #category : #accessing }
TFVariadicFunctionDefinition >> fixedArgumentCount [

	^ fixedArgumentCount
]

{ #category : #accessing }
TFVariadicFunctionDefinition >> fixedArgumentCount: anObject [

	fixedArgumentCount := anObject
]

{ #category : #private }
TFVariadicFunctionDefinition >> initialize [ 
	
	super initialize.
	fixedArgumentCount := 0
]

{ #category : #primitives }
TFVariadicFunctionDefinition >> primDefineFunctionWith: parameterHandlers returnType: returnTypeHandler fixedArgumentsCount: aFixedArgumentCount [
	
	<primitive: 'primitiveDefineVariadicFunction' error: ec>

	"If the VM does not have an implementation of this primitive, we try with the non variadic version"
	^ self primDefineFunctionWith: parameterHandlers returnType: returnTypeHandler
]

{ #category : #primitives }
TFVariadicFunctionDefinition >> primDefineFunctionWith: parameterHandlers returnType: returnTypeHandler fixedArgumentsCount: aFixedArgumentCount abi: abiType [
	
	<primitive: 'primitiveDefineVariadicFunction' error: ec>

	"If the VM does not have an implementation of this primitive, we try with the non variadic version"
	^ self primDefineFunctionWith: parameterHandlers returnType: returnTypeHandler
]
