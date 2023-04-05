package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.items.ItemSet;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class OnlySetCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function OnlySetCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean
      {
         var item:ItemWrapper = null;
         if(_operator.text !== ItemCriterionOperator.EQUAL)
         {
            return false;
         }
         var itemSetId:uint = criterionValue as uint;
         var equipment:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("equipment").content;
         for each(item in equipment)
         {
            if(item !== null)
            {
               if(item.position === CharacterInventoryPositionEnum.ACCESSORY_POSITION_HAT || item.position === CharacterInventoryPositionEnum.ACCESSORY_POSITION_CAPE || item.position === CharacterInventoryPositionEnum.ACCESSORY_POSITION_BELT || item.position === CharacterInventoryPositionEnum.ACCESSORY_POSITION_BOOTS || item.position === CharacterInventoryPositionEnum.ACCESSORY_POSITION_AMULET || item.position === CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD || item.position === CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON || item.position === CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_LEFT || item.position === CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_RIGHT)
               {
                  if(item.itemSetId !== itemSetId)
                  {
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      override public function clone() : IItemCriterion
      {
         return new OnlySetCriterion(this.basicText);
      }
      
      override public function get text() : String
      {
         if(_operator.text !== ItemCriterionOperator.EQUAL)
         {
            return null;
         }
         var setData:ItemSet = ItemSet.getItemSetById(criterionValue as uint);
         if(setData === null)
         {
            return null;
         }
         return I18n.getUiText("ui.item.onlySpecificItemSet",[setData.name]);
      }
   }
}
