package com.ankamagames.dofus.internalDatacenter.stats
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   import mx.utils.NameUtil;
   
   public class EntityStat extends Stat
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EntityStat));
       
      
      protected var _entityId:Number = NaN;
      
      public function EntityStat(id:Number, totalValue:Number)
      {
         super(id,totalValue);
      }
      
      public function set entityId(entityId:Number) : void
      {
         this._entityId = entityId;
      }
      
      public function get entityId() : Number
      {
         return this._entityId;
      }
      
      override protected function getFormattedMessage(message:String) : String
      {
         return NameUtil.getUnqualifiedClassName(this) + " " + _name + " (Entity ID: " + this._entityId.toString() + ", ID: " + _id.toString() + "): " + message;
      }
   }
}
