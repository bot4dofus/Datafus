package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankama.haapi.client.model.ShopImage;
   import com.ankamagames.dofus.types.enums.DofusShopEnum;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class DofusShopHighlight extends DofusShopObject implements IDataCenter
   {
       
      
      private var _type:String;
      
      private var _mode:String;
      
      private var _link:String;
      
      private var _image:Vector.<ShopImage>;
      
      private var _external;
      
      public function DofusShopHighlight(data:Object)
      {
         super(data);
      }
      
      override public function init(data:Object) : void
      {
         super.init(data);
         this._type = data.type;
         this._mode = data.mode;
         this._link = data.link;
         this._image = data.image;
         if(this._type == DofusShopEnum.HIGHLIGHT_TYPE_CATEGORY)
         {
            this._external = new DofusShopCategory(data.external_category);
         }
         else if(this._type == DofusShopEnum.HIGHLIGHT_TYPE_ARTICLE)
         {
            this._external = new DofusShopArticle(data.external_article);
         }
         if(this._mode == DofusShopEnum.HIGHLIGHT_MODE_CAROUSEL && this._external is DofusShopObject)
         {
            if(!_name)
            {
               _name = DofusShopObject(this._external).name;
            }
            if(!_description)
            {
               _description = DofusShopObject(this._external).description;
            }
         }
      }
      
      override public function free() : void
      {
         this._type = null;
         this._mode = null;
         this._link = null;
         this._image = null;
         if(this._external && this._external is DofusShopObject)
         {
            this._external.free();
         }
         this._external = null;
         super.free();
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get mode() : String
      {
         return this._mode;
      }
      
      public function get link() : String
      {
         return this._link;
      }
      
      public function get image() : Vector.<ShopImage>
      {
         return this._image;
      }
      
      public function get external() : Object
      {
         return this._external;
      }
   }
}
