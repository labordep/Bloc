"
I provide text measurement in an off-screen canvas.

For time efficiency, I implement the singleton pattern, to reuse an instance along a Pharo session.
"
Class {
	#name : #BAOffscreen,
	#superclass : #Object,
	#instVars : [
		'session',
		'aeCanvas',
		'textMeasurer'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Bloc-Alexandrie-Utility'
}

{ #category : #accessing }
BAOffscreen class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
BAOffscreen class >> resetInstance [
	<script>

	instance := nil
]

{ #category : #api }
BAOffscreen >> canvas [

	self ensureReady.
	^ aeCanvas
]

{ #category : #api }
BAOffscreen >> ensureReady [

	session == Smalltalk session ifTrue: [ ^ self ].
	session := Smalltalk session.

	aeCanvas := AeCanvas extent: 1 asPoint.

	textMeasurer := BACanvasTextMeasurer new
							canvas: aeCanvas;
							yourself
]

{ #category : #api }
BAOffscreen >> measureTextParagraph: aBlTextParagraph [

	self textMeasurer measureTextParagraph: aBlTextParagraph
]

{ #category : #api }
BAOffscreen >> textMeasurer [

	self ensureReady.
	^ textMeasurer
]
