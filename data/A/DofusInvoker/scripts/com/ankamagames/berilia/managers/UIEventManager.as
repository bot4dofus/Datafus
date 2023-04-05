package com.ankamagames.berilia.managers
{
   import com.ankamagames.berilia.types.event.InstanceEvent;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class UIEventManager
   {
      
      private static var _self:UIEventManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UIEventManager));
       
      
      private var _dInstanceIndex:Dictionary;
      
      public function UIEventManager()
      {
         this._dInstanceIndex = new Dictionary(true);
         super();
         if(_self != null)
         {
            throw new BeriliaError("UIEventManager is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : UIEventManager
      {
         if(_self == null)
         {
            _self = new UIEventManager();
         }
         return _self;
      }
      
      public function get instances() : Dictionary
      {
         return this._dInstanceIndex;
      }
      
      public function registerInstance(ie:InstanceEvent) : void
      {
         this._dInstanceIndex[ie.instance] = ie;
      }
      
      public function isRegisteredInstance(target:DisplayObject, msg:* = null) : Boolean
      {
         return this._dInstanceIndex[target] && this._dInstanceIndex[target].events[getQualifiedClassName(msg)];
      }
      
      public function removeInstance(instance:*) : void
      {
         delete this._dInstanceIndex[instance];
      }
   }
}
