"
I represent a line.

I am meant to be polymorphic with Rectangle and Path and can be used as path in various operations, except clipping.

Public API and Key Messages

- from get my start point
- to get my end point

  SpartaLine from: 10@10 to: 20@20
 
Internal Representation and Key Implementation Points.

    Instance Variables
	from:		<Point>
	to:		<Point>


    Implementation Points
"
Class {
	#name : #SpartaLine,
	#superclass : #Object,
	#traits : 'TSpartaPath',
	#classTraits : 'TSpartaPath classTrait',
	#instVars : [
		'from',
		'to',
		'boundsCache'
	],
	#category : #'Sparta-Core-Path'
}

{ #category : #'instance creation' }
SpartaLine class >> from: fromPoint to: toPoint [
	^ self new
		from: fromPoint to: toPoint;
		yourself
]

{ #category : #converting }
SpartaLine >> asSpartaPathOn: aSpartaCanvas [
	"I am polymorphic with TSpartaPath and can be used directly"
	^ self
]

{ #category : #'geometry - testing' }
SpartaLine >> containsPoint: aPoint on: aSpartaCanvas [
	"Return true if a given point lies within this path as if it would be filled"
	<return: #Boolean>

	^ false
]

{ #category : #accessing }
SpartaLine >> from [
	^ from
]

{ #category : #initialization }
SpartaLine >> from: aFromPoint to: aToPoint [
	self
		assert: [ from isNil and: [ to isNil ] ]
		description: [ 'Path is immutable and can not be changed' ].

	from := aFromPoint.
	to := aToPoint
]

{ #category : #initialization }
SpartaLine >> initialize [
	super initialize.
	
	boundsCache := SpartaStrokedBoundsCache new
]

{ #category : #dispatch }
SpartaLine >> spartaClipOn: aSpartaCanvas with: aSpartaClipper [
	"When clipping by line we actually clip by rectangle that encompasses the line"
	aSpartaClipper pushRectangle: ((from min: to) corner: (from max: to))
]

{ #category : #dispatch }
SpartaLine >> spartaFillOn: aSpartaCanvas with: aSpartaFiller [
	"Line can not be filled"
]

{ #category : #dispatch }
SpartaLine >> spartaStrokeOn: aSpartaCanvas with: aSpartaStrokePainter [
	aSpartaStrokePainter strokeLine: self
]

{ #category : #'geometry - testing' }
SpartaLine >> strokeContainsPoint: aPoint options: aStrokeOptions on: aSpartaCanvas [
	"Return true if a given point lies within this path as if it would be stroked with provided stroke options"
	<return: #Boolean>

	^ (aSpartaCanvas path
		moveTo: self from;
		lineTo: self to;
		build) strokeContainsPoint: aPoint options: aStrokeOptions on: aSpartaCanvas
]

{ #category : #geometry }
SpartaLine >> strokedBoundsOn: aSpartaCanvas with: aStrokeOptions [
	"Return the bounds of the stroke of this path using the specified strokeoptions.
	These bounds are not guaranteed to be tight."
	<return: #Rectangle>

	^ boundsCache
		strokedBounds: aStrokeOptions
		ifAbsentPut: [
			(aSpartaCanvas path
				moveTo: self from;
				lineTo: self to;
				build) strokedBoundsOn: aSpartaCanvas with: aStrokeOptions ]
]

{ #category : #accessing }
SpartaLine >> to [
	^ to
]
