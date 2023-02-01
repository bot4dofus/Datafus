package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.logic.game.common.misc.IInventoryView;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class EquipmentView implements IInventoryView
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EquipmentView));
       
      
      private var _content:Vector.<ItemWrapper>;
      
      private var _hookLock:HookLock;
      
      private var _initializing:Boolean;
      
      public function EquipmentView(hookLock:HookLock)
      {
         this._content = new Vector.<ItemWrapper>(62);
         super();
         this._hookLock = hookLock;
      }
      
      public function initialize(items:Vector.<ItemWrapper>) : void
      {
         var item:ItemWrapper = null;
         this._initializing = true;
         this._content = new Vector.<ItemWrapper>(62);
         PlayedCharacterManager.getInstance().currentWeapon = null;
         for each(item in items)
         {
            if(this.isListening(item))
            {
               this.addItem(item,0);
            }
            if(item.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)
            {
               PlayedCharacterManager.getInstance().currentWeapon = item as WeaponWrapper;
            }
         }
         this._initializing = false;
         this._hookLock.addHook(InventoryHookList.WeaponUpdate,[]);
      }
      
      public function get name() : String
      {
         return "equipment";
      }
      
      public function get content() : Vector.<ItemWrapper>
      {
         return this._content;
      }
      
      public function addItem(item:ItemWrapper, invisible:int, needUpdateView:Boolean = true) : void
      {
         this.content[item.position] = item;
         if(item.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)
         {
            PlayedCharacterManager.getInstance().currentWeapon = item as WeaponWrapper;
            this._hookLock.addHook(InventoryHookList.WeaponUpdate,[]);
         }
         if(!this._initializing)
         {
            this._hookLock.addHook(InventoryHookList.EquipmentObjectMove,[item,-1]);
         }
      }
      
      public function removeItem(item:ItemWrapper, invisible:int) : void
      {
         this.content[item.position] = null;
         if(item.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)
         {
            PlayedCharacterManager.getInstance().currentWeapon = null;
            this._hookLock.addHook(InventoryHookList.WeaponUpdate,[]);
         }
         this._hookLock.addHook(InventoryHookList.EquipmentObjectMove,[null,item.position]);
      }
      
      public function modifyItem(item:ItemWrapper, oldItem:ItemWrapper, invisible:int) : void
      {
         if(this.content[oldItem.position] == item)
         {
            this.content[oldItem.position] = null;
         }
         this.content[item.position] = item;
         if(item.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)
         {
            this._hookLock.addHook(InventoryHookList.WeaponUpdate,[]);
         }
         this._hookLock.addHook(InventoryHookList.EquipmentObjectMove,[item,oldItem.position]);
      }
      
      public function isListening(item:ItemWrapper) : Boolean
      {
         return item.position <= 61;
      }
      
      public function updateView() : void
      {
      }
      
      public function empty() : void
      {
      }
   }
}
