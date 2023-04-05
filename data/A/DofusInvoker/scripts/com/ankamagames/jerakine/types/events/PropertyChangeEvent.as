package com.ankamagames.jerakine.types.events
{
   import flash.events.Event;
   
   public class PropertyChangeEvent extends Event
   {
      
      public static var PROPERTY_CHANGED:String = "watchPropertyChanged";
       
      
      private var _watchedClassInstance;
      
      private var _propertyName:String;
      
      private var _propertyValue;
      
      private var _propertyOldValue;
      
      public function PropertyChangeEvent(watchedClassInstance:*, propertyName:String, propertyValue:*, propertyOldValue:*)
      {
         super(PROPERTY_CHANGED,false,false);
         this._watchedClassInstance = watchedClassInstance;
         this._propertyName = propertyName;
         this._propertyValue = propertyValue;
         this._propertyOldValue = propertyOldValue;
      }
      
      public function get watchedClassInstance() : *
      {
         return this._watchedClassInstance;
      }
      
      public function get propertyName() : String
      {
         return this._propertyName;
      }
      
      public function get propertyValue() : *
      {
         return this._propertyValue;
      }
      
      public function get propertyOldValue() : *
      {
         return this._propertyOldValue;
      }
   }
}
