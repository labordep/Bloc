Class {
	#name : #BlInfiniteConstants,
	#superclass : #SharedPool,
	#classVars : [
		'NoId',
		'NoPosition',
		'ScrollDragging',
		'ScrollIdle',
		'ScrollSettling'
	],
	#category : #'Bloc-Infinite-Core'
}

{ #category : #initialization }
BlInfiniteConstants class >> initialize [
	super initialize.
	
	NoPosition := 0. "I am used (instead of nil) when data source position is undefined"
	NoId := 0. "I am used (instead of nil) when item id is undefined"

	ScrollIdle := #idle.
	ScrollDragging := #dragging.
	ScrollSettling := #settling
]
