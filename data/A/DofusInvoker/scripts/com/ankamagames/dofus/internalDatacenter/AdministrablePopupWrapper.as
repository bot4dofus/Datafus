package com.ankamagames.dofus.internalDatacenter
{
   import com.ankamagames.dofus.datacenter.popup.PopupButton;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AdministrablePopupWrapper implements IDataCenter
   {
       
      
      public var id:uint;
      
      public var title:String;
      
      public var contentText:String;
      
      public var criterion:String;
      
      public var name:String = "";
      
      public var image:String;
      
      public var cacheType:uint = 0;
      
      public var closeCallback:Function = null;
      
      private var _buttonList:Array;
      
      private var _itemList:Array;
      
      public function AdministrablePopupWrapper()
      {
         this._buttonList = [];
         this._itemList = [];
         super();
      }
      
      public function get buttonList() : Array
      {
         return this._buttonList;
      }
      
      public function get itemList() : Array
      {
         return this._itemList;
      }
      
      public function addButton(button:PopupButton) : void
      {
         this._buttonList.push(button);
      }
      
      public function addItem(itemId:uint, quantity:uint) : void
      {
         var item:Object = new Object();
         item.id = itemId;
         item.quantity = quantity;
         this._itemList.push(item);
      }
   }
}
