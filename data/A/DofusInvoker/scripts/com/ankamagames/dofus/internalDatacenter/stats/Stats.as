package com.ankamagames.dofus.internalDatacenter.stats
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   
   public class Stats implements IDataCenter
   {
       
      
      protected var _stats:Dictionary;
      
      public function Stats()
      {
         super();
      }
      
      public function get stats() : Dictionary
      {
         return this._stats;
      }
      
      protected function get isVerbose() : Boolean
      {
         return false;
      }
      
      protected function getFormattedMessage(message:String) : String
      {
         return "";
      }
      
      public function getStat(statId:Number) : Stat
      {
         if(!(statId in this._stats))
         {
            return null;
         }
         return this._stats[statId.toString()];
      }
      
      public function getStatsNumber() : Number
      {
         var statKey:* = null;
         var counter:Number = 0;
         for(statKey in this._stats)
         {
            counter++;
         }
         return counter;
      }
      
      public function hasStat(statId:Number) : Boolean
      {
         return statId.toString() in this._stats;
      }
      
      public function getStatTotalValue(statId:Number) : Number
      {
         var key:String = statId.toString();
         if(!(statId in this._stats))
         {
            return 0;
         }
         var stat:Stat = this._stats[key];
         return stat !== null ? Number(stat.totalValue) : Number(0);
      }
      
      public function getStatAdditionalValue(statId:Number) : Number
      {
         return 0;
      }
      
      public function getStatObjectsAndMountBonusValue(statId:Number) : Number
      {
         return 0;
      }
      
      public function getStatAlignGiftBonusValue(statId:Number) : Number
      {
         return 0;
      }
      
      public function getStatContextModifValue(statId:Number) : Number
      {
         return 0;
      }
      
      public function getStatUsedValue(statId:Number) : Number
      {
         return 0;
      }
   }
}
