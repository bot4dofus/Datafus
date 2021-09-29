package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.AbstractStorageUi;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertExistingFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListFromInvAction;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   
   public class SmithMagicCoopBehavior extends SmithMagicBehavior
   {
       
      
      public function SmithMagicCoopBehavior()
      {
         super();
      }
      
      override public function attach(storageUi:AbstractStorageUi) : void
      {
         super.attach(storageUi);
         var uiObject:UiRootContainer = Api.ui.getUi("smithMagic");
         if(!uiObject)
         {
            throw new Error("On attach un SmithMagicCoopBehavior sur une UI pas chargé");
         }
         if(uiObject.uiClass.isCrafter)
         {
            _storage.btnAll.disabled = true;
            _storage.btnEquipable.disabled = true;
            _storage.btnConsumables.disabled = true;
            _storage.categoryFilter = ItemCategoryEnum.RESOURCES_CATEGORY;
         }
         else
         {
            _storage.btn_moveAllToLeft.visible = true;
         }
      }
      
      override public function detach() : void
      {
         super.detach();
         _storage.btnAll.disabled = false;
         _storage.btnEquipable.disabled = false;
         _storage.btnConsumables.disabled = false;
         _storage.btn_moveAllToLeft.visible = true;
      }
      
      override public function getMainUiName() : String
      {
         return UIEnum.SMITH_MAGIC;
      }
      
      override public function getName() : String
      {
         return StorageState.SMITH_MAGIC_COOP_MOD;
      }
      
      override public function transfertAll() : void
      {
         Api.system.sendAction(new ExchangeObjectTransfertAllFromInvAction([]));
      }
      
      override public function transfertList() : void
      {
         Api.system.sendAction(new ExchangeObjectTransfertListFromInvAction([_storage.itemsDisplayed]));
      }
      
      override public function transfertExisting() : void
      {
         Api.system.sendAction(new ExchangeObjectTransfertExistingFromInvAction([]));
      }
   }
}
