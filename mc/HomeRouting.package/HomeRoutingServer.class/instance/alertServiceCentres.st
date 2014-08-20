as yet unclassified
alertServiceCentres
	| now toAlert |
	
	"TODO: Maybe add a semaphore"
	self flag: #todo.
	
	"Cancel the timer just in case it is running."
	pendingAlertsTimer ifNotNil: [pendingAlertsTimer cancel].
	now := DateAndTime now.
	toAlert := OrderedCollection new.

	"Select which service centres to try to alert."
	pendingAlerts do: [:each |
		(each isExpired: now)
			ifTrue: [
				pendingAlerts remove: each.
				toAlert add: each]].

	"Now alert all service centres"
	toAlert do: [:each |
		self alertServiceCentre: each].

	"Start the timer again"
	pendingAlertsTimer := TimerScheduler instance scheduleInSeconds: 60 block: [self alertServiceCentres].