package com.ankamagames.dofus.internalDatacenter.stats
{
   import com.ankamagames.dofus.network.types.game.Uuid;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   import mx.utils.NameUtil;
   
   public class PresetStat extends Stat
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EntityStat));
       
      
      protected var _presetId:Uuid;
      
      public function PresetStat(id:Number, totalValue:Number)
      {
         super(id,totalValue);
      }
      
      public function set presetId(presetId:Uuid) : void
      {
         this._presetId = presetId;
      }
      
      public function get presetId() : Uuid
      {
         return this._presetId;
      }
      
      override protected function getFormattedMessage(message:String) : String
      {
         return NameUtil.getUnqualifiedClassName(this) + " " + _name + " (Preset ID: " + this._presetId.uuidString + ", ID: " + _id.toString() + "): " + message;
      }
   }
}
