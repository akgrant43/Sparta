Extension { #name : #Paragraph }

{ #category : #'*Sparta-Wrapper' }
Paragraph >> drawOnWrapperCanvas: aCanvas bounds: aRectangle color: aColor [
	| wrapperDisplayScanner offset leftInRun |
	
	aCanvas clipBy: aRectangle during: [

	offset := aRectangle topLeft - positionWhenComposed.
	wrapperDisplayScanner := SpartaWrapperDisplayScanner for: self on: aCanvas canvas.
	leftInRun := 0.
	self
		forLinesIn: aCanvas clipRect
		do: [ :line | 
			line first <= line last
				ifTrue: [ leftInRun := wrapperDisplayScanner displayLine: line offset: offset leftInRun: leftInRun ] ] ]
]
