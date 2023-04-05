package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.logic.common.managers.EncyclopediaItemFilterManager;
   
   [InstanciedApi]
   public class EncyclopediaItemFilterApi extends AbstractItemFilterApi implements IApi
   {
       
      
      public function EncyclopediaItemFilterApi()
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
         _currentItemFilter = EncyclopediaItemFilterManager.getInstance();
      }
   }
}
