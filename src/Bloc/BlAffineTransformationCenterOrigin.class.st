"
I am a relative transformation origin which is attached to the center of an element.

"
Class {
	#name : #BlAffineTransformationCenterOrigin,
	#superclass : #BlAffineTransformationOrigin,
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #math }
BlAffineTransformationCenterOrigin >> originIn: anElement [

	^ anElement extent / 2.0
]
