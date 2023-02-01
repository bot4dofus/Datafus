package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationSourceTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationWrapper;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationsDescr;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.roleplay.actions.alterations.OpenAlterationUiAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.alterations.UpdateAlterationFavoriteFlagAction;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.messages.game.character.alteration.AlterationAddedMessage;
   import com.ankamagames.dofus.network.messages.game.character.alteration.AlterationRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.character.alteration.AlterationsMessage;
   import com.ankamagames.dofus.network.messages.game.character.alteration.AlterationsUpdatedMessage;
   import com.ankamagames.dofus.network.types.game.character.alteration.AlterationInfo;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class AlterationFrame implements Frame
   {
      
      private static var DATA_STORE_CATEGORY:String = "ComputerModule_alterationFrame";
      
      private static var DATA_STORE_KEY_FAVORITES:String = "alterationFrameFavorites";
      
      private static var _dataStoreType:DataStoreType = null;
       
      
      private var _alterations:Dictionary;
      
      private var _favorites:FavoriteIdsQueue = null;
      
      public function AlterationFrame()
      {
         this._alterations = new Dictionary();
         super();
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean
      {
         if(_dataStoreType === null)
         {
            _dataStoreType = new DataStoreType(DATA_STORE_CATEGORY,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
         }
         var cachedData:ByteArray = StoreDataManager.getInstance().getData(_dataStoreType,DATA_STORE_KEY_FAVORITES);
         this._favorites = FavoriteIdsQueue.unpack(cachedData);
         return true;
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      public function getAlteration(alterationId:Number) : AlterationWrapper
      {
         var alteration:AlterationWrapper = null;
         for each(alteration in this._alterations)
         {
            if(alteration.id === alterationId)
            {
               return alteration;
            }
         }
         return null;
      }
      
      public function getNewAlterationFromBddId(alterationBddId:uint) : AlterationWrapper
      {
         var alteration:AlterationWrapper = null;
         for each(alteration in this._alterations)
         {
            if(alteration.sourceType === AlterationSourceTypeEnum.ALTERATION && alteration.bddId === alterationBddId)
            {
               return alteration;
            }
         }
         return null;
      }
      
      public function process(msg:Message) : Boolean
      {
         var alteration:AlterationWrapper = null;
         var uaffaction:UpdateAlterationFavoriteFlagAction = null;
         var removedAlterationId:Number = NaN;
         var updatedAlterations:Vector.<AlterationWrapper> = null;
         var amsg:AlterationsMessage = null;
         var aamsg:AlterationAddedMessage = null;
         var armsg:AlterationRemovedMessage = null;
         var aumsg:AlterationsUpdatedMessage = null;
         var currentAlteration:AlterationWrapper = null;
         alteration = null;
         var alterationInfo:AlterationInfo = null;
         switch(true)
         {
            case msg is OpenAlterationUiAction:
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.OpenAlterationUi,new AlterationsDescr(this.generateAlterationList()));
               return true;
            case msg is UpdateAlterationFavoriteFlagAction:
               uaffaction = msg as UpdateAlterationFavoriteFlagAction;
               if(!(uaffaction.alterationId in this._alterations))
               {
                  return true;
               }
               alteration = this._alterations[uaffaction.alterationId];
               if(alteration == uaffaction.isFavorite)
               {
                  return true;
               }
               removedAlterationId = Number.NaN;
               if(uaffaction.isFavorite)
               {
                  if(!this._favorites.contains(alteration.id))
                  {
                     removedAlterationId = this._favorites.push(alteration.id);
                  }
                  alteration.isFavorite = true;
               }
               else
               {
                  if(this._favorites.contains(alteration.id))
                  {
                     this._favorites.remove(alteration.id);
                  }
                  alteration.isFavorite = false;
               }
               StoreDataManager.getInstance().setData(_dataStoreType,DATA_STORE_KEY_FAVORITES,this._favorites.pack());
               updatedAlterations = new <AlterationWrapper>[alteration];
               if(!isNaN(removedAlterationId) && removedAlterationId !== alteration.id && removedAlterationId in this._alterations)
               {
                  alteration = this._alterations[removedAlterationId];
                  alteration.isFavorite = false;
                  updatedAlterations.push(alteration);
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.AlterationsUpdated,updatedAlterations);
               return true;
               break;
            case msg is AlterationsMessage:
               amsg = msg as AlterationsMessage;
               if(amsg.alterations.length <= 0)
               {
                  return true;
               }
               for each(alterationInfo in amsg.alterations)
               {
                  alteration = AlterationWrapper.createFromAlterationInfo(alterationInfo,this._favorites.contains(alterationInfo.alterationId));
                  this._alterations[alteration.id] = alteration;
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.Alterations,new AlterationsDescr(this.generateAlterationList()));
               return true;
               break;
            case msg is AlterationAddedMessage:
               aamsg = msg as AlterationAddedMessage;
               if(aamsg.alteration === null)
               {
                  return true;
               }
               alteration = AlterationWrapper.createFromAlterationInfo(aamsg.alteration,this._favorites.contains(aamsg.alteration.alterationId));
               this._alterations[alteration.id] = alteration;
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.AlterationAdded,alteration);
               return true;
               break;
            case msg is AlterationRemovedMessage:
               armsg = msg as AlterationRemovedMessage;
               if(armsg.alteration === null)
               {
                  return true;
               }
               alteration = null;
               for each(currentAlteration in this._alterations)
               {
                  if(currentAlteration.bddId === armsg.alteration.alterationId)
                  {
                     alteration = currentAlteration;
                  }
               }
               if(alteration === null)
               {
                  return true;
               }
               delete this._alterations[alteration.id];
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.AlterationRemoved,alteration);
               return true;
               break;
            case msg is AlterationsUpdatedMessage:
               aumsg = msg as AlterationsUpdatedMessage;
               if(aumsg.alterations.length <= 0)
               {
                  return true;
               }
               for each(alterationInfo in aumsg.alterations)
               {
                  alteration = AlterationWrapper.createFromAlterationInfo(alterationInfo,this._favorites.contains(alterationInfo.alterationId));
                  this._alterations[alteration.id] = alteration;
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.AlterationsUpdated,this.generateAlterationList());
               return true;
               break;
            default:
               return false;
         }
      }
      
      public function processOldAlterations(buffs:Vector.<ItemWrapper>) : void
      {
         var alteration:AlterationWrapper = null;
         var buff:ItemWrapper = null;
         var isRoleplayBuffStillActive:Boolean = false;
         var deletedAlterations:Vector.<AlterationWrapper> = new Vector.<AlterationWrapper>(0);
         for each(alteration in this._alterations)
         {
            if(alteration.sourceType === AlterationSourceTypeEnum.ITEM)
            {
               isRoleplayBuffStillActive = false;
               for each(buff in buffs)
               {
                  if(alteration.bddId === buff.id)
                  {
                     isRoleplayBuffStillActive = true;
                     break;
                  }
               }
               if(!isRoleplayBuffStillActive)
               {
                  deletedAlterations.push(this._alterations[alteration.id]);
                  delete this._alterations[alteration.id];
               }
            }
         }
         if(buffs.length > 0)
         {
            for each(buff in buffs)
            {
               alteration = AlterationWrapper.createFromItem(buff);
               this._alterations[alteration.id] = alteration;
               if(this._favorites.contains(alteration.id))
               {
                  this._favorites.push(alteration.id);
                  alteration.isFavorite = true;
               }
            }
            KernelEventsManager.getInstance().processCallback(RoleplayHookList.Alterations,new AlterationsDescr(this.generateAlterationList()));
         }
         for each(alteration in deletedAlterations)
         {
            KernelEventsManager.getInstance().processCallback(RoleplayHookList.AlterationRemoved,alteration);
         }
      }
      
      private function generateAlterationList() : Vector.<AlterationWrapper>
      {
         var alteration:AlterationWrapper = null;
         var alterations:Vector.<AlterationWrapper> = new Vector.<AlterationWrapper>(0);
         for each(alteration in this._alterations)
         {
            alterations.push(alteration);
         }
         return alterations;
      }
   }
}

