Class {
	#name : #BlOutskirtsCentered,
	#superclass : #BlOutskirts,
	#category : #'Bloc-Basic-Border'
}

{ #category : #'visual bounds' }
BlOutskirtsCentered >> strokedBounds: aBlBounds of: anElement [

	^ anElement geometry strokedBoundsCentered: aBlBounds of: anElement
]

{ #category : #testing }
BlOutskirtsCentered >> wantsLayerOn: anElement [
	"Return true if background and border should be rendered on a separate layer,
	false otherwise"
	<return: #Boolean>
	
	^ anElement border isTransparent not
]
