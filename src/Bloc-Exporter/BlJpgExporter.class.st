"
I export bloc elements as JPG file.

```
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipseGeometry new.
element size: 400@200.

(BlExporter jpg element: element; fileName: 'test.jpg'; export) inspect
```

"
Class {
	#name : #BlJpgExporter,
	#superclass : #BlFileExporter,
	#instVars : [
		'isProgressive',
		'quality'
	],
	#category : #'Bloc-Exporter'
}

{ #category : #'instance creation' }
BlJpgExporter >> createCanvas: anExtent [

	^ AeCanvas extent: anExtent
]

{ #category : #'api - exporting' }
BlJpgExporter >> export [
	"Answer a file reference to the exported JPG."

	^ self doExport: [ :aCanvas |
		| aForm |
		aForm := aCanvas asForm.
	
		self fileName asFileReference ensureDelete.
		PluginBasedJPEGReadWriter
			putForm: aForm
			quality: self quality
			progressiveJPEG: self isProgressive
			onFileNamed: self fileName.
		
		self fileName asFileReference ]
]

{ #category : #'api - exporting' }
BlJpgExporter >> extension [
	^ 'jpg'
]

{ #category : #initialization }
BlJpgExporter >> initialize [
	super initialize.

	isProgressive := true.
	quality := 100. "best quality"
	background := Color white
]

{ #category : #accessing }
BlJpgExporter >> isProgressive [

	^ isProgressive
]

{ #category : #accessing }
BlJpgExporter >> isProgressive: aBoolean [

	isProgressive := aBoolean
]

{ #category : #accessing }
BlJpgExporter >> quality [

	^ quality
]

{ #category : #accessing }
BlJpgExporter >> quality: aNumber [
	"Quality must be between 0 and 100"
	
	quality := aNumber
]
