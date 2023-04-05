package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.profiler.showRedrawRegions;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class TestApi implements IApi
   {
       
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function TestApi()
      {
         this._log = Log.getLogger(getQualifiedClassName(DataApi));
         super();
      }
      
      [ApiData(name="module")]
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      public function destroy() : void
      {
         this._module = null;
      }
      
      public function getTestInventory(len:uint) : Vector.<ItemWrapper>
      {
         var item:Item = null;
         var inventory:Vector.<ItemWrapper> = new Vector.<ItemWrapper>();
         for(var i:uint = 0; i < len; i++)
         {
            item = null;
            while(!item)
            {
               item = Item.getItemById(Math.floor(Math.random() * 1000));
            }
            inventory.push(ItemWrapper.create(63,i,item.id,0,null));
         }
         return inventory;
      }
      
      public function showTrace(active:Boolean = true) : void
      {
         showRedrawRegions(active,40349);
      }
   }
}
