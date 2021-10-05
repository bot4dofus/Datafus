package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankama.haapi.client.model.GameActionsActionsTypeMeta;
   import com.ankama.haapi.client.model.KardKardProba;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.types.Uri;
   
   public class DofusShopArticleReference extends DofusShopObject implements ISlotData, IDataCenter
   {
      
      private static var _errorIconUri:Uri;
       
      
      private var _imageUrl:String;
      
      private var _quantity:uint;
      
      private var _type:String;
      
      private var _kards:Array;
      
      private var _actions:Vector.<GameActionsActionsTypeMeta>;
      
      private var _uri:Uri;
      
      private var _backGroundIconUri:Uri;
      
      public function DofusShopArticleReference(data:Object)
      {
         this._kards = [];
         super(data);
      }
      
      override public function init(data:Object) : void
      {
         super.init(data);
         this._imageUrl = data.image;
         this._quantity = data.quantity;
         this._type = data.type;
         if(data.hasOwnProperty("kards"))
         {
            if(data.kards is Vector.<KardKardProba>)
            {
               data.kards.forEach(function(element:KardKardProba, index:int, array:Array):void
               {
                  _kards[_kards.length] = element;
               });
            }
            else
            {
               this._kards = data.kards;
            }
         }
         if(this._type.toUpperCase() == "GAMEACTION")
         {
            this._actions = data.reference_gameaction.definition.actions;
         }
      }
      
      public function get iconUri() : Uri
      {
         if(!this._uri)
         {
            if(this._imageUrl)
            {
               this._uri = new Uri(this._imageUrl);
            }
            else
            {
               this._uri = this.errorIconUri;
            }
         }
         return this._uri;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(t:String) : void
      {
         this._type = t;
      }
      
      public function get fullSizeIconUri() : Uri
      {
         return null;
      }
      
      public function get errorIconUri() : Uri
      {
         if(!_errorIconUri)
         {
            _errorIconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat("error.png"));
         }
         return _errorIconUri;
      }
      
      public function get backGroundIconUri() : Uri
      {
         if(!this._backGroundIconUri)
         {
            this._backGroundIconUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/slot/emptySlot.png"));
         }
         return this._backGroundIconUri;
      }
      
      public function set backGroundIconUri(bgUri:Uri) : void
      {
         this._backGroundIconUri = bgUri;
      }
      
      public function get info1() : String
      {
         return this._quantity > 1 ? this._quantity.toString() : null;
      }
      
      public function get quantity() : uint
      {
         return this._quantity;
      }
      
      public function get active() : Boolean
      {
         return false;
      }
      
      public function get timer() : int
      {
         return 0;
      }
      
      public function get startTime() : int
      {
         return 0;
      }
      
      public function get endTime() : int
      {
         return 0;
      }
      
      public function set endTime(t:int) : void
      {
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function get kards() : Array
      {
         return this._kards;
      }
      
      public function get actions() : Vector.<GameActionsActionsTypeMeta>
      {
         return this._actions;
      }
   }
}
