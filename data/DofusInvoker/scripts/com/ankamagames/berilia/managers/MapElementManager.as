package com.ankamagames.berilia.managers
{
   import com.ankamagames.berilia.types.data.MapElement;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class MapElementManager extends EventDispatcher
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapElementManager));
      
      private static var _self:MapElementManager;
       
      
      private var _elementRef:Dictionary;
      
      public function MapElementManager()
      {
         this._elementRef = new Dictionary(true);
         super();
         if(_self != null)
         {
            throw new BeriliaError("MapElementManager is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : MapElementManager
      {
         if(_self == null)
         {
            _self = new MapElementManager();
         }
         return _self;
      }
      
      public function getElementById(id:String, owner:*) : MapElement
      {
         return !!this._elementRef[owner] ? this._elementRef[owner][id] : null;
      }
      
      public function addElementById(id:String, element:MapElement, owner:*) : void
      {
         if(!this._elementRef[owner])
         {
            this._elementRef[owner] = new Dictionary();
         }
         this._elementRef[owner][id] = element;
      }
      
      public function removeElementById(id:String, owner:*) : void
      {
         if(this._elementRef[owner] && this._elementRef[owner][id])
         {
            delete this._elementRef[owner][id];
         }
      }
      
      public function removeAllElements(owner:*) : void
      {
         var currentOwner:* = undefined;
         var i:int = 0;
         for(currentOwner in this._elementRef)
         {
            if(!owner || currentOwner == owner)
            {
               for(i = this._elementRef[currentOwner].length; i >= 0; )
               {
                  delete this._elementRef[currentOwner][i];
                  i--;
               }
            }
         }
         if(!owner)
         {
            this._elementRef = new Dictionary(true);
         }
         else
         {
            this._elementRef[owner] = new Dictionary(true);
         }
      }
      
      public function getOwnerElements(owner:*) : Dictionary
      {
         return this._elementRef[owner];
      }
   }
}
