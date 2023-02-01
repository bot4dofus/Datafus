package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.factories.MenusFactory;
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   
   [InstanciedApi]
   public class ContextMenuApi implements IApi
   {
       
      
      public function ContextMenuApi()
      {
         super();
      }
      
      public function registerMenuMaker(makerName:String, makerClass:Class) : void
      {
         if(DescribeTypeCache.classImplementInterface(makerClass,IMenuMaker))
         {
            MenusFactory.registerMaker(makerName,makerClass);
            return;
         }
         throw new ApiError(makerName + " maker class is not compatible with IMenuMaker");
      }
      
      public function create(data:*, makerName:String = null, makerParams:Array = null) : ContextMenuData
      {
         return MenusFactory.create(data,makerName,makerParams);
      }
      
      [NoBoxing]
      public function getMenuMaker(makerName:String) : Object
      {
         return MenusFactory.getMenuMaker(makerName);
      }
   }
}
