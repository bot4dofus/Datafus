package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.ui.AbstractStorageUi;
   import Ankama_Storage.ui.enum.StorageState;
   
   public class TaxCollectorBehavior extends BankBehavior
   {
       
      
      public function TaxCollectorBehavior()
      {
         super();
      }
      
      override public function attach(storageUi:AbstractStorageUi) : void
      {
         super.attach(storageUi);
         _storage.btn_moveAllToRight.visible = false;
      }
      
      override public function detach() : void
      {
         super.detach();
         _storage.btn_moveAllToRight.visible = true;
      }
      
      override public function getName() : String
      {
         return StorageState.TAXCOLLECTOR_MOD;
      }
   }
}
