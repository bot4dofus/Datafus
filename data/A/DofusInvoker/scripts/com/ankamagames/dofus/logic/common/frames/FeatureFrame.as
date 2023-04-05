package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.dofus.datacenter.feature.OptionalFeature;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.dofus.logic.game.common.managers.InactivityManager;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.dofus.network.messages.game.approach.ServerOptionalFeaturesMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class FeatureFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FeatureFrame));
      
      private static var _instance:FeatureFrame;
       
      
      public function FeatureFrame()
      {
         super();
      }
      
      public static function getInstance() : FeatureFrame
      {
         return _instance;
      }
      
      private static function enableServerFeatures(serverFeatureIds:Vector.<uint>) : void
      {
         var featureId:uint = 0;
         var featureManager:FeatureManager = FeatureManager.getInstance();
         if(featureManager === null)
         {
            _log.error("Could not load the feature manager. Why?");
            return;
         }
         _log.info("Resetting enabled server features");
         featureManager.resetEnabledServerFeatures();
         _log.info("Activating current server features");
         for each(featureId in serverFeatureIds)
         {
            if(!featureManager.enableFeatureWithId(featureId))
            {
               _log.error("A problem occurred with the feature with an ID " + featureId.toString());
            }
         }
         _log.info("Finished activating server features");
      }
      
      private static function enableServerConnectionFeatures() : void
      {
         var featureId:uint = 0;
         var featureManager:FeatureManager = FeatureManager.getInstance();
         if(featureManager === null)
         {
            _log.error("Could not load the feature manager. Why?");
            return;
         }
         _log.info("Resetting enabled server-connection features");
         featureManager.resetEnabledServerConnectionFeatures();
         _log.info("Activating server-connection client features");
         var matchedFeatureIds:Vector.<uint> = GameDataQuery.queryEquals(OptionalFeature,"isActivationOnServerConnection",true);
         var feature:OptionalFeature = null;
         for each(featureId in matchedFeatureIds)
         {
            feature = OptionalFeature.getOptionalFeatureById(featureId);
            if(feature === null)
            {
               _log.error("Feature with ID " + featureId.toString() + " is null");
            }
            else if(!featureManager.isFeatureEnabled(feature) && feature.canBeEnabled)
            {
               featureManager.enableFeature(feature);
            }
            else
            {
               _log.info(feature.toString() + " will not be enabled on the server.");
            }
         }
         _log.info("Finished activating server-connection client features");
      }
      
      public function pushed() : Boolean
      {
         _instance = this;
         return true;
      }
      
      public function pulled() : Boolean
      {
         _instance = null;
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var sofmsg:ServerOptionalFeaturesMessage = null;
         switch(true)
         {
            case msg is ServerOptionalFeaturesMessage:
               _log.info("Receiving features from the server");
               sofmsg = msg as ServerOptionalFeaturesMessage;
               enableServerFeatures(sofmsg.features);
               enableServerConnectionFeatures();
               InactivityManager.getInstance().updateServerInactivityDelay();
               return true;
            default:
               return false;
         }
      }
      
      public function get priority() : int
      {
         return Priority.LOW;
      }
   }
}
