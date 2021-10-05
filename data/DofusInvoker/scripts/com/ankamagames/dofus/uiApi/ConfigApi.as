package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.types.AtouinOptions;
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.ThemeManager;
   import com.ankamagames.berilia.types.BeriliaOptions;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.dofus.datacenter.feature.OptionalFeature;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.logic.common.frames.MiscFrame;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.options.ChatOptions;
   import com.ankamagames.dofus.misc.utils.errormanager.DofusErrorHandler;
   import com.ankamagames.dofus.types.DofusOptions;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.tiphon.engine.Tiphon;
   import com.ankamagames.tiphon.types.TiphonOptions;
   import com.ankamagames.tubul.types.TubulOptions;
   import flash.geom.Point;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class ConfigApi implements IApi
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ConfigApi));
      
      private static var _init:Boolean = false;
      
      private static var _count:int = 0;
       
      
      private var _module:UiModule;
      
      public function ConfigApi()
      {
         super();
         this.init();
      }
      
      private static function onPropertyChanged(e:PropertyChangeEvent) : void
      {
         var className:String = null;
         var newValue:* = e.propertyValue;
         var oldValue:* = e.propertyOldValue;
         switch(true)
         {
            case e.watchedClassInstance is AtouinOptions:
               className = "atouin";
               break;
            case e.watchedClassInstance is DofusOptions:
               className = "dofus";
               break;
            case e.watchedClassInstance is BeriliaOptions:
               className = "berilia";
               break;
            case e.watchedClassInstance is TiphonOptions:
               className = "tiphon";
               break;
            case e.watchedClassInstance is TubulOptions:
               className = "soundmanager";
               break;
            case e.watchedClassInstance is ChatOptions:
               className = "chat";
               break;
            default:
               className = getQualifiedClassName(e.watchedClassInstance);
         }
         KernelEventsManager.getInstance().processCallback(HookList.ConfigPropertyChange,className,e.propertyName,newValue,oldValue);
      }
      
      [ApiData(name="module")]
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      public function destroy() : void
      {
         --_count;
         if(_count <= 0)
         {
            _count = 0;
            Atouin.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,onPropertyChanged);
            Dofus.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,onPropertyChanged);
            Tiphon.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,onPropertyChanged);
         }
         this._module = null;
         _init = false;
      }
      
      public function getConfigProperty(configModuleName:String, propertyName:String) : *
      {
         var target:* = OptionManager.getOptionManager(configModuleName);
         if(!target)
         {
            throw new ApiError("Config module [" + configModuleName + "] does not exist.");
         }
         if(target && this.isSimpleConfigType(target.getOption(propertyName)))
         {
            return target.getOption(propertyName);
         }
         return null;
      }
      
      public function setConfigProperty(configModuleName:String, propertyName:String, value:*) : void
      {
         var target:OptionManager = OptionManager.getOptionManager(configModuleName);
         if(!target)
         {
            throw new ApiError("Config module [" + configModuleName + "] does not exist.");
         }
         if(this.isSimpleConfigType(target.getDefaultValue(propertyName)))
         {
            target.setOption(propertyName,value);
            return;
         }
         throw new ApiError(propertyName + " cannot be set in config module " + configModuleName + ".");
      }
      
      public function resetConfigProperty(configModuleName:String, propertyName:String) : void
      {
         if(!OptionManager.getOptionManager(configModuleName))
         {
            throw ApiError("Config module [" + configModuleName + "] does not exist.");
         }
         OptionManager.getOptionManager(configModuleName).restaureDefaultValue(propertyName);
      }
      
      [NoBoxing]
      public function createOptionManager(name:String) : OptionManager
      {
         return new OptionManager(name);
      }
      
      public function getAllThemes() : Array
      {
         return ThemeManager.getInstance().getThemes();
      }
      
      public function getCurrentTheme() : String
      {
         return ThemeManager.getInstance().currentTheme;
      }
      
      public function enableFeatureWithId(featureId:int) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.enableFeatureWithId(featureId);
      }
      
      public function enableFeatureWithKeyword(featureKeyword:String) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.enableFeatureWithKeyword(featureKeyword);
      }
      
      public function enableFeature(feature:OptionalFeature) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.enableFeature(feature);
      }
      
      public function disableFeatureWithId(featureId:int) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.disableFeatureWithId(featureId);
      }
      
      public function disableFeatureWithKeyword(featureKeyword:String) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.disableFeatureWithKeyword(featureKeyword);
      }
      
      public function disableFeature(feature:OptionalFeature) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.disableFeature(feature);
      }
      
      public function isFeatureEnabled(feature:OptionalFeature) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.isFeatureEnabled(feature);
      }
      
      public function isFeatureWithIdEnabled(featureId:int) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.isFeatureWithIdEnabled(featureId);
      }
      
      public function isFeatureWithKeywordEnabled(featureKeyword:String) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.isFeatureWithKeywordEnabled(featureKeyword);
      }
      
      public function addListenerToFeatureWithId(featureId:int, listener:Function) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.addListenerToFeatureWithId(featureId,listener);
      }
      
      public function addListenerToFeatureWithKeyword(featureKeyword:String, listener:Function) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.addListenerToFeatureWithKeyword(featureKeyword,listener);
      }
      
      public function addListenerToFeature(feature:OptionalFeature, listener:Function) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.addListenerToFeature(feature,listener);
      }
      
      public function removeListenerFromFeatureWithId(featureId:int, listener:Function) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.removeListenerFromFeatureWithId(featureId,listener);
      }
      
      public function removeListenerFromFeatureWithKeyword(featureKeyword:String, listener:Function) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.removeListenerFromFeatureWithKeyword(featureKeyword,listener);
      }
      
      public function removeListenerFromFeature(feature:OptionalFeature, listener:Function) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         return featureManager !== null && featureManager.removeListenerFromFeature(feature,listener);
      }
      
      public function getServerConstant(id:int) : Object
      {
         return MiscFrame.getInstance().getServerSessionConstant(id);
      }
      
      public function getExternalNotificationOptions(pNotificationType:int) : Object
      {
         return ExternalNotificationManager.getInstance().getNotificationOptions(pNotificationType);
      }
      
      public function setExternalNotificationOptions(pNotificationType:int, pOptions:Object, pSynchronizeMultiAccountOptions:Boolean = true) : void
      {
         ExternalNotificationManager.getInstance().setNotificationOptions(pNotificationType,pOptions,pSynchronizeMultiAccountOptions);
      }
      
      public function synchronizeExternalNotificationsMultiAccount() : void
      {
         ExternalNotificationManager.getInstance().synchronizeMultiAccountOptions();
      }
      
      public function setDebugMode(activate:Boolean) : void
      {
         DofusErrorHandler.debugManuallyActivated = activate;
         if(activate)
         {
            DofusErrorHandler.activateDebugMode();
         }
      }
      
      public function getDebugMode() : Boolean
      {
         return DofusErrorHandler.debugManuallyActivated;
      }
      
      public function debugFileExists() : Boolean
      {
         return DofusErrorHandler.debugFileExists;
      }
      
      private function init() : void
      {
         ++_count;
         if(_init)
         {
            return;
         }
         _init = true;
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,onPropertyChanged);
         Dofus.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,onPropertyChanged);
         Tiphon.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,onPropertyChanged);
      }
      
      private function isSimpleConfigType(value:*) : Boolean
      {
         switch(true)
         {
            case value is int:
            case value is uint:
            case value is Number:
            case value is Boolean:
            case value is String:
            case value is Point:
               return true;
            default:
               return false;
         }
      }
   }
}
