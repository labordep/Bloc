Class {
	#name : #BlDevScripterMouseUpStep,
	#superclass : #BlDevScripterMouseStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMouseUpStep >> defaultLabel [
	^ 'Mouse up'
]

{ #category : #actions }
BlDevScripterMouseUpStep >> playOn: aScripter [
	BlOSpace simulateMouseUpOn: aScripter element at: (self getMousePositionIn: aScripter).
	aScripter pulse
]
