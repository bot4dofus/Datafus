package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.logic.common.managers.AuctionHouseItemFilterManager;
   
   [InstanciedApi]
   public class AuctionHouseItemFilterApi extends AbstractItemFilterApi implements IApi
   {
       
      
      public function AuctionHouseItemFilterApi()
      {
         super();
      }
      
      [ApiData(name="currentUi")]
      override public function set currentUi(value:UiRootContainer) : void
      {
         if(!_currentUi)
         {
            _currentUi = value;
         }
         _currentItemFilter = AuctionHouseItemFilterManager.getInstance();
      }
   }
}
