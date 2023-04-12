package com.ankamagames.dofus.internalDatacenter.alterations
{
   public class AlterationsDescr
   {
       
      
      private var _alterations:Vector.<AlterationWrapper> = null;
      
      public function AlterationsDescr(alterations:Vector.<AlterationWrapper>)
      {
         super();
         this._alterations = alterations;
      }
      
      public function get alterations() : Vector.<AlterationWrapper>
      {
         return this._alterations;
      }
   }
}
