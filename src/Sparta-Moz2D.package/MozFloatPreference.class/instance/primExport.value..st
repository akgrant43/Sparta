private - ffi
primExport: aName value: aValue

	^ self ffiCall: #(void moz_preferences_set_float (short* aName, float aValue))