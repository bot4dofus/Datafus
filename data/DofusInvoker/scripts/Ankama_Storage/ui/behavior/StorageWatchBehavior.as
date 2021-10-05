package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.ui.AbstractStorageUi;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   
   public class StorageWatchBehavior implements IStorageBehavior
   {
       
      
      public function StorageWatchBehavior()
      {
         super();
      }
      
      public function filterStatus(enabled:Boolean) : void
      {
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         return false;
      }
      
      public function processDrop(target:Object, data:Object, source:Object) : void
      {
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
      }
      
      public function attach(storageUi:AbstractStorageUi) : void
      {
      }
      
      public function detach() : void
      {
      }
      
      public function onUnload() : void
      {
      }
      
      public function getStorageUiName() : String
      {
         return UIEnum.WATCH_EQUIPMENT_UI;
      }
      
      public function getName() : String
      {
         return StorageState.WATCH_MOD;
      }
      
      public function get replacable() : Boolean
      {
         return true;
      }
      
      public function doubleClickGridItem(pItem:Object) : void
      {
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
      }
      
      public function transfertAll() : void
      {
      }
      
      public function transfertList() : void
      {
      }
      
      public function transfertExisting() : void
      {
      }
   }
}
