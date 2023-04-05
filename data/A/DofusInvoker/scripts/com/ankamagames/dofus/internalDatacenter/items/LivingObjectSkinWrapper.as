package com.ankamagames.dofus.internalDatacenter.items
{
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.livingObjects.LivingObjectSkinJntMood;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.getQualifiedClassName;
   
   public class LivingObjectSkinWrapper implements ISlotData
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(LivingObjectSkinWrapper));
       
      
      private var _id:int;
      
      private var _category:int;
      
      private var _mood:int;
      
      private var _skin:int;
      
      private var _uri:Uri;
      
      private var _pngMode:Boolean;
      
      private var _backGroundIconUri:Uri;
      
      public function LivingObjectSkinWrapper()
      {
         super();
      }
      
      public static function create(objectId:int, mood:int, skin:int) : LivingObjectSkinWrapper
      {
         var skinWrapper:LivingObjectSkinWrapper = new LivingObjectSkinWrapper();
         var item:Item = Item.getItemById(objectId);
         skinWrapper._id = objectId;
         skinWrapper._category = item.category;
         skinWrapper._mood = mood;
         skinWrapper._skin = skin;
         return skinWrapper;
      }
      
      public function get iconUri() : Uri
      {
         return this.getIconUri(true);
      }
      
      public function get fullSizeIconUri() : Uri
      {
         return this.getIconUri(false);
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get category() : int
      {
         return this._category;
      }
      
      public function get mood() : int
      {
         return this._mood;
      }
      
      public function get skin() : int
      {
         return this._skin;
      }
      
      public function get uri() : Uri
      {
         return this._uri;
      }
      
      public function get errorIconUri() : Uri
      {
         return null;
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
      
      public function getIconUri(pngMode:Boolean = true) : Uri
      {
         var iconId:int = 0;
         var update:Boolean = false;
         if(this._uri)
         {
            if(pngMode != this._pngMode)
            {
               update = true;
            }
         }
         else
         {
            update = true;
         }
         if(update)
         {
            iconId = LivingObjectSkinJntMood.getLivingObjectSkin(this._id,this._mood,this._skin);
            if(iconId >= 0)
            {
               if(pngMode)
               {
                  this._pngMode = true;
                  this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat(iconId).concat(".png"));
               }
               else
               {
                  this._pngMode = false;
                  this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.vector").concat(iconId).concat(".swf"));
               }
            }
            else
            {
               this._uri = null;
            }
         }
         return this._uri;
      }
      
      public function get info1() : String
      {
         return null;
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
      
      public function get timer() : int
      {
         return 0;
      }
      
      public function get active() : Boolean
      {
         return true;
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
      }
   }
}
