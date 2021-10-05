package Ankama_Cartography
{
   import Ankama_Cartography.ui.BannerMap;
   import Ankama_Cartography.ui.CartographyBase;
   import Ankama_Cartography.ui.CartographyPopup;
   import Ankama_Cartography.ui.CartographyTool;
   import Ankama_Cartography.ui.CartographyTooltip;
   import Ankama_Cartography.ui.CartographyUi;
   import Ankama_Cartography.ui.type.Flag;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.WorldMap;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.dofus.uiApi.BreachApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.HighlightApi;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import flash.display.Sprite;
   
   public class Cartography extends Sprite
   {
      
      private static var CARTOGRAPHY_UI:String = "cartographyUi";
      
      private static var BANNER_MAP:String = "bannerMap";
       
      
      private var include_CartographyUi:CartographyUi;
      
      private var include_CartographyPopup:CartographyPopup;
      
      private var include_CartographyTool:CartographyTool;
      
      private var include_CartographyTooltip:CartographyTooltip;
      
      private var include_BannerMap:BannerMap;
      
      private var _currentWorldMapId:int;
      
      private var _flags:Array;
      
      private var _prismsStatesInfo:Array;
      
      private var _phoenixFlags:Array;
      
      private var _onBreachMap:Boolean;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="MapApi")]
      public var mapApi:MapApi;
      
      [Api(name="HighlightApi")]
      public var highlightApi:HighlightApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="BreachApi")]
      public var breachApi:BreachApi;
      
      private var _openBannerMapOnNextMap:Boolean = false;
      
      public function Cartography()
      {
         this._flags = new Array();
         this._phoenixFlags = new Array();
         super();
      }
      
      public function main() : void
      {
         var wmap:WorldMap = null;
         var flagData:String = null;
         var worldFlagsData:Array = null;
         var dataStr:String = null;
         var worldId:int = 0;
         var flagsPos:Array = null;
         var j:int = 0;
         var x:int = 0;
         var y:int = 0;
         this.sysApi.addHook(HookList.OpenMap,this.onOpenMap);
         this.sysApi.addHook(HookList.AddMapFlag,this.onAddMapFlag);
         this.sysApi.addHook(HookList.RemoveMapFlag,this.onRemoveMapFlag);
         this.sysApi.addHook(HookList.RemoveAllFlags,this.onRemoveAllFlags);
         this.sysApi.addHook(HookList.CurrentMap,this.onCurrentMap);
         this.sysApi.addHook(HookList.PhoenixUpdate,this.onPhoenixUpdate);
         this.sysApi.addHook(HookList.BreachTeleport,this.onBreachTeleport);
         this.sysApi.addHook(HookList.RefreshMapQuests,this.onRefreshMapQuests);
         this.sysApi.addHook(HookList.OpenCartographyPopup,this.openCartographyPopup);
         var wmaps:Array = this.dataApi.getAllWorldMaps();
         for each(wmap in wmaps)
         {
            this._flags[wmap.id] = [];
         }
         flagData = this.sysApi.getData(this.playerApi.getPlayedCharacterInfo().id + "-cartographyFlags");
         if(flagData)
         {
            worldFlagsData = flagData.split(";");
            for each(dataStr in worldFlagsData)
            {
               if(dataStr)
               {
                  worldId = parseInt(dataStr.split(":")[0]);
                  flagsPos = dataStr.split(":")[1].split(",");
                  for(j = 0; j < flagsPos.length; j += 2)
                  {
                     x = parseInt(flagsPos[j]);
                     y = parseInt(flagsPos[j + 1]);
                     this._flags[worldId]["flag_custom_" + x + "_" + y] = new Flag("flag_custom_" + x + "_" + y,x,y,this.uiApi.getText("ui.cartography.customFlag") + " (" + x + "," + y + ")",16768256);
                  }
               }
            }
         }
         this._prismsStatesInfo = new Array();
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_INVULNERABLE] = {
            "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_INVULNERABLE)),
            "icon":420
         };
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_ATTACKED] = {
            "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_ATTACKED)),
            "icon":420
         };
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_FIGHTING] = {
            "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_FIGHTING)),
            "icon":420
         };
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_NORMAL] = {
            "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_NORMAL)),
            "icon":420
         };
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_WEAKENED] = {
            "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_WEAKENED)),
            "icon":421
         };
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_VULNERABLE] = {
            "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_VULNERABLE)),
            "icon":436
         };
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_DEFEATED] = {
            "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_DEFEATED)),
            "icon":436
         };
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_SABOTAGED] = {
            "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_SABOTAGED)),
            "icon":440
         };
      }
      
      public function openCartographyPopup(title:String, selectedSubareaId:int, subareaIds:Object = null, subtitle:String = "") : String
      {
         var params:Object = new Object();
         params.title = title;
         params.selectedSubareaId = selectedSubareaId;
         params.subareaIds = subareaIds;
         params.subtitle = subtitle;
         this.uiApi.loadUi("cartographyPopup",null,params,StrataEnum.STRATA_TOP,null,true);
         return "cartographyPopup";
      }
      
      public function openBannerMap() : void
      {
         var currentWorldMapId:int = 0;
         var flags:Array = null;
         var key:* = null;
         var phoenixFlag:Flag = null;
         if(!this.uiApi.getUi(BANNER_MAP))
         {
            if(this.playerApi.currentSubArea())
            {
               this._openBannerMapOnNextMap = false;
               currentWorldMapId = this.mapApi.getCurrentWorldMap().id;
               flags = [];
               for(key in this._flags[currentWorldMapId])
               {
                  flags[key] = this._flags[currentWorldMapId][key];
               }
               if(!this.playerApi.isAlive())
               {
                  for each(phoenixFlag in this._phoenixFlags)
                  {
                     if(!flags[phoenixFlag.id] && phoenixFlag.worldMap == currentWorldMapId)
                     {
                        flags.push(phoenixFlag);
                     }
                  }
               }
               this.uiApi.loadUi(BANNER_MAP,null,{
                  "currentMap":this.playerApi.currentMap(),
                  "flags":flags,
                  "conquest":false,
                  "switchingMapUi":false,
                  "fromShortcut":false,
                  "visible":this.configApi.getConfigProperty("dofus","showMiniMap")
               },StrataEnum.STRATA_LOW);
            }
            else
            {
               this._openBannerMapOnNextMap = true;
            }
         }
      }
      
      private function onRefreshMapQuests(questIcons:Array) : void
      {
         var mapUi:CartographyBase = null;
         var mapUis:Array = [];
         if(this.uiApi.getUi(CARTOGRAPHY_UI))
         {
            mapUis.push(this.uiApi.getUi(CARTOGRAPHY_UI).uiClass);
         }
         if(this.uiApi.getUi(BANNER_MAP))
         {
            mapUis.push(this.uiApi.getUi(BANNER_MAP).uiClass);
         }
         CartographyBase.questIcons = questIcons;
         if(mapUis && mapUis.length > 0)
         {
            for each(mapUi in mapUis)
            {
               mapUi.refreshQuests(questIcons);
            }
         }
      }
      
      private function onBreachTeleport(teleported:Boolean) : void
      {
         this._onBreachMap = teleported;
      }
      
      private function onOpenMap(ignoreSetting:Boolean = false, fromShortcut:Boolean = false, conquest:Boolean = false) : void
      {
         var displayedMap:WorldPointWrapper = null;
         var currentWorldMapId:int = 0;
         var flags:Array = null;
         var key:* = null;
         var phoenixFlag:Flag = null;
         if(this.uiApi.getUi(CARTOGRAPHY_UI))
         {
            this.soundApi.playSound(SoundTypeEnum.MAP_CLOSE);
            this.uiApi.unloadUi(CARTOGRAPHY_UI);
         }
         else
         {
            if(this.playerApi.isInAnomaly())
            {
               this.sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.anomaly.openMapDisabled"),666,this.timeApi.getTimestamp());
               return;
            }
            if(this.playerApi.currentSubArea())
            {
               if(this.sysApi.getPlayerManager().isMapInHavenbag(this.playerApi.currentMap().mapId))
               {
                  displayedMap = this.playerApi.previousMap();
                  currentWorldMapId = this.playerApi.previousWorldMapId();
               }
               else
               {
                  displayedMap = this.playerApi.currentMap();
                  currentWorldMapId = this.mapApi.getCurrentWorldMap().id;
               }
               flags = [];
               for(key in this._flags[currentWorldMapId])
               {
                  flags[key] = this._flags[currentWorldMapId][key];
               }
               if(!this.playerApi.isAlive())
               {
                  for each(phoenixFlag in this._phoenixFlags)
                  {
                     if(!flags[phoenixFlag.id] && phoenixFlag.worldMap == currentWorldMapId)
                     {
                        flags.push(phoenixFlag);
                     }
                  }
               }
               this.uiApi.loadUi(CARTOGRAPHY_UI,null,{
                  "currentMap":displayedMap,
                  "flags":flags,
                  "conquest":conquest,
                  "fromShortcut":fromShortcut
               },StrataEnum.STRATA_LOW);
            }
         }
      }
      
      private function onAddMapFlag(flagId:String, flagLegend:String, worldmapId:int, x:int, y:int, color:uint, removeIfPresent:Boolean = false, showHelpArrow:Boolean = false, canBeManuallyRemoved:Boolean = true, allowDuplicate:Boolean = false) : void
      {
         var mapUi:CartographyBase = null;
         var flag:Flag = null;
         var worldMap:WorldMap = null;
         var worldMap2:WorldMap = null;
         var mapUis:Array = new Array();
         if(this.uiApi.getUi(CARTOGRAPHY_UI))
         {
            mapUis.push(this.uiApi.getUi(CARTOGRAPHY_UI).uiClass);
         }
         if(this.uiApi.getUi(BANNER_MAP))
         {
            mapUis.push(this.uiApi.getUi(BANNER_MAP).uiClass);
         }
         if(!this._flags[worldmapId])
         {
            this.sysApi.log(8,"Failed to add new map flag because the world " + worldmapId + " is not valid");
            return;
         }
         if(!this._flags[worldmapId][flagId])
         {
            flag = !!this._phoenixFlags[flagId] ? this._phoenixFlags[flagId] : new Flag(flagId,x,y,flagLegend,color,canBeManuallyRemoved,allowDuplicate);
            if(this.mapApi.getCurrentWorldMap() && this.mapApi.getCurrentWorldMap().id != worldmapId || flagId.indexOf("flag_chat") != -1)
            {
               worldMap = this.dataApi.getWorldMap(worldmapId);
               this.sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.cartography.flagAddedOnOtherMap",x,y,worldMap.name),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.timeApi.getTimestamp());
            }
            if(mapUis && mapUis.length > 0)
            {
               for each(mapUi in mapUis)
               {
                  if(mapUi && mapUi.currentWorldId == worldmapId)
                  {
                     mapUi.addFlag(flagId,flagLegend,x,y,color,true,true,canBeManuallyRemoved,allowDuplicate);
                  }
               }
            }
            this._flags[worldmapId][flagId] = flag;
            this.sysApi.dispatchHook(CustomUiHookList.FlagAdded,flagId,worldmapId,x,y,color,flagLegend,canBeManuallyRemoved,allowDuplicate);
            if(showHelpArrow && !this.playerApi.isInFight())
            {
               this.highlightApi.highlightUi(UIEnum.BANNER_MENU,"btn_map",1,0,5,false);
            }
         }
         else
         {
            flag = this._flags[worldmapId][flagId];
            if(removeIfPresent)
            {
               delete this._flags[worldmapId][flagId];
               if(this._currentWorldMapId != worldmapId || flagId.indexOf("flag_chat") != -1)
               {
                  worldMap2 = this.dataApi.getWorldMap(worldmapId);
                  this.sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.cartography.flagRemovedOnOtherMap",x,y,worldMap2.name),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.timeApi.getTimestamp());
               }
               if(mapUis && mapUis.length > 0)
               {
                  for each(mapUi in mapUis)
                  {
                     if(mapUi.currentWorldId == worldmapId)
                     {
                        mapUi.removeFlag(flagId);
                     }
                  }
               }
               this.sysApi.dispatchHook(CustomUiHookList.FlagRemoved,flagId,worldmapId);
            }
            else
            {
               flag.position.x = x;
               flag.position.y = y;
               flag.legend = flagLegend;
               if(mapUis && mapUis.length > 0)
               {
                  for each(mapUi in mapUis)
                  {
                     if(mapUi && this._currentWorldMapId == worldmapId)
                     {
                        if(!mapUi.updateFlag(flagId,x,y,flagLegend))
                        {
                           mapUi.addFlag(flagId,flagLegend,x,y,color,true,true,canBeManuallyRemoved,allowDuplicate);
                        }
                     }
                  }
               }
               this.sysApi.dispatchHook(CustomUiHookList.FlagAdded,flagId,worldmapId,x,y,color,flagLegend,canBeManuallyRemoved,allowDuplicate);
               if(showHelpArrow && !this.playerApi.isInFight())
               {
                  this.highlightApi.highlightUi(UIEnum.BANNER_MENU,"btn_map",1,0,5,false);
               }
            }
         }
         if(flagId.indexOf("flag_custom") != -1)
         {
            this.saveFlags();
         }
      }
      
      private function onRemoveMapFlag(flagId:String, worldMapId:int) : void
      {
         var wmapId:* = undefined;
         if(worldMapId != -1)
         {
            this.removeFlagFromWorldMap(worldMapId,flagId);
         }
         else
         {
            for(wmapId in this._flags)
            {
               this.removeFlagFromWorldMap(wmapId,flagId);
            }
         }
      }
      
      private function removeFlagFromWorldMap(pWorldMapId:uint, pFlagId:String) : void
      {
         var mapUi:CartographyBase = null;
         if(!this._flags[pWorldMapId][pFlagId])
         {
            return;
         }
         var mapUis:Array = new Array();
         if(this.uiApi.getUi(CARTOGRAPHY_UI))
         {
            mapUis.push(this.uiApi.getUi(CARTOGRAPHY_UI).uiClass);
         }
         if(this.uiApi.getUi(BANNER_MAP))
         {
            mapUis.push(this.uiApi.getUi(BANNER_MAP).uiClass);
         }
         delete this._flags[pWorldMapId][pFlagId];
         if(mapUis && mapUis.length > 0)
         {
            for each(mapUi in mapUis)
            {
               if(mapUi.currentWorldId == pWorldMapId)
               {
                  mapUi.removeFlag(pFlagId);
               }
            }
         }
         this.sysApi.dispatchHook(CustomUiHookList.FlagRemoved,pFlagId,pWorldMapId);
         if(pFlagId.indexOf("flag_custom") != -1)
         {
            this.saveFlags();
         }
      }
      
      private function onRemoveAllFlags() : void
      {
         this.removeAllFlags();
      }
      
      private function removeAllFlags() : void
      {
         var worldMapId:* = undefined;
         var flagId:* = null;
         var mapUi:CartographyBase = null;
         var mapUis:Array = new Array();
         if(this.uiApi.getUi(CARTOGRAPHY_UI))
         {
            mapUis.push(this.uiApi.getUi(CARTOGRAPHY_UI).uiClass);
         }
         if(this.uiApi.getUi(BANNER_MAP))
         {
            mapUis.push(this.uiApi.getUi(BANNER_MAP).uiClass);
         }
         for(worldMapId in this._flags)
         {
            for(flagId in this._flags[worldMapId])
            {
               if(this._flags[worldMapId][flagId].canBeManuallyRemoved)
               {
                  delete this._flags[worldMapId][flagId];
                  if(mapUis && mapUis.length > 0)
                  {
                     for each(mapUi in mapUis)
                     {
                        if(mapUi && mapUi.currentWorldId == worldMapId)
                        {
                           mapUi.removeFlag(flagId);
                        }
                     }
                  }
                  this.sysApi.dispatchHook(CustomUiHookList.FlagRemoved,flagId,worldMapId);
               }
            }
         }
         this.saveFlags();
      }
      
      private function onCurrentMap(pMapId:Number) : void
      {
         var phoenixFlag:Flag = null;
         if(this._openBannerMapOnNextMap)
         {
            this.openBannerMap();
         }
         if(this.uiApi.getUi(CARTOGRAPHY_UI))
         {
            this.uiApi.unloadUi(CARTOGRAPHY_UI);
         }
         var subArea:SubArea = this.mapApi.getMapPositionById(pMapId).subArea;
         this._currentWorldMapId = !!subArea.worldmap ? int(subArea.worldmap.id) : 1;
         if(!this.playerApi.isAlive())
         {
            for each(phoenixFlag in this._phoenixFlags)
            {
               if(phoenixFlag.worldMap == this._currentWorldMapId && !this._flags[this._currentWorldMapId][phoenixFlag.id])
               {
                  this._flags[this._currentWorldMapId][phoenixFlag.id] = phoenixFlag;
               }
            }
         }
      }
      
      private function onPhoenixUpdate(pPhoenixMapId:Number = 0) : void
      {
         var flag:Flag = null;
         var phoenixes:Array = null;
         var phoenixMapId:Number = NaN;
         for each(flag in this._phoenixFlags)
         {
            this.onRemoveMapFlag(flag.id,flag.worldMap);
         }
         this._phoenixFlags = new Array();
         if(this.playerApi.state() == PlayerLifeStatusEnum.STATUS_PHANTOM)
         {
            if(pPhoenixMapId)
            {
               this.addPhoenixFlag(pPhoenixMapId);
            }
            else
            {
               phoenixes = this.mapApi.getPhoenixsMaps();
               for each(phoenixMapId in phoenixes)
               {
                  this.addPhoenixFlag(phoenixMapId);
               }
            }
         }
      }
      
      private function addPhoenixFlag(pPhoenixMapId:Number) : void
      {
         var mapPos:MapPosition = this.mapApi.getMapPositionById(pPhoenixMapId);
         var flag:Flag = new Flag("Phoenix_" + pPhoenixMapId,mapPos.posX,mapPos.posY,this.uiApi.getText("ui.common.phoenix"),14759203);
         flag.worldMap = mapPos.worldMap;
         this._phoenixFlags[flag.id] = flag;
         if(this.mapApi.getCurrentWorldMap() && this.mapApi.getCurrentWorldMap().id == flag.worldMap)
         {
            this.onAddMapFlag(flag.id,flag.legend,mapPos.worldMap,flag.position.x,flag.position.y,flag.color);
         }
      }
      
      private function removeOtherWorldMapFlags() : void
      {
         var flag:Flag = null;
         var wmapId:* = undefined;
         for(wmapId in this._flags)
         {
            if(wmapId != this._currentWorldMapId)
            {
               for each(flag in this._flags[wmapId])
               {
                  this.removeFlagFromWorldMap(wmapId,flag.id);
               }
            }
         }
      }
      
      public function getFlags(worldMapId:int) : Array
      {
         var f:Flag = null;
         var phoenixFlag:Flag = null;
         var flags:Array = [];
         for each(f in this._flags[worldMapId])
         {
            flags[f.id] = f;
         }
         for each(phoenixFlag in this._phoenixFlags)
         {
            if(!flags[phoenixFlag.id] && phoenixFlag.worldMap == worldMapId)
            {
               flags.push(phoenixFlag);
            }
         }
         return flags;
      }
      
      private function saveFlags() : void
      {
         var flagPositions:Array = null;
         var addWorldId:Boolean = false;
         var flag:Flag = null;
         var flagData:String = "";
         for(var i:int = 0; i < this._flags.length; i++)
         {
            if(this._flags[i])
            {
               flagPositions = [];
               addWorldId = true;
               for each(flag in this._flags[i])
               {
                  if(flag.id.indexOf("flag_custom") != -1)
                  {
                     if(addWorldId)
                     {
                        flagData += i.toString() + ":";
                        addWorldId = false;
                     }
                     flagPositions.push(flag.position.x,flag.position.y);
                  }
               }
               if(flagPositions.length)
               {
                  flagData += flagPositions.join(",") + ";";
               }
            }
         }
         this.sysApi.setData(this.playerApi.getPlayedCharacterInfo().id + "-cartographyFlags",flagData);
      }
      
      public function getPrismStateInfo(pPrismState:uint) : Object
      {
         return this._prismsStatesInfo[pPrismState];
      }
      
      public function showConquestInformation() : Boolean
      {
         var subArea:SubArea = null;
         var subAreas:Array = this.mapApi.getAllSubArea();
         for each(subArea in subAreas)
         {
            if(subArea.worldmap && subArea.worldmap.id == this._currentWorldMapId && subArea.capturable)
            {
               return true;
            }
         }
         return false;
      }
   }
}
