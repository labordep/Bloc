"
BlOSpace is kept to keep track of all space uses for testing/example and event simulation purpose.
It should be removed as soon as we convert all the examples as tests and move event simulation methods to a dedicated class.

"
Class {
	#name : #BlOSpace,
	#superclass : #BlSpace,
	#category : #'Bloc-Space'
}

{ #category : #'change - style' }
BlOSpace class >> doStyle: anElement [
	| theInheritedStates childSpecificStatesToInherit |
			
	theInheritedStates := BlElementStatesSet new.
	childSpecificStatesToInherit := theInheritedStates.

	anElement hasParent
		ifTrue: [
			theInheritedStates := anElement parent states statesToInherit.
			theInheritedStates do: [ :eachState | eachState prepareToPropagateFrom: anElement parent ].
			childSpecificStatesToInherit := theInheritedStates collect: [ :eachState |
				eachState propagatedStateFrom: anElement parent to: anElement ]. ].
	
	self doStyle: anElement withInheritedStates: childSpecificStatesToInherit.
	
	theInheritedStates do: [ :eachState | eachState finishedPropagateFrom: anElement ]
]

{ #category : #'change - style' }
BlOSpace class >> doStyle: anElement withInheritedStates: aCollectionOfStates [
	| theStatesToInherit allNewStates newInheritedStates |

	anElement states ifNil: [ ^ self ].
	anElement states inheritedStates: aCollectionOfStates.
	allNewStates := anElement states allStates.
	
	newInheritedStates := aCollectionOfStates intersection: allNewStates.
	newInheritedStates do: [ :eachNewInheritedState | eachNewInheritedState optionalOnAddedTo: anElement ].
	
	anElement styles applyStylesForStates: allNewStates.

	theStatesToInherit := anElement states statesToInherit.
	theStatesToInherit do: [ :eachState | eachState prepareToPropagateFrom: anElement ].

	anElement children do: [ :eachChild |
		| childSpecificStatesToInherit |

		childSpecificStatesToInherit := theStatesToInherit collect: [ :eachState |
			eachState propagatedStateFrom: anElement to: eachChild ].

		self
			doStyle: eachChild
			withInheritedStates: childSpecificStatesToInherit ].

	theStatesToInherit do: [ :eachState | eachState finishedPropagateFrom: anElement ]
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateClickOn: anElement [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	<return: #Point>
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent primary position: aPosition.
			BlMouseUpEvent primary position: aPosition }
		on: anElement.
		
	^ aPosition
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateClickOutside: anElement [
	"Simulate a click event in outside of a given element by
	performing mouse down and mouse up events in a sequence"
	| aPosition |
	
	aPosition := self locationOutside: anElement.
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent primary position: aPosition.
			BlMouseUpEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateDoubleClickOn: anElement [
	"Simulate a double click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"we simulate a double click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent primary position: aPosition.
			BlMouseUpEvent primary position: aPosition.
			BlMouseDownEvent primary position: aPosition.
			BlMouseUpEvent primary position: aPosition. }
		on: anElement
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateDragOn: anElement by: aBlVector [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	| aPosition aDelta |

	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	aDelta := (anElement localBoundsToGlobal: (BlBounds origin: 0.0@0.0 extent: aBlVector)) extent.
	
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent primary position: aPosition.
			BlMouseMoveEvent primary position: aPosition + aDelta.
			BlMouseUpEvent primary position: aPosition + aDelta }
		on: anElement
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateEvent: anEvent on: anElement [
	"I simulate a given low level space UI event such as MouseUp/MouseDown or keyboard.
	If you would like to simulate a higher level event you could directly fire or dispatch them
	by asking any element to #fireEvent: or #dispatchEvent:
	Note: UI mouse events require to set #position: given in space coordinates or in root most parent
	coordinates of the provided element.
	Note: I create a temporary space if provided element does not have one. if you need to simulate
	a sequence of dependent events it is better to use #simulateEvents:on: directy"

	self simulateEvents: { anEvent } on: anElement
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateEvents: aCollectionOfEvents on: anElement [
	"I simulate a given sequence of low level space UI events such as MouseUp/MouseDown or keyboard.
	If you would like to simulate a higher level event you could directly fire or dispatch them
	by asking any element to #fireEvent: or #dispatchEvent:
	Note: UI mouse events require to set #position: given in space coordinates or in root most parent
	coordinates of the provided element"
	
	"we should update timestamps"
	aCollectionOfEvents do: [ :anEvent | anEvent timestamp: DateAndTime now ].
	
	anElement isAttachedToSceneGraph
		ifTrue: [
			| aSpace |
			"element may be removed from the space."
			aSpace := anElement space.
			aSpace pulse.
			aCollectionOfEvents do: [ :anEvent | aSpace dispatchEvent: anEvent ].
			aSpace dispatchEvent: BlSpaceEventsProcessedEvent new.
			aSpace pulse ]
		ifFalse: [ 
			| temporarySpace topMostElement |
			topMostElement := anElement topMostParent.
			[ 
				temporarySpace := self new.
				temporarySpace root addChild: topMostElement.
				temporarySpace pulse.
				aCollectionOfEvents do: [ :anEvent | temporarySpace dispatchEvent: anEvent ].
				temporarySpace dispatchEvent: BlSpaceEventsProcessedEvent new.
				temporarySpace pulse
			] ensure: [ topMostElement removeFromParent ] ]
	
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateKeyDownOn: anElement key: aBlKeyboardKey [
	"Simulate a key down event"

	self
		simulateEvents: { BlKeyDownEvent new key: aBlKeyboardKey; scanCode: aBlKeyboardKey valueOrZero }
		on: anElement
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateKeyUpOn: anElement key: aBlKeyboardKey [
	"Simulate a key up event"

	self
		simulateEvents: { BlKeyUpEvent new key: aBlKeyboardKey; scanCode: aBlKeyboardKey valueOrZero }
		on: anElement
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateMouseDownOn: anElement [
	"Simulate a mouse down event in the middle of a given element"
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.

	self
		simulateEvents: { BlMouseDownEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateMouseDownOn: anElement at: aPoint [
	"Simulate a mouse down event at a given location in the space of the element"

	self
		simulateEvents: { BlMouseDownEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateMouseMoveInside: anElement [
	"Simulate a mouse move event at a random location within element's bounds"
	| aPosition |
	
	aPosition := self locationInside: anElement.

	self
		simulateEvents: { BlMouseMoveEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateMouseMoveOn: anElement at: aPoint [
	"Simulate a mouse move event at a given location in the space of the element"
	
	self
		simulateEvents: { BlMouseMoveEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint [
	"Simulate a mouse move event at a given location in the space of the element"
	
	self
		simulateEvents: { BlMouseMoveEvent primary
			position: aToPoint;
			delta: (aToPoint - aFromPoint)  }
		on: anElement
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateMouseMoveOutside: anElement [
	"Simulate a mouse move event at a random location outside of element's bounds"
	| aPosition |
	
	"we never know if an element was already layered out"
	aPosition := self locationOutside: anElement.
	self
		simulateEvents: { BlMouseMoveEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateMouseUpOn: anElement [
	"Simulate a mouse up event in the middle of a given element"
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.

	self
		simulateEvents: { BlMouseUpEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateMouseUpOn: anElement at: aPoint [
	"Simulate a mouse up event at a given location in the space of the element"

	self
		simulateEvents: { BlMouseUpEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateMouseWheelOn: anElement by: aBlVector [
	"Simulate a mouse wheel event in the middle of a given element"
	| aPosition aBlocEvent |

	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"Bloc event"
	aBlocEvent := BlMouseWheelEvent new
		isTouch: false;
		vector: aBlVector asBlocVector;
		position: aPosition.
	
	self
		simulateEvent: aBlocEvent
		on: anElement.
		
	^ aPosition
]

{ #category : #'debug - simulation' }
BlOSpace class >> simulateSecondaryClickOn: anElement [
	"Simulate a secondary click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	<return: #Point>
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"we simulate a secondary click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent secondary position: aPosition.
			BlMouseUpEvent secondary position: aPosition }
		on: anElement.
		
	^ aPosition
]

{ #category : #'api - adding children' }
BlOSpace >> addChild: anElement [
	"Add a given element as a direct child to the space root"
	
	self root addChild: anElement
]

{ #category : #'children - accessing' }
BlOSpace >> children [

	^ self root children
]

{ #category : #'focus managing' }
BlOSpace >> looseFocusFor: anElement [
			
	self
		deprecated: 'Please use loseFocusFor: instead.'
		transformWith:
			'`@receiver looseFocusFor: `@statements1'
				-> '`@receiver loseFocusFor: `@statements1'.
				
	self loseFocusFor: anElement
]

{ #category : #'api - adding children' }
BlOSpace >> removeChild: anElement [
	"Remove a given element from the space root"
	
	self root removeChild: anElement
]
