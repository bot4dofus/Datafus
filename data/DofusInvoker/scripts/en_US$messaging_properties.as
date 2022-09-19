package
{
   import mx.resources.ResourceBundle;
   
   [ExcludeClass]
   public class en_US$messaging_properties extends ResourceBundle
   {
       
      
      public function en_US$messaging_properties()
      {
         super("en_US","messaging");
      }
      
      override protected function getContent() : Object
      {
         return {
            "httpRequestError.details":"Error: {0}",
            "unknownReference":"Unknown reference {0}",
            "noAckMessage":"Didn\'t receive an acknowledge message",
            "cannotAddWhenConfigured":"Channels cannot be added to a ChannelSet that targets a configured destination.",
            "destinationWithInvalidMessageType":"Destination \'{0}\' cannot service messages of type \'{1}\'.",
            "invalidRequestMethod":"Invalid method specified.",
            "noChannelForDestination":"Destination \'{0}\' either does not exist or the destination has no channels defined (and the application does not define any default channels.)",
            "failedToSubscribe":"The consumer was not able to subscribe to its target destination.",
            "couldNotRemoveMessageFromQueue":"The message could not be removed from the message store before being sent.",
            "emptyDestinationName":"\'{0}\' is not a valid destination.",
            "couldNotAddMessageToQueue":"The message store could not store the message and the producer is not connected. The FaultEvent dispatched by the message store provides additional information.",
            "noAMFXBody":"Invalid AMFX packet. Could not find message body",
            "deliveryInDoubt":"Channel disconnected",
            "pollingNotSupportedHTTP":"StreamingHTTPChannel does not support polling. ",
            "emptySessionClientId":"Session clientId\'s must be non-zero in length.",
            "authenticationNotSupported":"Authentication not supported on DirectHTTPChannel (no proxy).",
            "unknownChannelWithId":"Channel \'{0}\' does not exist in the configuration.",
            "wrongMessageQueueForProducerDetails":"The message did not come from the message store associated with this producer.",
            "notImplementingIExternalizable":"Class {0} must implement flash.util.IExternalizable.",
            "unknownStringReference":"Unknown string reference {0}",
            "ackFailed":"Didn\'t receive an acknowledgement of message",
            "AMFXTraitsNotFirst":"Invalid object. A single set of traits must be supplied as the first entry in an object.",
            "noErrorForMessage":"Didn\'t receive an error for message",
            "failedToConnect":"The producer was not able to connect to its target destination.",
            "unknownTraitReference":"Unknown trait reference {0}",
            "producerSendErrorDetails":"The producer is not connected and the message cannot be sent.",
            "reconnectIntervalNegative":"reconnectInterval cannot take a negative value.",
            "noDestinationSpecified":"A destination name must be specified.",
            "unsupportedAMFXVersion":"Unsupported AMFX version: {0}",
            "lsoStorageNotAllowed":"The message store cannot initialize because local storage is not allowed. Please ensure that local storage is enabled for the Flash Player and that sufficient storage space is configured.",
            "couldNotLoadCache":"The cache could not be loaded into the message store.",
            "pollingNotSupportedAMF":"StreamingAMFChannel does not support polling. ",
            "couldNotSaveCache":"The cache could not be saved.",
            "couldNotClearCache":"The cache could not be cleared.",
            "cannotSetClusteredWithdNullChannelIds":"Cannot change clustered property of ChannelSet to true when it contains channels with null ids. ",
            "noAvailableChannels":"No Channels are available for use.",
            "unknownChannelClass":"The channel class \'{0}\' specified was not found.",
            "invalidURL":"Invalid URL",
            "queuedMessagesNotAllowedDetails":"This producer does not have an assigned message queue so queued messages cannot be sent.",
            "destinationNotSet":"The MessageAgent\'s destination must be set to send messages.",
            "messageQueueNotInitialized":"The message store has not been initialized.",
            "securityError":"Security error accessing url",
            "receivedNull":"Received null.",
            "requestTimedOut":"Request timed out",
            "securityError.details":"Destination: {0}",
            "producerSendError":"Send failed",
            "messageQueueFailedInitialize":"Message store initialization failed.",
            "sendFailed":"Send failed",
            "cannotConnectToDestination":"No connection could be made to the message destination.",
            "consumerSubscribeError":"Consumer subscribe error",
            "noURIAllowed":"Error for DirectHTTPChannel. No URI can be specified.",
            "noErrorForMessage.details":"Was expecting message \'{0}\' but received \'{1}\'.",
            "ackFailed.details":"Was expecting message \'{0}\' but received \'{1}\'.",
            "noServiceForMessageType":"No service is configured to handle messages of type \'{0}\'.",
            "messageQueueSendError":"Send failed",
            "resubscribeIntervalNegative":"resubscribeInterval cannot take a negative value.",
            "errorReadingIExternalizable":"Error encountered while reading IExternalizable. {0}",
            "referenceMissingId":"A reference must have an id.",
            "unknownDestination":"Unknown destination \'{0}\'.",
            "producerConnectError":"Producer connect error",
            "deliveryInDoubt.details":"Channel disconnected before an acknowledgement was received",
            "pollingIntervalNonPositive":"Channel pollingInterval may only be set to a positive value.",
            "couldNotLoadCacheIds":"The list of cache ids could not be loaded.",
            "httpRequestError":"HTTP request error",
            "pollingRequestNotAllowed":"Poll request made on \'{0}\' when polling is not enabled.",
            "noURLSpecified":"No url was specified for the channel.",
            "noAMFXNode":"Invalid AMFX packet. Content must start with an <amfx> node",
            "connectTimedOut":"Connect attempt timed out.",
            "cannotAddNullIdChannelWhenClustered":"Cannot add a channel with null id to ChannelSet when its clustered property is true.",
            "requestTimedOut.details":"The request timeout for the sent message was reached without receiving a response from the server.",
            "cannotRemoveWhenConfigured":"Channels cannot be removed from a ChannelSet that targets a configured destination.",
            "noAckMessage.details":"Was expecting mx.messaging.messages.AcknowledgeMessage, but received {0}",
            "unknownDestinationForService":"Unknown destination \'{1}\' for service with id \'{0}\'."
         };
      }
   }
}
