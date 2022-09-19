package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   
   public class ForgettableModstersUiBehavior extends ForgettableSpellsUiBehavior
   {
       
      
      public function ForgettableModstersUiBehavior()
      {
         super();
      }
      
      override public function getName() : String
      {
         return StorageState.FORGETTABLE_MODSTERS_UI_MOD;
      }
      
      override protected function get attachedUiName() : String
      {
         return UIEnum.FORGETTABLE_MODSTERS_UI;
      }
      
      override protected function get allowedTypes() : Array
      {
         return [DataEnum.ITEM_TYPE_FORGETTABLE_MODSTERS];
      }
      
      override protected function disableFilters() : void
      {
         Api.storage.disableForgettableModstersFilter();
      }
      
      override protected function get filterTextKey() : String
      {
         return "ui.temporis.hideLearnedModsters";
      }
      
      override protected function get forcedCategory() : int
      {
         return DataEnum.ITEM_TYPE_FORGETTABLE_MODSTERS;
      }
      
      override protected function get filterStatusDataKey() : String
      {
         return "filterForgettableModstersUiStorage";
      }
      
      override protected function get enableFiltersFunction() : Function
      {
         return Api.storage.enableForgettableModstersFilter;
      }
   }
}
