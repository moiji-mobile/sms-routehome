as yet unclassified
modifySubscriber: aSubscriber

	"We want all SMS to be sent to us. All the time as we can't know if the final
	link will be up or not"
	^aSubscriber
			vlrNumber: homeRoutingServer mscNumber;
			mscNumber: homeRoutingServer mscNumber;
			yourself.