package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class DofusShopCategory extends DofusShopObject implements IDataCenter
   {
       
      
      private var _displaymode:String;
      
      private var _key:String;
      
      private var _image:String;
      
      private var _child:Array;
      
      public function DofusShopCategory(data:Object)
      {
         super(data);
      }
      
      override public function init(data:Object) : void
      {
         var childCategory:Object = null;
         super.init(data);
         this._displaymode = data.displaymode;
         this._key = data.key;
         if(data.url)
         {
            this._image = data.url;
         }
         if(data.child)
         {
            this._child = new Array();
            for each(childCategory in data.child)
            {
               this._child.push(new DofusShopCategory(childCategory));
            }
         }
      }
      
      override public function free() : void
      {
         var c:DofusShopCategory = null;
         this._displaymode = null;
         this._key = null;
         if(this._child)
         {
            for each(c in this._child)
            {
               c.free();
            }
            this._child = null;
         }
         super.free();
      }
      
      public function get key() : String
      {
         return this._key;
      }
      
      public function get image() : String
      {
         return this._image;
      }
      
      public function get children() : Array
      {
         return this._child;
      }
   }
}
