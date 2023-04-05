package com.ankamagames.dofus.datacenter.quest.objectives
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public class QuestObjectiveParameters extends Proxy
   {
       
      
      public var numParams:uint;
      
      public var parameter0:int;
      
      public var parameter1:int;
      
      public var parameter2:int;
      
      public var parameter3:int;
      
      public var parameter4:int;
      
      public var dungeonOnly:Boolean;
      
      public function QuestObjectiveParameters()
      {
         super();
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         var propertyName:String = QName(name).localName;
         if(!isNaN(parseInt(propertyName)))
         {
            return this["parameter" + propertyName];
         }
         return this[propertyName];
      }
      
      public function get length() : uint
      {
         return this.numParams;
      }
   }
}
