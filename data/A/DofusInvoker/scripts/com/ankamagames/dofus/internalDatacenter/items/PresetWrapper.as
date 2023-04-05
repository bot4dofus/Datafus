package com.ankamagames.dofus.internalDatacenter.items
{
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.network.types.game.presets.ItemForPreset;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.getQualifiedClassName;
   
   public class PresetWrapper extends ItemWrapper implements IDataCenter
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(PresetWrapper));
       
      
      public var gfxId:int;
      
      public var _objects:Array;
      
      public var mount:Boolean;
      
      private var _uri:Uri;
      
      private var _pngMode:Boolean;
      
      public function PresetWrapper()
      {
         super();
      }
      
      public static function create(id:int, gfxId:int, objects:Vector.<ItemForPreset>, mount:Boolean = false) : PresetWrapper
      {
         var emptyUri:Uri = null;
         var pos:int = 0;
         var objExists:Boolean = false;
         var item:ItemForPreset = null;
         var mountFakeItemWrapper:MountWrapper = null;
         var itemsCount:int = InventoryManager.getInstance().getMaxItemsCountForPreset();
         var presetWrapper:PresetWrapper = new PresetWrapper();
         presetWrapper.id = id;
         presetWrapper.gfxId = gfxId;
         presetWrapper.objects = new Array(itemsCount);
         presetWrapper.mount = mount;
         var delinkedUri:Uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "bitmap/failureSlot.png");
         for(var i:int = 0; i < itemsCount; i++)
         {
            pos = InventoryManager.getInstance().getPositionForPresetItemIndex(i);
            objExists = false;
            for each(item in objects)
            {
               if(item.position == pos)
               {
                  if(item.objUid)
                  {
                     presetWrapper.objects[i] = InventoryManager.getInstance().inventory.getItem(item.objUid);
                     presetWrapper.objects[i].backGroundIconUri = null;
                  }
                  else
                  {
                     presetWrapper.objects[i] = ItemWrapper.create(0,0,item.objGid,1,null,false);
                     presetWrapper.objects[i].backGroundIconUri = delinkedUri;
                     presetWrapper.objects[i].active = false;
                  }
                  objExists = true;
               }
            }
            if(pos == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS && !objExists && mount)
            {
               mountFakeItemWrapper = MountWrapper.create();
               presetWrapper.objects[i] = mountFakeItemWrapper;
               presetWrapper.objects[i].backGroundIconUri = null;
               objExists = true;
            }
            if(!objExists)
            {
               emptyUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "texture/slot/tx_slot_" + getSlotNameByPositionId(i) + ".png");
               presetWrapper.objects[i] = SimpleTextureWrapper.create(emptyUri);
            }
         }
         return presetWrapper;
      }
      
      private static function getSlotNameByPositionId(i:int) : String
      {
         var pos:int = InventoryManager.getInstance().getPositionForPresetItemIndex(i);
         switch(pos)
         {
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_AMULET:
               return "collar";
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON:
               return "weapon";
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_LEFT:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_RIGHT:
               return "ring";
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_BELT:
               return "belt";
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_BOOTS:
               return "shoe";
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_HAT:
               return "helmet";
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_CAPE:
               return "cape";
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS:
               return "pet";
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_1:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_2:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_3:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_4:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_5:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_6:
               return "dofus";
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD:
               return "shield";
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY:
               return "companon";
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_COSTUME:
               return "costume";
            default:
               return "companon";
         }
      }
      
      public function get objects() : Array
      {
         return this._objects;
      }
      
      public function set objects(a:Array) : void
      {
         this._objects = a;
      }
      
      override public function get iconUri() : Uri
      {
         return this.getIconUri();
      }
      
      override public function get fullSizeIconUri() : Uri
      {
         return this.getIconUri();
      }
      
      override public function get errorIconUri() : Uri
      {
         return null;
      }
      
      public function get uri() : Uri
      {
         return this._uri;
      }
      
      override public function getIconUri(pngMode:Boolean = true) : Uri
      {
         if(!this._uri)
         {
            this._pngMode = false;
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path").concat("presets/icons.swf|icon_").concat(this.gfxId));
         }
         return this._uri;
      }
      
      override public function get info1() : String
      {
         return null;
      }
      
      override public function get timer() : int
      {
         return 0;
      }
      
      override public function get active() : Boolean
      {
         return true;
      }
      
      public function updateObject(object:ItemForPreset) : void
      {
         var emptyUri:Uri = null;
         var gid:uint = 0;
         var delinkedUri:Uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "bitmap/failureSlot.png");
         var i:int = object.position;
         if(this._objects[i])
         {
            if(this._objects[i].hasOwnProperty("objectGID") && this._objects[i].objectGID == object.objGid)
            {
               if(object.objUid)
               {
                  this._objects[i] = InventoryManager.getInstance().inventory.getItem(object.objUid);
                  if(this._objects[i])
                  {
                     this._objects[i].backGroundIconUri = null;
                  }
               }
               else
               {
                  gid = object.objGid;
                  this._objects[i] = ItemWrapper.create(0,0,gid,1,null,false);
                  this._objects[i].backGroundIconUri = delinkedUri;
                  this._objects[i].active = false;
               }
            }
            else if(object.objGid == 0 && object.objUid == 0)
            {
               switch(i)
               {
                  case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_1:
                  case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_2:
                  case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_3:
                  case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_4:
                  case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_5:
                  case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_6:
                     emptyUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotDofus");
                     break;
                  default:
                     emptyUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotItem" + i);
               }
               this._objects[i] = SimpleTextureWrapper.create(emptyUri);
            }
         }
      }
      
      override public function addHolder(h:ISlotDataHolder) : void
      {
      }
      
      override public function removeHolder(h:ISlotDataHolder) : void
      {
      }
   }
}
