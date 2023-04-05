package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class MapItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      private var _mapId:Number;
      
      public function MapItemCriterion(pCriterion:String)
      {
         super(pCriterion);
         if(PlayedCharacterManager.getInstance().currentMap)
         {
            this._mapId = PlayedCharacterManager.getInstance().currentMap.mapId;
         }
      }
      
      override public function get text() : String
      {
         return "";
      }
      
      override public function clone() : IItemCriterion
      {
         return new MapItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         this._mapId = PlayedCharacterManager.getInstance().currentMap.mapId;
         return this._mapId;
      }
   }
}
