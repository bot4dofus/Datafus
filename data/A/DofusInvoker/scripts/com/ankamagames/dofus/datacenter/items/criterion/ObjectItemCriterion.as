package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   
   public class ObjectItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      private var _criterionValueQuantity:int = -1;
      
      public function ObjectItemCriterion(pCriterion:String)
      {
         var itemIdAndQuantity:Array = null;
         super(pCriterion);
         if(_criterionValue == 0 && _criterionValueText.indexOf(",") != -1)
         {
            itemIdAndQuantity = _criterionValueText.split(",");
            _criterionValue = int(itemIdAndQuantity[0]);
            this._criterionValueQuantity = int(itemIdAndQuantity[1]);
            if(this._criterionValueQuantity == 0 && String(itemIdAndQuantity[1]).indexOf("0") == -1)
            {
               this._criterionValueQuantity = -1;
            }
         }
      }
      
      override public function get isRespected() : Boolean
      {
         var iw:ItemWrapper = null;
         var equippedItems:Vector.<ItemWrapper> = null;
         var equipped:Boolean = false;
         var item:ItemWrapper = null;
         var itemQuantity:uint = 0;
         for each(iw in InventoryManager.getInstance().realInventory)
         {
            if(iw.objectGID == _criterionValue)
            {
               itemQuantity = iw.quantity;
               break;
            }
         }
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               return this._criterionValueQuantity == -1 ? itemQuantity > 0 : itemQuantity == this._criterionValueQuantity;
            case ItemCriterionOperator.DIFFERENT:
               return this._criterionValueQuantity == -1 ? itemQuantity == 0 : itemQuantity != this._criterionValueQuantity;
            case ItemCriterionOperator.SUPERIOR:
               return itemQuantity > Math.max(this._criterionValueQuantity,0);
            case ItemCriterionOperator.INFERIOR:
               return itemQuantity < Math.max(this._criterionValueQuantity,1);
            case ItemCriterionOperator.EQUIPPED:
            case ItemCriterionOperator.NOT_EQUIPPED:
               equippedItems = InventoryManager.getInstance().inventory.getView("equipment").content;
               equipped = false;
               for each(item in equippedItems)
               {
                  if(item != null && iw.objectGID == item.objectGID)
                  {
                     equipped = true;
                     break;
                  }
               }
               if(_operator.text == ItemCriterionOperator.EQUIPPED)
               {
                  return equipped;
               }
               return !equipped;
               break;
            default:
               return false;
         }
      }
      
      override public function get text() : String
      {
         var objectName:String = Item.getItemById(_criterionValue).name;
         var readableCriterion:String = "";
         switch(_operator.text)
         {
            case ItemCriterionOperator.DIFFERENT:
               if(this._criterionValueQuantity == 1 || this._criterionValueQuantity == -1)
               {
                  readableCriterion = I18n.getUiText("ui.common.doNotPossess",[objectName]);
               }
               else
               {
                  readableCriterion = I18n.getUiText("ui.common.doNotPossessQuantity",[this._criterionValueQuantity,objectName]);
               }
               break;
            case ItemCriterionOperator.EQUAL:
               if(this._criterionValueQuantity == 1 || this._criterionValueQuantity == -1)
               {
                  readableCriterion = I18n.getUiText("ui.common.doPossess",[objectName]);
               }
               else
               {
                  readableCriterion = I18n.getUiText("ui.common.doPossessQuantity",[this._criterionValueQuantity,objectName]);
               }
               break;
            case ItemCriterionOperator.SUPERIOR:
               if(this._criterionValueQuantity == 0)
               {
                  readableCriterion = I18n.getUiText("ui.common.doPossess",[objectName]);
               }
               else
               {
                  readableCriterion = PatternDecoder.combine(I18n.getUiText("ui.common.doPossessQuantityOrMore",[this._criterionValueQuantity + 1,objectName]),"n",this._criterionValueQuantity == 1,this._criterionValueQuantity == 0);
               }
               break;
            case ItemCriterionOperator.INFERIOR:
               if(this._criterionValueQuantity == 1)
               {
                  readableCriterion = I18n.getUiText("ui.common.doNotPossess",[objectName]);
               }
               else
               {
                  readableCriterion = PatternDecoder.combine(I18n.getUiText("ui.common.doPossessQuantityOrLess",[this._criterionValueQuantity - 1,objectName]),"n",this._criterionValueQuantity == 1,this._criterionValueQuantity == 0);
               }
               break;
            case ItemCriterionOperator.EQUIPPED:
               readableCriterion = I18n.getUiText("ui.common.doEquip",[objectName]);
               break;
            case ItemCriterionOperator.NOT_EQUIPPED:
               readableCriterion = I18n.getUiText("ui.common.doNotEquip",[objectName]);
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion
      {
         return new ObjectItemCriterion(this.basicText);
      }
   }
}
