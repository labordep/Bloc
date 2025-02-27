Trait {
	#name : #TBlElementProperties,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #adding }
TBlElementProperties >> addProperty: aBlElementProperty [
	self explicitRequirement
]

{ #category : #'api - properties' }
TBlElementProperties >> background: aPaint [
	self addProperty: (BlElementBackgroundProperty new background: aPaint)
]

{ #category : #'api - properties' }
TBlElementProperties >> border: aBlBorder [
	self addProperty: (BlElementBorderProperty new border: aBlBorder)
]

{ #category : #'api - properties' }
TBlElementProperties >> do: anApplyBlock [
	self do: anApplyBlock after: [  ]
]

{ #category : #'api - properties' }
TBlElementProperties >> do: anApplyBlock after: aCleanBlock [
	self addProperty: (BlElementDynamicProperty new
		applyAction: anApplyBlock;
		cleanAction: aCleanBlock)
]

{ #category : #'api - properties constraints' }
TBlElementProperties >> effect: aBlEffect [
	self addProperty: (BlElementEffectProperty new effect: aBlEffect)
]

{ #category : #'api - properties font' }
TBlElementProperties >> fontSize: aBlElementPropertyLength [
	self addProperty: (BlElementFontSizeProperty new fontSize: aBlElementPropertyLength)
]

{ #category : #'api - properties font' }
TBlElementProperties >> fontSizeEm: aNumber [
	self fontSize: (BlValueWithUnit em: aNumber)
]

{ #category : #'api - properties font' }
TBlElementProperties >> fontSizePt: aNumber [
	self fontSize: (BlValueWithUnit pt: aNumber)
]

{ #category : #'api - properties font' }
TBlElementProperties >> fontSizeRem: aNumber [
	self fontSize: (BlValueWithUnit rem: aNumber)
]

{ #category : #'api - properties' }
TBlElementProperties >> foreground: aPaint [
	self addProperty: (BlElementForegroundProperty new foreground: aPaint)
]

{ #category : #'api - properties' }
TBlElementProperties >> geometry: aBlElementGeometry [
	self addProperty: (BlElementGeometryProperty new geometry: aBlElementGeometry)
]

{ #category : #'api - properties' }
TBlElementProperties >> gone [
	self visibility: BlVisibility gone
]

{ #category : #'api - properties layout' }
TBlElementProperties >> hExact: aWidth [
	self addProperty: (BlElementLayoutHorizontalResizerProperty new exact: aWidth)
]

{ #category : #'api - properties layout' }
TBlElementProperties >> hFitContent [
	self addProperty: (BlElementLayoutHorizontalResizerProperty new fitContent)
]

{ #category : #'api - properties layout' }
TBlElementProperties >> hFitContentLimited [
	self addProperty: (BlElementLayoutHorizontalResizerProperty new fitContentLimited)
]

{ #category : #'api - properties layout' }
TBlElementProperties >> hMatchParent [
	self addProperty: (BlElementLayoutHorizontalResizerProperty new matchParent)
]

{ #category : #'api - properties' }
TBlElementProperties >> hidden [
	self visibility: BlVisibility hidden
]

{ #category : #'api - properties' }
TBlElementProperties >> layout: aBlLayout [
	self addProperty: (BlElementLayoutProperty new layout: aBlLayout)
]

{ #category : #'api - properties constraints' }
TBlElementProperties >> margin: aBlInsets [
	self addProperty: (BlElementMarginProperty new margin: aBlInsets)
]

{ #category : #'api - properties constraints' }
TBlElementProperties >> padding: aBlInsets [
	self addProperty: (BlElementPaddingProperty new padding: aBlInsets)
]

{ #category : #'api - properties' }
TBlElementProperties >> scaleBy: aNumber [
	self addProperty: (BlElementTransformationScaleProperty new scaleFactor: aNumber)
]

{ #category : #'api - properties layout' }
TBlElementProperties >> vExact: aHeight [
	self addProperty: (BlElementLayoutVerticalResizerProperty new exact: aHeight)
]

{ #category : #'api - properties layout' }
TBlElementProperties >> vFitContent [
	self addProperty: (BlElementLayoutVerticalResizerProperty new fitContent)
]

{ #category : #'api - properties layout' }
TBlElementProperties >> vFitContentLimited [
	self addProperty: (BlElementLayoutVerticalResizerProperty new fitContentLimited)
]

{ #category : #'api - properties layout' }
TBlElementProperties >> vMatchParent [
	self addProperty: (BlElementLayoutVerticalResizerProperty new matchParent)
]

{ #category : #'api - properties' }
TBlElementProperties >> visibility: aBlVisibility [
	self addProperty: (BlElementVisibilityProperty new visibility: aBlVisibility)
]

{ #category : #'api - properties' }
TBlElementProperties >> visible [
	self visibility: BlVisibility visible
]