import com.ankamagames.dofus.internalDatacenter.alterations.AlterationWrapper;
import flash.utils.ByteArray;

class FavoriteIdsQueue
{
    
   
   private var _list:Vector.<Number> = null;
   
   function FavoriteIdsQueue(list:Vector.<Number> = null)
   {
      super();
      if(list === null)
      {
         this._list = new Vector.<Number>(0);
         return;
      }
      if(list.length > AlterationWrapper.MAX_FAVORITE_COUNT)
      {
         this._list = list.splice(0,list.length - AlterationWrapper.MAX_FAVORITE_COUNT);
         return;
      }
      this._list = list;
   }
   
   public static function unpack(packedCachedData:ByteArray) : FavoriteIdsQueue
   {
      var cachedData:Vector.<Number> = null;
      var size:uint = 0;
      var i:uint = 0;
      cachedData = new Vector.<Number>(0);
      if(packedCachedData === null)
      {
         return new FavoriteIdsQueue(cachedData);
      }
      try
      {
         packedCachedData.position = 0;
         size = packedCachedData.readUnsignedInt();
         for(i = 0; i < size; i++)
         {
            cachedData.push(packedCachedData.readDouble());
         }
         packedCachedData.position = 0;
      }
      catch(error:Error)
      {
         return new FavoriteIdsQueue(cachedData);
      }
      return new FavoriteIdsQueue(cachedData);
   }
   
   public function get list() : Vector.<Number>
   {
      return this._list;
   }
   
   public function contains(alterationId:Number) : Boolean
   {
      return this._list.indexOf(alterationId) !== -1;
   }
   
   public function push(alterationId:Number) : Number
   {
      var removedAlterationId:Number = Number.NaN;
      if(this._list.length === AlterationWrapper.MAX_FAVORITE_COUNT)
      {
         removedAlterationId = this._list.removeAt(0) as Number;
      }
      this._list.push(alterationId);
      return removedAlterationId;
   }
   
   public function remove(alterationToRemoveId:Number) : Number
   {
      var alterationId:Number = NaN;
      var removedAlterationId:Number = Number.NaN;
      for(var i:uint = 0; i < this._list.length; i++)
      {
         alterationId = this._list[i];
         if(alterationId === alterationToRemoveId)
         {
            removedAlterationId = alterationId;
            this._list.removeAt(i);
         }
      }
      return removedAlterationId;
   }
   
   public function pack() : ByteArray
   {
      var alterationId:Number = NaN;
      var packedCachedData:ByteArray = new ByteArray();
      packedCachedData.writeUnsignedInt(this._list.length);
      for each(alterationId in this._list)
      {
         packedCachedData.writeDouble(alterationId);
      }
      return packedCachedData;
   }
}
