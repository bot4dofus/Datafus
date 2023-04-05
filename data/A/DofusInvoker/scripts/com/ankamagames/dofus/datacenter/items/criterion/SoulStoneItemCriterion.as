package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SoulStoneItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      private static const ID_SOUL_STONE:Array = [DataEnum.ITEM_GID_SOULSTONE,DataEnum.ITEM_GID_SOULSTONE_MINIBOSS,DataEnum.ITEM_GID_SOULSTONE_BOSS];
       
      
      private var _quantityMonster:uint = 1;
      
      private var _monsterId:uint;
      
      private var _monsterName:String;
      
      public function SoulStoneItemCriterion(pCriterion:String)
      {
         super(pCriterion);
         var arrayParams:Array = String(_criterionValueText).split(",");
         if(arrayParams && arrayParams.length > 0)
         {
            if(arrayParams.length <= 2)
            {
               this._monsterId = uint(arrayParams[0]);
               this._quantityMonster = int(arrayParams[1]);
            }
         }
         else
         {
            this._monsterId = uint(_criterionValue);
         }
         this._monsterName = Monster.getMonsterById(this._monsterId).name;
      }
      
      override public function get isRespected() : Boolean
      {
         var iw:ItemWrapper = null;
         var soulStoneId:uint = 0;
         for each(iw in InventoryManager.getInstance().realInventory)
         {
            for each(soulStoneId in ID_SOUL_STONE)
            {
               if(iw.objectGID == soulStoneId)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      override public function get text() : String
      {
         return I18n.getUiText("ui.tooltip.possessSoulStone",[this._quantityMonster,this._monsterName]);
      }
      
      override public function clone() : IItemCriterion
      {
         return new SoulStoneItemCriterion(this.basicText);
      }
   }
}
