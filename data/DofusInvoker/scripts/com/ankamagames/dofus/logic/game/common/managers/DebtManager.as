package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.dofus.network.types.game.character.debt.DebtInformation;
   import com.ankamagames.dofus.network.types.game.character.debt.KamaDebtInformation;
   import com.ankamagames.jerakine.utils.misc.DictionaryUtils;
   import flash.utils.Dictionary;
   
   public class DebtManager
   {
      
      public static var _self:DebtManager;
       
      
      private var _debtList:Dictionary;
      
      public function DebtManager()
      {
         super();
         this._debtList = new Dictionary();
      }
      
      public static function getInstance() : DebtManager
      {
         if(!_self)
         {
            _self = new DebtManager();
         }
         return _self;
      }
      
      public static function clean() : void
      {
         _self = null;
      }
      
      public function removeDebt(id:uint) : void
      {
         if(this._debtList[id] is KamaDebtInformation)
         {
            InventoryManager.getInstance().bankInventory.kamas = InventoryManager.getInstance().bankInventory.kamas - (this._debtList[id] as KamaDebtInformation).kamas;
         }
         delete this._debtList[id];
      }
      
      public function removeDebts(ids:Vector.<Number>) : void
      {
         var id:Number = NaN;
         for each(id in ids)
         {
            this.removeDebt(id);
         }
      }
      
      public function getTotalKamaDebt() : uint
      {
         var debt:DebtInformation = null;
         var tot:uint = 0;
         for each(debt in this._debtList)
         {
            if(debt is KamaDebtInformation)
            {
               tot += (debt as KamaDebtInformation).kamas;
            }
         }
         return tot;
      }
      
      public function updateDebts(debts:Vector.<DebtInformation>) : void
      {
         var debt:DebtInformation = null;
         for each(debt in debts)
         {
            this._debtList[debt.id] = debt;
         }
      }
      
      public function hasDebt() : Boolean
      {
         return DictionaryUtils.getLength(this._debtList) > 0;
      }
   }
}
