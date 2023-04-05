package com.ankamagames.dofus.types
{
   public class IdAccessors
   {
       
      
      private var _instanceById:Function;
      
      private var _allInstances:Function;
      
      public function IdAccessors(instanceById:Function, allInstances:Function)
      {
         super();
         this._instanceById = instanceById;
         this._allInstances = allInstances;
      }
      
      public function get instanceById() : Function
      {
         return this._instanceById;
      }
      
      public function get allInstances() : Function
      {
         return this._allInstances;
      }
   }
}
