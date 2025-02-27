Class {
	#name : #BlHandlerAnnouncementSubscription,
	#superclass : #Object,
	#instVars : [
		'subscriber'
	],
	#category : #'Bloc-Events-Dispatcher'
}

{ #category : #comparing }
BlHandlerAnnouncementSubscription >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject class = self class)
		ifFalse: [ ^ false ].
	^ anotherObject subscriber = self subscriber
]

{ #category : #accessing }
BlHandlerAnnouncementSubscription >> announcementClass [
	"Polymorphic to ${method:AnnouncementSubscription>>#announcementClass}$"
	^ self class
]

{ #category : #announcing }
BlHandlerAnnouncementSubscription >> deliver: anAnnouncement [

	(self handlesAnnouncement: anAnnouncement)
		ifTrue: [ self subscriber handleEvent: anAnnouncement ]
]

{ #category : #testing }
BlHandlerAnnouncementSubscription >> handlesAnnouncement: anAnnouncement [
	<return: #Boolean>

	^ self subscriber wantsEvent: anAnnouncement
]

{ #category : #comparing }
BlHandlerAnnouncementSubscription >> hash [
	^ self class hash bitXor: self subscriber hash
]

{ #category : #accessing }
BlHandlerAnnouncementSubscription >> subscriber [
	<return: #BlBasicEventHandler>

	^ subscriber
]

{ #category : #accessing }
BlHandlerAnnouncementSubscription >> subscriber: aTBlEventHandler [
	subscriber := aTBlEventHandler
]
