package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.datacenter.feature.OptionalFeature;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class FeatureManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FeatureManager));
      
      private static var _singleton:FeatureManager = null;
       
      
      private var _enabledFeatureIds:Vector.<int> = null;
      
      private var _featureListeners:Dictionary = null;
      
      public function FeatureManager()
      {
         super();
         _log.info("Instantiating feature manager");
         this.resetEnabledFeatures();
         this._featureListeners = new Dictionary();
      }
      
      public static function getInstance() : FeatureManager
      {
         if(_singleton === null)
         {
            _singleton = new FeatureManager();
         }
         return _singleton;
      }
      
      public function resetEnabledFeatures() : void
      {
         _log.info("Resetting enabled features");
         this._enabledFeatureIds = new Vector.<int>();
      }
      
      public function resetEnabledServerFeatures() : void
      {
         _log.info("Resetting enabled server features");
         var featureId:int = -1;
         var feature:OptionalFeature = null;
         var index:uint = 0;
         while(index < this._enabledFeatureIds.length)
         {
            featureId = this._enabledFeatureIds[index];
            feature = OptionalFeature.getOptionalFeatureById(featureId);
            if(feature === null)
            {
               _log.error("Feature with ID " + featureId.toString() + " is enabled AND null. What happened? Disabling it");
               this._enabledFeatureIds.splice(index,1);
            }
            else if(feature.isServer)
            {
               this.disableFeature(feature);
            }
            else
            {
               index++;
            }
         }
      }
      
      public function resetEnabledServerConnectionFeatures() : void
      {
         _log.info("Resetting enabled server-connection features");
         var featureId:int = -1;
         var feature:OptionalFeature = null;
         var index:uint = 0;
         while(index < this._enabledFeatureIds.length)
         {
            featureId = this._enabledFeatureIds[index];
            feature = OptionalFeature.getOptionalFeatureById(featureId);
            if(feature === null)
            {
               _log.error("Feature with ID " + featureId.toString() + " is enabled AND null. What happened? Disabling it");
               this._enabledFeatureIds.splice(index,1);
            }
            else if(feature.isClient && !feature.isServer && feature.isActivationOnServerConnection)
            {
               this.disableFeature(feature);
            }
            else
            {
               index++;
            }
         }
      }
      
      public function isFeatureWithIdEnabled(featureId:int) : Boolean
      {
         return this._enabledFeatureIds.indexOf(featureId) !== -1;
      }
      
      public function isFeatureWithKeywordEnabled(featureKeyword:String) : Boolean
      {
         var feature:OptionalFeature = OptionalFeature.getOptionalFeatureByKeyword(featureKeyword);
         if(feature === null)
         {
            _log.error("Tried to enable non-existing feature (keyword: " + featureKeyword + "). Is this an export issue? Aborting");
            return false;
         }
         return this.isFeatureEnabled(feature);
      }
      
      public function isFeatureEnabled(feature:OptionalFeature) : Boolean
      {
         if(feature === null)
         {
            _log.error("Feature instance to check is null");
            return false;
         }
         return this._enabledFeatureIds.indexOf(feature.id) !== -1;
      }
      
      public function enableFeatureWithId(featureId:int, isForce:Boolean = false) : Boolean
      {
         var feature:OptionalFeature = OptionalFeature.getOptionalFeatureById(featureId);
         if(feature === null)
         {
            _log.error("Tried to enable non-existing feature (ID: " + featureId.toString() + "). Is this an export issue? Aborting");
            return false;
         }
         return this.enableFeature(feature,isForce);
      }
      
      public function enableFeatureWithKeyword(featureKeyword:String, isForce:Boolean = false) : Boolean
      {
         var feature:OptionalFeature = OptionalFeature.getOptionalFeatureByKeyword(featureKeyword);
         if(feature === null)
         {
            _log.error("Tried to enable non-existing feature (keyword: " + featureKeyword + "). Is this an export issue? Aborting");
            return false;
         }
         return this.enableFeature(feature,isForce);
      }
      
      public function enableFeature(feature:OptionalFeature, isForce:Boolean = false) : Boolean
      {
         if(feature === null)
         {
            _log.error("Feature instance to enable is null");
            return false;
         }
         if(this.isFeatureEnabled(feature))
         {
            _log.warn(feature.toString() + " already enabled");
            return false;
         }
         if(!feature.isClient)
         {
            if(!isForce)
            {
               _log.error("Cannot enable non-client feature (" + feature.toString() + "). Aborting");
               return false;
            }
            _log.warn("Enabling non-client feature (" + feature.toString() + "). But the FORCE flag has been set");
         }
         if(!feature.canBeEnabled)
         {
            if(!isForce)
            {
               _log.error("Feature CANNOT be enabled (" + feature.toString() + "). Aborting");
               return false;
            }
            _log.warn("Feature cannot normally be enabled (" + feature.toString() + "). But the FORCE flag has been set");
         }
         this._enabledFeatureIds.push(feature.id);
         _log.info(feature.toString() + " enabled");
         this.fireFeatureActivationUpdate(feature,true);
         return true;
      }
      
      public function disableFeatureWithId(featureId:int) : Boolean
      {
         var featureIdLabel:String = null;
         var featureIdIndex:Number = NaN;
         var feature:OptionalFeature = OptionalFeature.getOptionalFeatureById(featureId);
         if(feature === null)
         {
            featureIdLabel = featureId.toString();
            _log.error("Tried to disable non-existing feature (ID: " + featureIdLabel + "). Is this an export issue?");
            featureIdIndex = this._enabledFeatureIds.indexOf(featureId);
            if(featureIdIndex !== -1)
            {
               _log.warn("Yet non-existing feature (ID: " + featureIdLabel + ") is enabled... Disabling it");
               this._enabledFeatureIds.splice(featureIdIndex,1);
               _log.warn("Non-existing feature (ID: " + featureIdLabel + ") disabled");
            }
            else
            {
               _log.warn("Non-existing feature (ID: " + featureIdLabel + ") is not enabled anyway");
            }
            return false;
         }
         return this.disableFeature(feature);
      }
      
      public function disableFeatureWithKeyword(featureKeyword:String) : Boolean
      {
         var feature:OptionalFeature = OptionalFeature.getOptionalFeatureByKeyword(featureKeyword);
         if(feature === null)
         {
            _log.error("Tried to disable non-existing feature (keyword: " + featureKeyword + "). Is this an export issue? Aborting");
            return false;
         }
         return this.disableFeature(feature);
      }
      
      public function disableFeature(feature:OptionalFeature) : Boolean
      {
         if(feature === null)
         {
            _log.error("Feature instance to disable is null");
            return false;
         }
         var featureIdIndex:Number = this._enabledFeatureIds.indexOf(feature.id);
         if(featureIdIndex === -1)
         {
            _log.warn(feature.toString() + " already disabled");
            return false;
         }
         this._enabledFeatureIds.splice(featureIdIndex,1);
         _log.info(feature.toString() + " disabled");
         this.fireFeatureActivationUpdate(feature,false);
         return true;
      }
      
      public function addListenerToFeatureWithId(featureId:int, listener:Function) : Boolean
      {
         var feature:OptionalFeature = OptionalFeature.getOptionalFeatureById(featureId);
         if(feature === null)
         {
            _log.error("Tried to listen to non-existing feature (ID: " + featureId.toString() + "). Is this an export issue? Aborting");
            return false;
         }
         return this.addListenerToFeature(feature,listener);
      }
      
      public function addListenerToFeatureWithKeyword(featureKeyword:String, listener:Function) : Boolean
      {
         var feature:OptionalFeature = OptionalFeature.getOptionalFeatureByKeyword(featureKeyword);
         if(feature === null)
         {
            _log.error("Tried to listen to non-existing feature (keyword: " + featureKeyword + "). Is this an export issue? Aborting");
            return false;
         }
         return this.addListenerToFeature(feature,listener);
      }
      
      public function addListenerToFeature(feature:OptionalFeature, listener:Function) : Boolean
      {
         var listeners:Vector.<Function> = null;
         if(feature === null)
         {
            _log.error("Feature instance to be listened to is null");
            return false;
         }
         if(listener === null)
         {
            _log.error("Listener provided is null");
            return false;
         }
         var isListenerAdded:Boolean = false;
         if(!this.isFeatureHasListener(feature,listener))
         {
            listeners = this._featureListeners[feature.id];
            if(listeners === null)
            {
               listeners = this._featureListeners[feature.id] = new Vector.<Function>();
            }
            listeners.push(listener);
            isListenerAdded = true;
         }
         if(isListenerAdded)
         {
            _log.info("Listener " + listener.prototype + " added to " + feature.toString());
         }
         else
         {
            _log.error("Listener " + listener.prototype + " could NOT added to " + feature.toString());
         }
         return isListenerAdded;
      }
      
      public function removeListenerFromFeatureWithId(featureId:int, listener:Function) : Boolean
      {
         var feature:OptionalFeature = OptionalFeature.getOptionalFeatureById(featureId);
         if(feature === null)
         {
            _log.error("Tried to remove listener from non-existing feature (ID: " + featureId.toString() + "). Is this an export issue? Aborting");
            return false;
         }
         return this.removeListenerFromFeature(feature,listener);
      }
      
      public function removeListenerFromFeatureWithKeyword(featureKeyword:String, listener:Function) : Boolean
      {
         var feature:OptionalFeature = OptionalFeature.getOptionalFeatureByKeyword(featureKeyword);
         if(feature === null)
         {
            _log.error("Tried to remove listener from non-existing feature (keyword: " + featureKeyword + "). Is this an export issue? Aborting");
            return false;
         }
         return this.removeListenerFromFeature(feature,listener);
      }
      
      public function removeListenerFromFeature(feature:OptionalFeature, listener:Function) : Boolean
      {
         var listenerIndex:Number = NaN;
         if(feature === null)
         {
            _log.error("Feature instance to remove the listener from is null");
            return false;
         }
         var isListenerRemoved:Boolean = false;
         var listeners:Vector.<Function> = this._featureListeners[feature.id];
         if(listenerIndex !== -1)
         {
            listenerIndex = this.getFeatureListenerIndex(feature,listener);
            if(listenerIndex !== -1)
            {
               listeners.splice(listenerIndex,1);
               if(listeners.length <= 0)
               {
                  listeners = null;
               }
            }
         }
         if(isListenerRemoved)
         {
            _log.info("Listener " + listener.prototype + " removed from " + feature.toString());
         }
         else
         {
            _log.error("Listener " + listener.prototype + " could NOT be removed from " + feature.toString());
         }
         return isListenerRemoved;
      }
      
      public function getEnabledFeatureKeywords() : Vector.<String>
      {
         var featureId:int = 0;
         var feature:OptionalFeature = null;
         var enabledFeatureKeywords:Vector.<String> = new Vector.<String>();
         for each(featureId in this._enabledFeatureIds)
         {
            feature = OptionalFeature.getOptionalFeatureById(featureId);
            if(feature !== null)
            {
               enabledFeatureKeywords.push(feature.keyword);
            }
            else
            {
               enabledFeatureKeywords.push(null);
            }
         }
         return enabledFeatureKeywords;
      }
      
      public function getEnabledFeatures() : Vector.<OptionalFeature>
      {
         var featureId:int = 0;
         var enabledFeatures:Vector.<OptionalFeature> = new Vector.<OptionalFeature>();
         for each(featureId in this._enabledFeatureIds)
         {
            enabledFeatures.push(OptionalFeature.getOptionalFeatureById(featureId));
         }
         return enabledFeatures;
      }
      
      public function getDisabledFeatureIds() : Vector.<int>
      {
         var optionalFeature:OptionalFeature = null;
         var optionalFeatures:Array = OptionalFeature.getAllOptionalFeatures();
         var disabledFeatureIds:Vector.<int> = new Vector.<int>();
         for each(optionalFeature in optionalFeatures)
         {
            if(optionalFeature !== null && this._enabledFeatureIds.indexOf(optionalFeature.id) === -1)
            {
               disabledFeatureIds.push(optionalFeature.id);
            }
         }
         return disabledFeatureIds;
      }
      
      public function getDisabledFeatureKeywords() : Vector.<String>
      {
         var optionalFeature:OptionalFeature = null;
         var optionalFeatures:Array = OptionalFeature.getAllOptionalFeatures();
         var disabledFeatureKeywords:Vector.<String> = new Vector.<String>();
         for each(optionalFeature in optionalFeatures)
         {
            if(optionalFeature !== null && this._enabledFeatureIds.indexOf(optionalFeature.id) === -1)
            {
               disabledFeatureKeywords.push(optionalFeature.keyword);
            }
         }
         return disabledFeatureKeywords;
      }
      
      public function getDisabledFeatures() : Vector.<OptionalFeature>
      {
         var optionalFeature:OptionalFeature = null;
         var optionalFeatures:Array = OptionalFeature.getAllOptionalFeatures();
         var disabledFeatures:Vector.<OptionalFeature> = new Vector.<OptionalFeature>();
         for each(optionalFeature in optionalFeatures)
         {
            if(optionalFeature !== null && this._enabledFeatureIds.indexOf(optionalFeature.id) === -1)
            {
               disabledFeatures.push(optionalFeature);
            }
         }
         return disabledFeatures;
      }
      
      private function isFeatureHasListener(feature:OptionalFeature, listener:Function) : Boolean
      {
         return this.getFeatureListenerIndex(feature,listener) !== -1;
      }
      
      private function getFeatureListenerIndex(feature:OptionalFeature, listener:Function) : Number
      {
         var listeners:Vector.<Function> = this._featureListeners[feature.id];
         if(listeners === null)
         {
            return -1;
         }
         if(listeners.length <= 0)
         {
            delete this._featureListeners[feature.id];
            return -1;
         }
         return listeners.indexOf(listener);
      }
      
      private function fireFeatureActivationUpdate(feature:OptionalFeature, isEnabled:Boolean) : void
      {
         var listeners:Vector.<Function> = this._featureListeners[feature.id];
         if(listeners === null)
         {
            return;
         }
         var currentListener:Function = null;
         var index:uint = 0;
         while(index < listeners.length)
         {
            currentListener = listeners[index];
            currentListener.call(null,feature.keyword,feature.id,isEnabled);
            index++;
         }
         if(listeners.length <= 0)
         {
            delete this._featureListeners[feature.id];
         }
      }
   }
}
