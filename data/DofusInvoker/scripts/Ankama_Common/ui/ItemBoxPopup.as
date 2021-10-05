package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class ItemBoxPopup
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      private var _item:ItemWrapper;
      
      public var ctr_item:GraphicContainer;
      
      public var btn_close_popup:ButtonContainer;
      
      public function ItemBoxPopup()
      {
         super();
      }
      
      public function main(pParam:Object = null) : void
      {
         this.sysApi.addHook(ChatHookList.ShowObjectLinked,this.onShowObjectLinked);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         if(pParam.hasOwnProperty("ownedItem"))
         {
            this.updateItemBox(pParam.item,pParam.ownedItem);
         }
         else
         {
            this.updateItemBox(pParam.item);
         }
      }
      
      public function unload() : void
      {
         this.uiApi.unloadUi("itemBoxPop");
      }
      
      private function updateItemBox(item:ItemWrapper = null, ownedItem:Boolean = false) : void
      {
         if(item != this._item)
         {
            this.modCommon.createItemBox("itemBoxPop",this.ctr_item,item,false,ownedItem);
            this._item = item;
         }
         else
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function onShowObjectLinked(pItem:ItemWrapper = null) : void
      {
         this.updateItemBox(pItem);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close_popup:
               this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case ShortcutHookListEnum.CLOSE_UI:
            case ShortcutHookListEnum.VALID_UI:
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
   }
}
