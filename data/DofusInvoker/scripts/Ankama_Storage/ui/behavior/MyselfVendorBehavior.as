package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.enums.UIEnum;
   
   public class MyselfVendorBehavior extends HumanVendorBehavior
   {
       
      
      public function MyselfVendorBehavior()
      {
         super();
      }
      
      override public function detach() : void
      {
         Api.ui.unloadUi(UIEnum.MYSELF_VENDOR_STOCK);
         super.detach();
      }
      
      override public function getName() : String
      {
         return StorageState.MYSELF_VENDOR_MOD;
      }
   }
}
