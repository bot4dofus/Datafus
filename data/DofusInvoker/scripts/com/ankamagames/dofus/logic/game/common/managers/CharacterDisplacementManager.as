package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.mounts.MountBehavior;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.mount.MountData;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.roleplay.managers.MountAutoTripManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.messages.authorized.AdminQuietCommandMessage;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.getQualifiedClassName;
   
   public class CharacterDisplacementManager implements IDestroyable
   {
      
      private static var _self:CharacterDisplacementManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CharacterDisplacementManager));
       
      
      public function CharacterDisplacementManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("CharacterDisplacementManager is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : CharacterDisplacementManager
      {
         if(_self == null)
         {
            _self = new CharacterDisplacementManager();
         }
         return _self;
      }
      
      public function destroy() : void
      {
         _self = null;
      }
      
      public function autoTravel(x:int, y:int, worldId:int = -1) : void
      {
         var ability:MountBehavior = null;
         var eff:EffectInstance = null;
         var playerIsOnMount:Boolean = PlayedCharacterManager.getInstance().isRidding;
         var playerIsOnPetsMount:Boolean = PlayedCharacterManager.getInstance().isPetsMounting;
         var autopilotCapacity:MountBehavior = MountBehavior.getMountBehaviorById(DataEnum.MOUNT_CAPACITY_AUTOPILOT);
         if(!playerIsOnMount && !playerIsOnPetsMount)
         {
            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.mountTrip.error.noMount",[autopilotCapacity.name]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
            return;
         }
         var mountInfo:MountData = PlayedCharacterManager.getInstance().mount;
         var petsMountInfo:ItemWrapper = PlayedCharacterManager.getInstance().petsMount;
         if(!mountInfo && playerIsOnMount || !petsMountInfo && playerIsOnPetsMount)
         {
            if(!mountInfo && playerIsOnMount)
            {
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.mountTrip.error.noMount",[autopilotCapacity.name]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
            }
            else if(!petsMountInfo && playerIsOnPetsMount)
            {
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.mountTrip.error.noPetsMount",[autopilotCapacity.name]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
            }
            return;
         }
         var freeAutopilotForAll:Boolean = PlayerManager.getInstance().hasFreeAutopilot;
         if(!freeAutopilotForAll && (mountInfo && mountInfo.ability.length == 0 && playerIsOnMount || petsMountInfo && !petsMountInfo.effectsList.length && playerIsOnPetsMount))
         {
            if(mountInfo && mountInfo.ability.length == 0 && playerIsOnMount)
            {
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.mountTrip.error.noMount",[autopilotCapacity.name]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
            }
            else if(petsMountInfo && !petsMountInfo.effectsList.length && playerIsOnPetsMount)
            {
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.mountTrip.error.noPetsMount",[autopilotCapacity.name]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
            }
            return;
         }
         var hasAutopilot:Boolean = false;
         if(freeAutopilotForAll)
         {
            hasAutopilot = true;
         }
         else if(playerIsOnMount)
         {
            for each(ability in mountInfo.ability)
            {
               if(ability.id == DataEnum.MOUNT_CAPACITY_AUTOPILOT)
               {
                  hasAutopilot = true;
                  break;
               }
            }
         }
         else if(playerIsOnPetsMount)
         {
            if(petsMountInfo.effects.length)
            {
               for each(eff in petsMountInfo.effects)
               {
                  if(eff.effectId == ActionIds.ACTION_SELF_PILOTING)
                  {
                     hasAutopilot = true;
                     break;
                  }
               }
            }
         }
         if(!hasAutopilot)
         {
            if(playerIsOnMount)
            {
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.mountTrip.error.noMount",[autopilotCapacity.name]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
            }
            else if(playerIsOnPetsMount)
            {
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.mountTrip.error.noPetsMount",[autopilotCapacity.name]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
            }
            return;
         }
         var mapIds:Array = this.getOrderedMapIdsFromCoords(x,y,worldId);
         if(!mapIds)
         {
            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.mountTrip.error.noDestinationMap"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
            return;
         }
         MountAutoTripManager.getInstance().initNewTrip(mapIds.pop());
      }
      
      public function movePlayer(x:int, y:int, world:int = -1) : void
      {
         if(!PlayerManager.getInstance().hasRights)
         {
            return;
         }
         var aqcmsg:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         var mapIds:Array = this.getOrderedMapIdsFromCoords(x,y,world);
         if(mapIds && mapIds.length > 0)
         {
            aqcmsg.initAdminQuietCommandMessage("moveto " + mapIds.pop());
         }
         else
         {
            aqcmsg.initAdminQuietCommandMessage("moveto " + x + "," + y);
         }
         ConnectionsHandler.getConnection().send(aqcmsg);
      }
      
      public function movePlayerOnMapId(mapId:Number) : void
      {
         var aqcmsg:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         aqcmsg.initAdminQuietCommandMessage("moveto " + mapId);
         if(PlayerManager.getInstance().hasRights)
         {
            ConnectionsHandler.getConnection().send(aqcmsg);
         }
      }
      
      private function getOrderedMapIdsFromCoords(x:int, y:int, world:int = -1) : Array
      {
         var mapId:Number = NaN;
         var mapPosition:MapPosition = null;
         var order:uint = 0;
         var worldId:uint = 0;
         var o:Object = null;
         var orderedMapIds:Array = new Array();
         var mapIds:Vector.<Number> = MapPosition.getMapIdByCoord(x,y);
         if(!mapIds)
         {
            return null;
         }
         var currentMap:WorldPointWrapper = PlayedCharacterManager.getInstance().currentMap;
         var currentSubArea:SubArea = PlayedCharacterManager.getInstance().currentSubArea;
         var currentWorldId:uint = world == -1 ? uint(currentMap.worldId) : uint(world);
         var superAreaId:uint = currentSubArea.area.superArea.id;
         var areaId:uint = currentSubArea.area.id;
         var subAreaId:uint = currentSubArea.id;
         var currentMapIsOutDoor:Boolean = MapPosition.getMapPositionById(currentMap.mapId).outdoor;
         var worldGraphicMapId:int = world == -1 ? int(PlayedCharacterManager.getInstance().currentWorldMapId) : int(world);
         var maps:Array = [];
         for each(mapId in mapIds)
         {
            mapPosition = MapPosition.getMapPositionById(mapId);
            if(!mapPosition.isTransition)
            {
               order = 0;
               worldId = WorldPoint.fromMapId(mapPosition.id).worldId;
               switch(worldId)
               {
                  case DataEnum.WORLD_AMAKNA_DEFAULT:
                     order = 40;
                     break;
                  case DataEnum.WORLD_STARTZONE:
                     order = 30;
                     break;
                  case DataEnum.WORLD_TEST:
                     order = 20;
                     break;
                  case DataEnum.WORLD_DEBUG:
                     order = 10;
               }
               if(mapPosition.subArea && mapPosition.subArea.worldmap && mapPosition.subArea.worldmap.id == worldGraphicMapId)
               {
                  order += 100000;
               }
               if(mapPosition.hasPriorityOnWorldmap)
               {
                  order += 10000;
               }
               if(mapPosition.outdoor == currentMapIsOutDoor)
               {
                  order++;
               }
               if(mapPosition.subArea && mapPosition.subArea.id == subAreaId)
               {
                  order += 100;
               }
               if(mapPosition.subArea && mapPosition.subArea.area && mapPosition.subArea.area.id == areaId)
               {
                  order += 50;
               }
               if(mapPosition.subArea && mapPosition.subArea.area && mapPosition.subArea.area.superArea && mapPosition.subArea.area.superArea.id == superAreaId)
               {
                  order += 25;
               }
               if(worldId == currentWorldId)
               {
                  order += 100;
               }
               maps.push({
                  "id":mapId,
                  "order":order
               });
            }
         }
         if(maps.length)
         {
            maps.sortOn(["order","id"],[Array.NUMERIC,Array.NUMERIC | Array.DESCENDING]);
            for each(o in maps)
            {
               orderedMapIds.push(o.id);
            }
         }
         return orderedMapIds;
      }
   }
}
