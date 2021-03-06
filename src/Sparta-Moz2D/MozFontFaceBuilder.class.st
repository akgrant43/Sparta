Class {
	#name : #MozFontFaceBuilder,
	#superclass : #SpartaFontFaceBuilder,
	#traits : 'TMozLibrary + TMozFontDescriptor',
	#classTraits : 'TMozLibrary classTrait + TMozFontDescriptor classTrait',
	#instVars : [
		'userFontSet'
	],
	#category : 'Sparta-Moz2D-Builders'
}

{ #category : #building }
MozFontFaceBuilder >> build [
	| aFontFace |
	self
		assert: [ familyName isNotNil and: [ familyName isNotEmpty ] ]
		description: [ 'Family name is required' ].
		
	self
		assert: [ source isNotNil ]
		description: [ 'Source is required' ].
		
	aFontFace := SpUserFontFace new
		familyName: familyName;
		source: source asSpartaFontSource;
		style: style;
		weight: weight;
		stretch: stretch;
		unicodeRange: unicodeRange.

	self userFontSet add: aFontFace
]

{ #category : #initialization }
MozFontFaceBuilder >> initialize [
	super initialize.
	
	userFontSet := MozUserFontSet new
]

{ #category : #accessing }
MozFontFaceBuilder >> stretch: aMozTextFontStretch [
	stretch := aMozTextFontStretch
]

{ #category : #accessing }
MozFontFaceBuilder >> style: aMozTextFontStyle [
	style := aMozTextFontStyle
]

{ #category : #accessing }
MozFontFaceBuilder >> userFontSet [
	<return: #MozUserFontSet>

	^ userFontSet
]
