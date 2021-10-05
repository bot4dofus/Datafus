package Ankama_Cartography.ui
{
   import Ankama_Cartography.ui.type.Flag;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.MapViewer;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.MapAreaShape;
   import com.ankamagames.berilia.types.graphic.MapIconElement;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.world.Dungeon;
   import com.ankamagames.dofus.datacenter.world.Hint;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.WorldMap;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.PlaySoundAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.types.enums.HintPriorityEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.geom.Point;
   
   public class CartographyPopup extends AbstractCartographyUi
   {
      
      private static const HINTS_LAYER:String = "Hints";
      
      private static const AREAS_SHAPES_LAYER:String = "AreasShapes";
      
      private static const FLAGS_LAYER:String = "Flags";
      
      private static const DUNGEONS_LAYER:String = "Dungeons";
       
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      public var popCtr:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var lbl_subtitle:Label;
      
      public var btn_player:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      private var _flagUri:String;
      
      private var _iconsUri:String;
      
      private var _dungeons:Array;
      
      private var _notVisible:Vector.<int>;
      
      private var _addingFlag:Boolean;
      
      private var _currentWorldMap:WorldMap;
      
      public function CartographyPopup()
      {
         super();
      }
      
      override public function main(params:Object = null) : void
      {
         super.main(params);
         uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         this.btn_close.soundId = SoundEnum.WINDOW_CLOSE;
         this.popCtr.getUi().showModalContainer = true;
         this.lbl_title.text = params.title;
         if(params.subtitle)
         {
            this.lbl_subtitle.text = params.subtitle;
         }
         this.popCtr.height = mapViewer.height + 105;
         this.popCtr.width = mapViewer.width + 35;
         this._flagUri = sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|flag0";
         this._iconsUri = uiApi.me().getConstant("icons_uri") + "/hints/";
         this._dungeons = [];
         this._notVisible = new Vector.<int>();
         uiApi.addComponentHook(this.btn_player,"onRollOver");
         uiApi.addComponentHook(this.btn_player,"onRollOut");
         uiApi.addComponentHook(mapViewer,"onRelease");
         sysApi.addHook(CustomUiHookList.FlagAdded,this.onFlagAdded);
         this.initMap(params.selectedSubareaId,params.subareaIds);
         mapViewer.showGrid = sysApi.getData("ShowMapGrid",DataStoreEnum.BIND_ACCOUNT);
      }
      
      private function initMap(pSelectedSubAreaId:int, pSubAreasIds:Vector.<uint>) : void
      {
         var subArea:SubArea = null;
         var subareaId:int = 0;
         var zoom:String = null;
         var dungeonId:int = 0;
         var mapAreaShape:MapAreaShape = null;
         var hints:Array = null;
         var hint:Hint = null;
         var flags:Array = null;
         var flag:Flag = null;
         var center:Object = null;
         var showCustomWorldMap:Boolean = false;
         var selectedSubArea:SubArea = mapApi.getSubArea(pSelectedSubAreaId);
         if(selectedSubArea.hasCustomWorldMap)
         {
            showCustomWorldMap = true;
            for each(subareaId in pSubAreasIds)
            {
               subArea = this.dataApi.getSubArea(subareaId);
               if(subArea.worldmap)
               {
                  if(subArea.hasCustomWorldMap && subArea.worldmap.id != selectedSubArea.worldmap.id)
                  {
                     showCustomWorldMap = false;
                     break;
                  }
               }
            }
            if(showCustomWorldMap)
            {
               this._currentWorldMap = selectedSubArea.worldmap;
            }
            else
            {
               this._currentWorldMap = selectedSubArea.area.superArea.worldmap;
            }
         }
         else
         {
            this._currentWorldMap = selectedSubArea.area.superArea.worldmap;
         }
         if(!this._currentWorldMap)
         {
            return;
         }
         _currentSuperarea = selectedSubArea.area.superArea;
         _currentWorldId = this._currentWorldMap.id;
         mapViewer.autoSizeIcon = true;
         mapViewer.origineX = this._currentWorldMap.origineX;
         mapViewer.origineY = this._currentWorldMap.origineY;
         mapViewer.mapWidth = this._currentWorldMap.mapWidth;
         mapViewer.mapHeight = this._currentWorldMap.mapHeight;
         mapViewer.minScale = this._currentWorldMap.minScale;
         mapViewer.maxScale = this._currentWorldMap.maxScale;
         mapViewer.startScale = this._currentWorldMap.minScale;
         mapViewer.removeAllMap();
         for each(zoom in this._currentWorldMap.zoom)
         {
            mapViewer.addMap(parseFloat(zoom),uiApi.me().getConstant("maps_uri") + this._currentWorldMap.id + "/" + zoom + "/",this._currentWorldMap.totalWidth,this._currentWorldMap.totalHeight,250,250);
         }
         mapViewer.finalize();
         mapViewer.addLayer(AREAS_SHAPES_LAYER);
         mapViewer.showLayer(AREAS_SHAPES_LAYER,true);
         mapViewer.addLayer(HINTS_LAYER);
         mapViewer.showLayer(HINTS_LAYER,true);
         mapViewer.addLayer(DUNGEONS_LAYER);
         mapViewer.showLayer(DUNGEONS_LAYER,true);
         mapViewer.addLayer(FLAGS_LAYER);
         mapViewer.showLayer(FLAGS_LAYER,true);
         subArea = mapApi.getSubArea(selectedSubArea.id);
         dungeonId = mapApi.isDungeonSubArea(selectedSubArea.id);
         if(dungeonId == -1)
         {
            if(subArea.worldmap && subArea.worldmap.id == currentWorldId)
            {
               mapViewer.addAreaShape(AREAS_SHAPES_LAYER,"shape_" + selectedSubArea.id,mapApi.getSubAreaShape(selectedSubArea.id),16711680,0.5,16711680,0.5);
            }
         }
         else
         {
            this._dungeons[selectedSubArea.id] = dungeonId;
         }
         this.addSubAreaPositionFlag(selectedSubArea.id,16711680);
         if(pSubAreasIds)
         {
            for each(subareaId in pSubAreasIds)
            {
               subArea = mapApi.getSubArea(subareaId);
               if(subareaId != selectedSubArea.id && (subArea.worldmap && subArea.worldmap.id == currentWorldId))
               {
                  dungeonId = mapApi.isDungeonSubArea(subareaId);
                  if(dungeonId == -1)
                  {
                     mapViewer.addAreaShape(AREAS_SHAPES_LAYER,"shape_" + subareaId,mapApi.getSubAreaShape(subareaId),16711680,0.3,16711680,0.3);
                  }
                  else
                  {
                     this._dungeons[subareaId] = dungeonId;
                  }
                  this.addSubAreaPositionFlag(subareaId,16711680);
               }
            }
         }
         var areasShapes:Array = mapViewer.getMapElementsByLayer(AREAS_SHAPES_LAYER);
         for each(mapAreaShape in areasShapes)
         {
            mapViewer.areaShapeColorTransform(mapAreaShape,100,1,1,1,1);
         }
         hints = mapApi.getHints();
         for each(hint in hints)
         {
            if(!(hint.worldMapId != selectedSubArea.worldmap.id || hint.categoryId != DataEnum.HINT_CATEGORY_TRANSPORTATIONS))
            {
               switch(hint.gfx)
               {
                  case 410:
                  case 412:
                  case 413:
                  case 433:
                  case 900:
                     mapViewer.addIcon(HINTS_LAYER,"hint_" + hint.id,this._iconsUri + hint.gfx + ".png",hint.x,hint.y,1,hint.name,false,-1,true,true,null,true,false,HintPriorityEnum.TRANSPORTS);
               }
            }
         }
         flags = modCartography.getFlags(this._currentWorldMap.id);
         for each(flag in flags)
         {
            if(flag.id.indexOf("flag_custom") != -1 && !mapViewer.getMapElement(flag.id))
            {
               addCustomFlag(flag.position.x,flag.position.y);
            }
         }
         mapViewer.onMapElementsUpdated = this.onMapElementsUpdated;
         mapViewer.updateMapElements();
         center = this.getSubAreaCenter(selectedSubArea.id);
         if(center)
         {
            mapViewer.moveTo(center.x,center.y);
         }
      }
      
      private function onMapElementsUpdated() : void
      {
         zoom = mapViewer.minScale;
      }
      
      private function addFlag(pX:int, pY:int, pId:String, pUri:String = null, pScale:Number = 1, pLegend:String = null, pColor:int = -1, canBeManuallyRemoved:Boolean = true) : void
      {
         mapViewer.addIcon(FLAGS_LAYER,pId,pUri,pX,pY,pScale,pLegend,true,pColor,true,canBeManuallyRemoved,null,true,false,HintPriorityEnum.FLAGS);
      }
      
      private function addSubAreaPositionFlag(pSubAreaId:int, pColor:int) : void
      {
         var flagUri:String = null;
         var subArea:SubArea = mapApi.getSubArea(pSubAreaId);
         if(!subArea.worldmap || subArea.worldmap.id != currentWorldId)
         {
            return;
         }
         var pos:Point = this.getSubAreaCenter(pSubAreaId);
         if(pos)
         {
            if(!this._dungeons[pSubAreaId])
            {
               if(this._notVisible.indexOf(pSubAreaId) != -1)
               {
                  flagUri = this._flagUri;
               }
               this.addFlag(pos.x,pos.y,"flag_" + pSubAreaId,flagUri,2,subArea.area.name + " - " + subArea.name,pColor);
            }
            else
            {
               mapViewer.addIcon(DUNGEONS_LAYER,"dungeon_" + pSubAreaId,this._iconsUri + "422.png",pos.x,pos.y,1,subArea.name,true,-1,true,true,null,true,false,HintPriorityEnum.FLAGS);
            }
         }
      }
      
      private function getSubAreaCenter(pSubAreaId:int) : Point
      {
         var dungeon:Dungeon = null;
         var entranceMapPos:MapPosition = null;
         var subArea:SubArea = null;
         var mapId:Number = NaN;
         var mapPos:MapPosition = null;
         if(this._dungeons[pSubAreaId])
         {
            dungeon = this.dataApi.getDungeon(this._dungeons[pSubAreaId]);
            entranceMapPos = mapApi.getMapPositionById(dungeon.entranceMapId);
            return new Point(entranceMapPos.posX,entranceMapPos.posY);
         }
         var center:Point = mapApi.getSubAreaCenter(pSubAreaId);
         if(!center)
         {
            subArea = mapApi.getSubArea(pSubAreaId);
            for each(mapId in subArea.mapIds)
            {
               mapPos = mapApi.getMapPositionById(mapId);
               if(mapPos)
               {
                  this._notVisible.push(pSubAreaId);
                  return new Point(mapPos.posX,mapPos.posY);
               }
            }
            return null;
         }
         return center;
      }
      
      private function toggleDisplayGrid() : void
      {
         mapViewer.showGrid = !mapViewer.showGrid;
         sysApi.setData("ShowMapGrid",mapViewer.showGrid,DataStoreEnum.BIND_ACCOUNT);
      }
      
      private function onFlagAdded(pFlagId:String, pWorldMapId:int, pX:int, pY:int, pColor:int, pFlagLegend:String, canBeManuallyRemoved:Boolean = true, allowDuplicate:Boolean = false) : void
      {
         sysApi.sendAction(new PlaySoundAction(["16039"]));
         if(pFlagId.indexOf("flag_custom") != -1 && !mapViewer.getMapElement(pFlagId))
         {
            mapViewer.addIcon(FLAGS_LAYER,pFlagId,this._flagUri,pX,pY,1,pFlagLegend,true,pColor,true,canBeManuallyRemoved,null,true,false,HintPriorityEnum.FLAGS);
         }
         mapViewer.updateMapElements();
      }
      
      override protected function onFlagRemoved(pFlagId:String, pWorldMapId:int) : void
      {
         super.onFlagRemoved(pFlagId,pWorldMapId);
         removeFlag(pFlagId);
      }
      
      override public function unload() : void
      {
         super.unload();
      }
      
      override public function onMapElementRightClick(pMap:MapViewer, pTarget:MapIconElement) : void
      {
         if(pTarget.id.indexOf("flag_custom") != -1)
         {
            super.onMapElementRightClick(pMap,pTarget);
         }
      }
      
      override public function onRelease(pTarget:GraphicContainer) : void
      {
         super.onRelease(pTarget);
         switch(pTarget)
         {
            case this.btn_close:
               uiApi.unloadUi(uiApi.me().name);
               break;
            case this.btn_player:
               if(this.playerApi.currentSubArea().area.superAreaId == _currentSuperarea.id && mapViewer.zoomFactor >= mapViewer.minScale)
               {
                  mapViewer.moveTo(this.playerApi.currentMap().outdoorX,this.playerApi.currentMap().outdoorY);
                  if(!mapViewer.getMapElement("flag_playerPosition") && _currentWorldId == PlayedCharacterManager.getInstance().currentWorldMapId)
                  {
                     this.addFlag(this.playerApi.currentMap().outdoorX,this.playerApi.currentMap().outdoorY,"flag_playerPosition",sysApi.getConfigEntry("config.gfx.path") + "icons/hintsShadow/character.png",1,uiApi.getText("ui.cartography.yourposition"),39423,false);
                     mapViewer.updateMapElements();
                  }
               }
               break;
            case mapViewer:
               if(this._addingFlag)
               {
                  addCustomFlag(mapViewer.currentMouseMapX,mapViewer.currentMouseMapY);
               }
               break;
            case this.btn_help:
               hintsApi.showSubHints();
         }
      }
      
      override public function onRollOver(pTarget:GraphicContainer) : void
      {
         var tooltipText:String = null;
         super.onRollOver(pTarget);
         switch(pTarget)
         {
            case mapViewer:
               if(!mapViewer.useFlagCursor && this._addingFlag)
               {
                  mapViewer.useFlagCursor = true;
               }
               break;
            case this.btn_player:
               tooltipText = uiApi.getText("ui.map.player");
         }
         if(tooltipText)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),pTarget,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      override public function onRollOut(pTarget:GraphicContainer) : void
      {
         super.onRollOut(pTarget);
         if(pTarget == mapViewer)
         {
            if(this._addingFlag)
            {
               mapViewer.useFlagCursor = false;
            }
         }
         else
         {
            uiApi.hideTooltip();
         }
      }
      
      override protected function createContextMenu(contextMenu:Array = null) : void
      {
         if(!contextMenu)
         {
            contextMenu = [];
         }
         var gridTextKey:String = !!mapViewer.showGrid ? "ui.option.hideGrid" : "ui.option.displayGrid";
         contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText(gridTextKey),this.toggleDisplayGrid));
         super.createContextMenu(contextMenu);
      }
   }
}
