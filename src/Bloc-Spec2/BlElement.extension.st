Extension { #name : #BlElement }

{ #category : #'*Bloc-Spec2' }
BlElement >> asPreviewMorph [

	self flag: #todo. "Dependency to Bloc-Alexandrie."
	^ self aeAsForm asMorph
]

{ #category : #'*Bloc-Spec2' }
BlElement >> inspectionPreview: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Preview'>

	^ aBuilder newMorph
		morph: self asPreviewMorph;
		yourself
]

{ #category : #'*Bloc-Spec2' }
BlElement >> inspectionResizers: aBuilder [
	<inspectorPresentationOrder: 4 title: 'Resizers'>

	^ aBuilder newTable
		items: self withAllParents reversed;
		addColumn: (SpStringTableColumn
			title: 'Width'
			evaluated: [ :anElement | anElement constraints horizontal resizer ]);
		addColumn: (SpStringTableColumn
			title: 'Height'
			evaluated: [ :anElement | anElement constraints vertical resizer ]);
		addColumn: (SpStringTableColumn
			title: 'Layout'
			evaluated: [ :anElement | anElement layout ]);
		addColumn: (SpStringTableColumn
			title: 'Element'
			evaluated: [ :anElement | anElement ]);
		yourself
]

{ #category : #'*Bloc-Spec2' }
BlElement >> inspectionStates: aBuilder [
	<inspectorPresentationOrder: 5 title: 'States'>

	^ self states inspectionItems: aBuilder
]

{ #category : #'*Bloc-Spec2' }
BlElement >> inspectionTree: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Tree'>

	^ aBuilder newTree
		roots: { self };
		children: [ :each | each children ];
		expandRoots;
		yourself

]

{ #category : #'*Bloc-Spec2' }
BlElement >> inspectionUserData: aBuilder [
	<inspectorPresentationOrder: 3 title: 'User Data'>

	^ self userData inspectionItems: aBuilder 
]
