package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.data.map.TacticalModeTemplate;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.renderers.TacticalModeRenderer;
   import com.ankamagames.atouin.renderers.TrapZoneRenderer;
   import com.ankamagames.atouin.renderers.ZoneClipRenderer;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.resources.adapters.TacticalTemplatesAdapter;
   import com.ankamagames.atouin.types.CellReference;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.utils.CellIdConverter;
   import com.ankamagames.atouin.utils.CellUtil;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.frames.FightTurnFrame;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayInteractivesFrame;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSwfAdapter;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.types.zones.ZRectangle;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class TacticModeManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TacticModeManager));
      
      private static var SWF_LIB:String = XmlConfig.getInstance().getEntry("config.ui.skin").concat("assets_tacticmod.swf");
      
      private static var TILES_REACHABLE:Array = ["floor01","floor02"];
      
      private static var TILES_NO_MVT:Array = ["BlocageMvt"];
      
      private static var TILES_NO_VIEW:Array = ["block01","block02","block03"];
      
      private static var SHOW_BLOC_MOVE:Boolean = false;
      
      private static var SHOW_BACKGROUND:Boolean = false;
      
      private static var _self:TacticModeManager;
      
      private static const DEBUG_FIGHT_MODE:int = 0;
      
      private static const DEBUG_RP_MODE:int = 1;
       
      
      private var _roleplayInteractivesFrame:RoleplayInteractivesFrame;
      
      private var _tacticReachableRangeSelection:Selection;
      
      private var _tacticUnreachableRangeSelection:Selection;
      
      private var _tacticOtherSelection:Selection;
      
      private var _debugCellId:uint;
      
      private var _debugMode:Boolean = false;
      
      private var _debugCache:Boolean = true;
      
      private var _debugType:int;
      
      private var _showFightZone:Boolean = false;
      
      private var _fightZone:Selection;
      
      private var _showInteractiveCells:Boolean = false;
      
      private var _interactiveCellsZone:Selection;
      
      private var _showScaleZone:Boolean = false;
      
      private var _scaleZone:Selection;
      
      private var _flattenCells:Boolean;
      
      private var _showBlockMvt:Boolean = true;
      
      private var _dmp:DataMapProvider;
      
      private var _cellsRef:Array;
      
      private var _cellsData:Vector.<CellData>;
      
      private var _cellZones:Vector.<int>;
      
      private var _currentNbZone:int = 0;
      
      private var _zones:Array;
      
      private var _tacticModeActivated:Boolean = false;
      
      private var _currentMapId:Number;
      
      private var _nbMov:int;
      
      private var _nbLos:int;
      
      private var _reachablePath:Vector.<uint>;
      
      private var _unreachablePath:Vector.<uint>;
      
      private var _otherPath:Vector.<uint>;
      
      private var _background:Sprite;
      
      private var _colorTransformByTileName:Dictionary;
      
      private var _templates:Dictionary;
      
      private var _loadingTemplates:Boolean;
      
      private var _templateToShow:uint;
      
      private var _templatesLoadedCallback:Callback;
      
      private var _currentTemplateId:int;
      
      private var _useNewTacticalMode:Boolean;
      
      public function TacticModeManager()
      {
         this._colorTransformByTileName = new Dictionary();
         super();
         this._dmp = DataMapProvider.getInstance();
      }
      
      public static function getInstance() : TacticModeManager
      {
         if(_self == null)
         {
            _self = new TacticModeManager();
         }
         return _self;
      }
      
      private function initTemplates() : void
      {
         this._loadingTemplates = true;
         var loader:IResourceLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
         loader.addEventListener(ResourceLoadedEvent.LOADED,this.onTemplatesFileLoaded,false,0,true);
         loader.addEventListener(ResourceErrorEvent.ERROR,this.onTemplatesFileError);
         loader.load(new Uri(Atouin.getInstance().options.getOption("tacticalModeTemplatesPath")),null,TacticalTemplatesAdapter);
      }
      
      private function onTemplatesFileLoaded(pEvt:ResourceLoadedEvent) : void
      {
         pEvt.currentTarget.removeEventListener(ResourceLoadedEvent.LOADED,this.onTemplatesFileLoaded);
         pEvt.currentTarget.removeEventListener(ResourceErrorEvent.ERROR,this.onTemplatesFileError);
         this._templates = pEvt.resource;
         this._loadingTemplates = false;
         if(this._templateToShow && this._templatesLoadedCallback)
         {
            this._templatesLoadedCallback.exec();
         }
      }
      
      private function onTemplatesFileError(pEvt:ResourceErrorEvent) : void
      {
         _log.error("Unable to load " + pEvt.uri);
         pEvt.currentTarget.removeEventListener(ResourceLoadedEvent.LOADED,this.onTemplatesFileLoaded);
         pEvt.currentTarget.removeEventListener(ResourceErrorEvent.ERROR,this.onTemplatesFileError);
         this._loadingTemplates = false;
      }
      
      public function getColorTransformForTile(spriteName:String) : ColorTransform
      {
         var color:Number = NaN;
         var R:* = 0;
         var V:* = 0;
         var B:* = 0;
         if(!this._colorTransformByTileName[spriteName])
         {
            color = XmlConfig.getInstance().getEntry("colors.tacticmode." + spriteName);
            if(isNaN(color))
            {
               this._colorTransformByTileName[spriteName] = new ColorTransform();
            }
            else
            {
               R = color >> 16 & 255;
               V = color >> 8 & 255;
               B = color >> 0 & 255;
               this._colorTransformByTileName[spriteName] = new ColorTransform(0,0,0,1,R,V,B);
            }
         }
         return this._colorTransformByTileName[spriteName];
      }
      
      public function show(pPoint:WorldPointWrapper, openByTerminal:Boolean = false) : void
      {
         var i:int = 0;
         var len:int = 0;
         var templateId:int = 0;
         var template:TacticalModeTemplate = null;
         var scaleZone:Vector.<uint> = null;
         var cellData:CellData = null;
         var cellRef:CellReference = null;
         var zone:int = 0;
         var cellPoint:MapPoint = null;
         var cellInteractionCtr:DisplayObjectContainer = null;
         var canMov:Boolean = false;
         var canLos:Boolean = false;
         var nonWalkableDuringFight:Boolean = false;
         var nonWalkableDuringRp:Boolean = false;
         var tmpZonesList:Array = null;
         var o:Object = null;
         var pt:Point = null;
         var zonesMaxY:int = 0;
         var zonesMinY:int = 0;
         var zonesMaxX:int = 0;
         var zonesMinX:int = 0;
         var z:Object = null;
         if(this._tacticModeActivated)
         {
            return;
         }
         var useNewTacticalMode:Boolean = OptionManager.getOptionManager("dofus").getOption("useNewTacticalMode");
         var tacticModeChanged:* = this._useNewTacticalMode != useNewTacticalMode;
         this._useNewTacticalMode = useNewTacticalMode;
         if(useNewTacticalMode)
         {
            templateId = MapPosition.getMapPositionById(pPoint.mapId).tacticalModeTemplateId;
            if(!templateId)
            {
               templateId = MapDisplayManager.getInstance().getDataMapContainer().dataMap.tacticalModeTemplateId;
            }
            this._templateToShow = OptionManager.getOptionManager("dofus").getOption("forceDefaultTacticalModeTemplate") == true ? uint(1) : uint(Math.max(templateId,1));
            if(this._loadingTemplates)
            {
               return;
            }
            if(!this._templates)
            {
               this._templatesLoadedCallback = new Callback(this.show,pPoint,openByTerminal);
               this.initTemplates();
               return;
            }
            template = this._templates[this._templateToShow];
            if(!template)
            {
               _log.error("Couldn\'t find data for the template " + this._templateToShow);
               template = this._templates[1];
               if(!template)
               {
                  _log.error("Couldn\'t find data for the default template");
                  return;
               }
            }
         }
         if(!openByTerminal)
         {
            this._debugMode = false;
            SHOW_BLOC_MOVE = false;
         }
         else
         {
            this._debugMode = true;
            SHOW_BLOC_MOVE = true;
         }
         if(this._roleplayInteractivesFrame == null)
         {
            this._roleplayInteractivesFrame = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
         }
         this._tacticModeActivated = true;
         KernelEventsManager.getInstance().processCallback(HookList.ShowTacticMode,true);
         if(this._debugMode && this._debugCache || !this._debugMode && !tacticModeChanged && this._currentMapId && this._currentMapId == pPoint.mapId && this._cellsRef.length > 0 && (!useNewTacticalMode || this._currentTemplateId == template.id))
         {
            if(this._cellsRef == null || this._cellsRef[0] == null)
            {
               this._cellsRef = MapDisplayManager.getInstance().getDataMapContainer().getCell();
               this._cellsData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells;
            }
            len = this._cellsRef.length;
            if(!this._debugMode || this._debugMode && this._flattenCells)
            {
               for(i = 0; i < len; i += 1)
               {
                  if(this._cellsRef[i] != null)
                  {
                     this._cellsRef[i].visible = true;
                     this._cellsRef[i].visible = false;
                     if(this._cellsData[i].floor != 0)
                     {
                        cellInteractionCtr = InteractiveCellManager.getInstance().getCell(this._cellsRef[i].id);
                        cellInteractionCtr.y = this._cellsRef[i].elevation + this._cellsData[i].floor;
                        this.updateEntitiesOnCell(i);
                     }
                  }
               }
               this.updateMarks();
               this.updateMovementArea();
            }
            SelectionManager.getInstance().addSelection(this._tacticReachableRangeSelection,"tacticReachableRange",0);
            if(!this._debugMode || this._showBlockMvt)
            {
               SelectionManager.getInstance().addSelection(this._tacticUnreachableRangeSelection,"tacticUnreachableRange",0);
            }
            if(SHOW_BLOC_MOVE && this._nbMov > this._nbLos)
            {
               SelectionManager.getInstance().addSelection(this._tacticOtherSelection,"tacticOtherRange",0);
            }
            else if(!SHOW_BLOC_MOVE && this._tacticOtherSelection && SelectionManager.getInstance().getSelection("tacticOtherRange") != null)
            {
               SelectionManager.getInstance().getSelection("tacticOtherRange").remove();
            }
            if(this._debugMode && this._fightZone)
            {
               if(this._showFightZone)
               {
                  SelectionManager.getInstance().addSelection(this._fightZone,"debugSelection",this._debugCellId);
               }
               else
               {
                  SelectionManager.getInstance().getSelection("debugSelection").remove();
               }
            }
            if(this._debugMode && this._scaleZone)
            {
               if(this._showScaleZone)
               {
                  SelectionManager.getInstance().addSelection(this._scaleZone,"scaleZone",this._debugCellId);
               }
               else
               {
                  SelectionManager.getInstance().getSelection("scaleZone").remove();
               }
            }
            if(this._debugMode && this._interactiveCellsZone)
            {
               if(this._showInteractiveCells)
               {
                  SelectionManager.getInstance().addSelection(this._interactiveCellsZone,"interactiveCellsZone",this._debugCellId);
               }
               else
               {
                  SelectionManager.getInstance().getSelection("interactiveCellsZone").remove();
               }
            }
         }
         else
         {
            this._currentMapId = pPoint.mapId;
            this._reachablePath = new Vector.<uint>();
            this._unreachablePath = new Vector.<uint>();
            this._otherPath = new Vector.<uint>();
            scaleZone = new Vector.<uint>();
            this._cellsRef = MapDisplayManager.getInstance().getDataMapContainer().getCell();
            this._cellsData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells;
            len = this._cellsRef.length;
            this._cellZones = new Vector.<int>(len);
            this._currentNbZone = 0;
            this._nbMov = 0;
            this._nbLos = 0;
            for(i = 0; i < len; i += 1)
            {
               cellRef = this._cellsRef[i];
               cellData = this._cellsData[i];
               cellRef.visible = true;
               cellRef.visible = false;
               if(!cellRef.isDisabled)
               {
                  zone = this.getCellZone(i);
                  cellPoint = MapPoint.fromCellId(i);
                  canMov = this._dmp.pointMov(cellPoint.x,cellPoint.y) && (this._debugMode || !this._debugMode && !this._dmp.farmCell(cellPoint.x,cellPoint.y));
                  canLos = this._dmp.pointLos(cellPoint.x,cellPoint.y);
                  nonWalkableDuringFight = cellData.nonWalkableDuringFight;
                  nonWalkableDuringRp = cellData.nonWalkableDuringRP;
                  if(cellData.moveZone)
                  {
                     scaleZone.push(cellRef.id);
                  }
                  if((!this._debugMode || this._debugMode && this._flattenCells) && cellData.floor != 0)
                  {
                     cellInteractionCtr = InteractiveCellManager.getInstance().getCell(cellRef.id);
                     cellInteractionCtr.y = cellRef.elevation + cellData.floor;
                     this.updateEntitiesOnCell(i);
                  }
                  if(this.canMoveOnThisCell(canMov,nonWalkableDuringFight,nonWalkableDuringRp))
                  {
                     if(zone > 0)
                     {
                        this._cellZones[i] = zone;
                     }
                     else
                     {
                        ++this._currentNbZone;
                        this._cellZones[i] = this._currentNbZone;
                     }
                  }
                  else if(canLos && !this.canMoveOnThisCell(canMov,nonWalkableDuringFight,nonWalkableDuringRp))
                  {
                     this._cellZones[i] = 0;
                  }
                  else if(!canLos && !this.canMoveOnThisCell(canMov,nonWalkableDuringFight,nonWalkableDuringRp))
                  {
                     this._cellZones[i] = -1;
                  }
               }
            }
            this.updateMarks();
            this.updateMovementArea();
            this.updateCellWithRealCellZone();
            tmpZonesList = new Array();
            this._zones = new Array();
            for(i = 0; i < len; i += 1)
            {
               switch(this._cellZones[i])
               {
                  case -1:
                     this._unreachablePath.push(i);
                     break;
                  case 0:
                     if(SHOW_BLOC_MOVE && this.getInformations(i)[0])
                     {
                        this._otherPath.push(i);
                        ++this._nbLos;
                     }
                     break;
                  default:
                     if(tmpZonesList.indexOf(this._cellZones[i]) == -1)
                     {
                        tmpZonesList.push(this._cellZones[i]);
                     }
                     pt = CellIdConverter.cellIdToCoord(i);
                     if(this._zones[this._cellZones[i]] == null)
                     {
                        o = new Object();
                        o.map = new Vector.<int>();
                        o.maxX = pt.x;
                        o.minX = pt.x;
                        o.maxY = pt.y;
                        o.minY = pt.y;
                        this._zones[this._cellZones[i]] = o;
                     }
                     else
                     {
                        o = this._zones[this._cellZones[i]];
                        if(pt.x > o.maxX)
                        {
                           o.maxX = pt.x;
                        }
                        if(pt.x < o.minX)
                        {
                           o.minX = pt.x;
                        }
                        if(pt.y > o.maxY)
                        {
                           o.maxY = pt.y;
                        }
                        if(pt.y < o.minY)
                        {
                           o.minY = pt.y;
                        }
                     }
                     this._zones[this._cellZones[i]].map.push(i);
                     if(this._reachablePath.indexOf(i) == -1)
                     {
                        this._reachablePath.push(i);
                     }
                     ++this._nbMov;
                     break;
               }
            }
            this._currentNbZone = tmpZonesList.length;
            tmpZonesList = null;
            for each(z in this._zones)
            {
               if(!zonesMaxX)
               {
                  zonesMaxX = z.maxX;
               }
               else
               {
                  zonesMaxX = Math.max(zonesMaxX,z.maxX);
               }
               if(!zonesMinY)
               {
                  zonesMinX = z.minX;
               }
               else
               {
                  zonesMinX = Math.min(zonesMinX,z.minX);
               }
               if(!zonesMaxY)
               {
                  zonesMaxY = z.maxY;
               }
               else
               {
                  zonesMaxY = Math.max(zonesMaxY,z.maxY);
               }
               if(!zonesMinY)
               {
                  zonesMinY = z.minY;
               }
               else
               {
                  zonesMinY = Math.min(zonesMinY,z.minY);
               }
            }
            this.clearUnneededCells(zonesMaxX,zonesMaxY,zonesMinX,zonesMinY);
            this._tacticReachableRangeSelection = new Selection();
            if(!useNewTacticalMode)
            {
               this._tacticReachableRangeSelection.renderer = new ZoneClipRenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER,SWF_LIB,TILES_REACHABLE,-1,false,true,[this.getColorTransformForTile("floor01"),this.getColorTransformForTile("floor02")]);
            }
            else
            {
               this._tacticReachableRangeSelection.renderer = new TacticalModeRenderer(template.groundCells,-1,PlacementStrataEnums.STRATA_NO_Z_ORDER);
            }
            this._tacticReachableRangeSelection.zone = new Custom(this._reachablePath);
            SelectionManager.getInstance().addSelection(this._tacticReachableRangeSelection,"tacticReachableRange",0);
            if(!this._debugMode || this._showBlockMvt)
            {
               this._tacticUnreachableRangeSelection = new Selection();
               if(!useNewTacticalMode)
               {
                  this._tacticUnreachableRangeSelection.renderer = new ZoneClipRenderer(PlacementStrataEnums.STRATA_AREA,SWF_LIB,TILES_NO_VIEW,-2,false,true,[this.getColorTransformForTile("block01"),this.getColorTransformForTile("block02"),this.getColorTransformForTile("block03")]);
               }
               else
               {
                  this._tacticUnreachableRangeSelection.renderer = new TacticalModeRenderer(template.lineOfSightCells,this._currentMapId,PlacementStrataEnums.STRATA_PLAYER);
                  (this._tacticUnreachableRangeSelection.renderer as TacticalModeRenderer).reachableCells = this._reachablePath;
               }
               this._tacticUnreachableRangeSelection.zone = new Custom(this._unreachablePath);
               SelectionManager.getInstance().addSelection(this._tacticUnreachableRangeSelection,"tacticUnreachableRange",0);
            }
            if(this._nbMov > this._nbLos && SHOW_BLOC_MOVE || this._debugMode)
            {
               this._tacticOtherSelection = new Selection();
               this._tacticOtherSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER);
               this._tacticOtherSelection.color = new Color(717337);
               this._tacticOtherSelection.zone = new Custom(this._otherPath);
            }
            if(this._debugMode && this._showScaleZone)
            {
               this._scaleZone = new Selection();
               this._scaleZone.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER);
               this._scaleZone.color = new Color(5085175);
               this._scaleZone.zone = new Custom(scaleZone);
               SelectionManager.getInstance().addSelection(this._scaleZone,"scaleZone",this._debugCellId);
            }
            if(this._debugMode && this._showFightZone)
            {
               SelectionManager.getInstance().addSelection(this._fightZone,"debugSelection",this._debugCellId);
            }
            if(this._debugMode && this._showInteractiveCells)
            {
               this._interactiveCellsZone = new Selection();
               this._interactiveCellsZone.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER);
               this._interactiveCellsZone.color = new Color(16777215);
               this._interactiveCellsZone.zone = new Custom(this._roleplayInteractivesFrame.getInteractiveElementsCells());
               SelectionManager.getInstance().addSelection(this._interactiveCellsZone,"interactiveCellsZone",this._debugCellId);
            }
         }
         MapDisplayManager.getInstance().hideBackgroundForTacticMode(true,!useNewTacticalMode ? uint(0) : uint(template.backgroundColor));
         if(SHOW_BACKGROUND)
         {
            this.loadBackground();
         }
         if(useNewTacticalMode)
         {
            this._currentTemplateId = template.id;
         }
      }
      
      private function canMoveOnThisCell(canMov:Boolean, nonWalkableDuringFight:Boolean, nonWalkableDuringRp:Boolean) : Boolean
      {
         if(!canMov)
         {
            return false;
         }
         if((!this._debugMode || this._debugMode && this._debugType == DEBUG_FIGHT_MODE) && nonWalkableDuringFight)
         {
            return false;
         }
         if(this._debugMode && this._debugType == DEBUG_RP_MODE && nonWalkableDuringRp)
         {
            return false;
         }
         return true;
      }
      
      public function hide(force:Boolean = false) : void
      {
         var s:Selection = null;
         var cellRef:CellReference = null;
         var cellData:CellData = null;
         var i:int = 0;
         var cellInteractionCtr:DisplayObjectContainer = null;
         this._templateToShow = 0;
         if(!this._tacticModeActivated)
         {
            return;
         }
         this._tacticModeActivated = false;
         if(!force)
         {
            KernelEventsManager.getInstance().processCallback(HookList.ShowTacticMode,false);
         }
         if(SHOW_BACKGROUND)
         {
            this.removeBackground();
         }
         s = SelectionManager.getInstance().getSelection("tacticReachableRange");
         if(s)
         {
            s.remove();
         }
         s = SelectionManager.getInstance().getSelection("tacticUnreachableRange");
         if(s)
         {
            s.remove();
         }
         if(this._tacticOtherSelection != null)
         {
            s = SelectionManager.getInstance().getSelection("tacticOtherRange");
            if(s)
            {
               s.remove();
            }
         }
         if(this._interactiveCellsZone != null)
         {
            s = SelectionManager.getInstance().getSelection("interactiveCellsZone");
            if(s)
            {
               s.remove();
            }
         }
         if(this._scaleZone != null)
         {
            s = SelectionManager.getInstance().getSelection("scaleZone");
            if(s)
            {
               s.remove();
            }
         }
         if(this._fightZone != null)
         {
            s = SelectionManager.getInstance().getSelection("debugSelection");
            if(s)
            {
               s.remove();
            }
         }
         var len:int = this._cellsRef.length;
         for(i = 0; i < len; i++)
         {
            cellRef = this._cellsRef[i];
            if(cellRef)
            {
               cellData = this._cellsData[i];
               if(cellRef)
               {
                  cellRef.visible = true;
               }
               if(cellData.floor != 0)
               {
                  cellInteractionCtr = InteractiveCellManager.getInstance().getCell(cellRef.id);
                  cellInteractionCtr.y = cellRef.elevation;
                  this.updateEntitiesOnCell(i);
               }
            }
         }
         this.updateMarks();
         this.updateMovementArea();
         MapDisplayManager.getInstance().hideBackgroundForTacticMode(false);
      }
      
      private function updateEntitiesOnCell(cellId:uint) : void
      {
         var characterEntity:AnimatedCharacter = null;
         var e:IEntity = null;
         var entities:Array = EntitiesManager.getInstance().getEntitiesOnCell(cellId);
         for each(e in entities)
         {
            characterEntity = DofusEntities.getEntity(e.id) as AnimatedCharacter;
            if(characterEntity)
            {
               characterEntity.jump(characterEntity.position);
            }
         }
      }
      
      private function updateMarks() : void
      {
         var mi:MarkInstance = null;
         var s:Selection = null;
         var markGlyph:Glyph = null;
         for each(mi in MarkedCellsManager.getInstance().getAllMarks())
         {
            for each(s in mi.selections)
            {
               (s.renderer as TrapZoneRenderer).updateDisplay();
               markGlyph = MarkedCellsManager.getInstance().getGlyph(mi.markId);
               if(markGlyph)
               {
                  markGlyph.display(PlacementStrataEnums.STRATA_GLYPH);
               }
            }
         }
      }
      
      private function updateMovementArea() : void
      {
         var fightTurnFrame:FightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
         if(fightTurnFrame && fightTurnFrame.myTurn && fightTurnFrame.movementAreaSelection)
         {
            (fightTurnFrame.movementAreaSelection.renderer as ZoneDARenderer).updateDisplay();
         }
      }
      
      private function clearUnneededCells(zonesMaxX:int, zonesMaxY:int, zonesMinX:int, zonesMinY:int) : void
      {
         var uCell:uint = 0;
         var i:int = 0;
         var infos:Array = null;
         var avgX:int = zonesMaxX - zonesMinX;
         var avgY:int = Math.abs(zonesMinY) + Math.abs(zonesMaxY);
         var centerCellId:int = CellIdConverter.coordToCellId(avgX / 2 + zonesMinX,avgY / 2 + zonesMinY);
         var l:ZRectangle = new ZRectangle(0,avgX / 2,avgY / 2,null);
         var collideCells:Vector.<uint> = l.getCells(centerCellId);
         if(this._debugMode && this._showFightZone)
         {
            this._fightZone = new Selection();
            this._fightZone.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            this._fightZone.color = new Color(16772608);
            this._fightZone.zone = l;
            this._debugCellId = centerCellId;
         }
         var unreachablePathDuplicate:Vector.<uint> = this._unreachablePath.concat();
         var len:int = unreachablePathDuplicate.length;
         for(i = 0; i < len; i += 1)
         {
            uCell = unreachablePathDuplicate[i];
            infos = this.getInformations(uCell);
            if(infos[1] || collideCells.indexOf(uCell) == -1 && !infos[0])
            {
               this._unreachablePath.splice(this._unreachablePath.indexOf(uCell),1);
            }
         }
         unreachablePathDuplicate = null;
      }
      
      private function updateCellWithRealCellZone() : void
      {
         var zone:int = 0;
         var isLeftCol:Boolean = false;
         var isRightCol:Boolean = false;
         var isEvenRow:Boolean = false;
         var zones:Vector.<int> = null;
         var cellId:int = 0;
         var i:int = 0;
         var len2:int = 0;
         var j:int = 0;
         var minValue:int = 0;
         var maxValue:int = 0;
         var len:int = this._cellZones.length;
         var collideZones:Array = new Array();
         for(cellId = 0; cellId < len; cellId += 1)
         {
            zone = this._cellZones[cellId];
            if(zone > 0)
            {
               isLeftCol = CellUtil.isLeftCol(cellId);
               isRightCol = CellUtil.isRightCol(cellId);
               isEvenRow = CellUtil.isEvenRow(cellId);
               zones = new Vector.<int>();
               if(cellId - 28 > 0 && this._cellZones[cellId - 28] > 0)
               {
                  zones.push(this._cellZones[cellId - 28]);
               }
               if(!isRightCol && cellId + 1 < this._cellZones.length && this._cellZones[cellId + 1] > 0)
               {
                  zones.push(this._cellZones[cellId + 1]);
               }
               if(cellId + 28 < this._cellZones.length && this._cellZones[cellId + 28] > 0)
               {
                  zones.push(this._cellZones[cellId + 28]);
               }
               if(!isLeftCol && cellId - 1 > 0 && this._cellZones[cellId - 1] > 0)
               {
                  zones.push(this._cellZones[cellId - 1]);
               }
               if((!isLeftCol || isLeftCol && !isEvenRow) && cellId + 14 < this._cellZones.length && this._cellZones[cellId + 14] > 0)
               {
                  zones.push(this._cellZones[cellId + 14]);
               }
               if((!isLeftCol || isLeftCol && !isEvenRow) && cellId - 14 > 0 && this._cellZones[cellId - 14] > 0)
               {
                  zones.push(this._cellZones[cellId - 14]);
               }
               if(isEvenRow)
               {
                  if(!isLeftCol && cellId + 13 < this._cellZones.length && this._cellZones[cellId + 13] > 0)
                  {
                     zones.push(this._cellZones[cellId + 13]);
                  }
                  if(!isLeftCol && cellId - 15 > 0 && this._cellZones[cellId - 15] > 0)
                  {
                     zones.push(this._cellZones[cellId - 15]);
                  }
               }
               else
               {
                  if(!isRightCol && cellId - 13 > 0 && this._cellZones[cellId - 13] > 0)
                  {
                     zones.push(this._cellZones[cellId - 13]);
                  }
                  if(!isRightCol && cellId + 15 < this._cellZones.length && this._cellZones[cellId + 15] > 0)
                  {
                     zones.push(this._cellZones[cellId + 15]);
                  }
               }
               if(zones.length > 0)
               {
                  len2 = zones.length;
                  for(i = 0; i < len2; i += 1)
                  {
                     if(zone != zones[i] && !this.containZone(collideZones,zone,zones[i]))
                     {
                        collideZones.push({
                           "z1":zone,
                           "z2":zones[i]
                        });
                     }
                     if(zones[i] < zone)
                     {
                        zone = zones[i];
                     }
                  }
                  if(zone > 0)
                  {
                     this._cellZones[cellId] = zone;
                     if(cellId - 28 > 0 && this._cellZones[cellId - 28] > 0)
                     {
                        this._cellZones[cellId - 28] = zone;
                     }
                     if(cellId - 13 > 0 && this._cellZones[cellId - 13] > 0)
                     {
                        this._cellZones[cellId - 13] = zone;
                     }
                     if(cellId + 1 < this._cellZones.length && this._cellZones[cellId + 1] > 0)
                     {
                        this._cellZones[cellId + 1] = zone;
                     }
                     if(cellId + 15 < this._cellZones.length && this._cellZones[cellId + 15] > 0)
                     {
                        this._cellZones[cellId + 15] = zone;
                     }
                     if(cellId + 28 < this._cellZones.length && this._cellZones[cellId + 28] > 0)
                     {
                        this._cellZones[cellId + 28] = zone;
                     }
                     if(cellId + 14 < this._cellZones.length && this._cellZones[cellId + 14] > 0)
                     {
                        this._cellZones[cellId + 14] = zone;
                     }
                     if(cellId - 1 > 0 && this._cellZones[cellId - 1] > 0)
                     {
                        this._cellZones[cellId - 1] = zone;
                     }
                  }
               }
            }
         }
         if(collideZones.length > 0)
         {
            for(i = 0; i < collideZones.length; i += 1)
            {
               if(this._cellZones.indexOf(collideZones[i].z1) != -1 && this._cellZones.indexOf(collideZones[i].z2) != -1)
               {
                  minValue = Math.min(collideZones[i].z1,collideZones[i].z2);
                  maxValue = Math.max(collideZones[i].z1,collideZones[i].z2);
                  for(j = 0; j < len; j += 1)
                  {
                     if(this._cellZones[j] == maxValue)
                     {
                        this._cellZones[j] = minValue;
                     }
                  }
               }
            }
            collideZones = null;
         }
      }
      
      private function containZone(zones:Array, z1:int, z2:int) : Boolean
      {
         var i:int = 0;
         var len:int = zones.length;
         for(i = 0; i < len; i += 1)
         {
            if(zones[i].z1 == z1 && zones[i].z2 == z2 || zones[i].z1 == z2 && zones[i].z2 == z1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function getCellZone(cellId:int) : int
      {
         var zone:int = -1;
         var isLeftCol:Boolean = CellUtil.isLeftCol(cellId);
         var isRightCol:Boolean = CellUtil.isRightCol(cellId);
         var isEvenRow:Boolean = CellUtil.isEvenRow(cellId);
         if(!isLeftCol && cellId - 1 > 0 && this._cellZones[cellId - 1] > 0)
         {
            zone = this._cellZones[cellId - 1];
         }
         else if(cellId - 28 > 0 && this._cellZones[cellId - 28] > 0)
         {
            zone = this._cellZones[cellId - 28];
         }
         else if(!isEvenRow && !isRightCol && cellId - 13 > 0 && this._cellZones[cellId - 13] > 0)
         {
            zone = this._cellZones[cellId - 13];
         }
         else if(isEvenRow && (!isLeftCol || isLeftCol && !isEvenRow) && cellId - 14 > 0 && this._cellZones[cellId - 14] > 0)
         {
            zone = this._cellZones[cellId - 14];
         }
         return zone;
      }
      
      private function getInformations(cellId:int) : Array
      {
         var isBorder:Boolean = false;
         var isUseless:Boolean = true;
         var isLeftCol:Boolean = CellUtil.isLeftCol(cellId);
         var isRightCol:Boolean = CellUtil.isRightCol(cellId);
         var isEvenRow:Boolean = CellUtil.isEvenRow(cellId);
         if(!isLeftCol && cellId - 1 > 0)
         {
            if(this._cellZones[cellId - 1] > 0)
            {
               isBorder = true;
            }
            if(this._cellZones[cellId - 1] != -1)
            {
               isUseless = false;
            }
         }
         if(!isRightCol && cellId + 1 < this._cellZones.length)
         {
            if(this._cellZones[cellId + 1] > 0)
            {
               isBorder = true;
            }
            if(this._cellZones[cellId + 1] != -1)
            {
               isUseless = false;
            }
         }
         if((!isLeftCol || isLeftCol && !isEvenRow) && cellId + 14 < this._cellZones.length)
         {
            if(this._cellZones[cellId + 14] > 0)
            {
               isBorder = true;
            }
            if(this._cellZones[cellId + 14] != -1)
            {
               isUseless = false;
            }
         }
         if(cellId + 28 < this._cellZones.length)
         {
            if(this._cellZones[cellId + 28] > 0)
            {
               isBorder = true;
            }
            if(this._cellZones[cellId + 28] != -1)
            {
               isUseless = false;
            }
         }
         if((!isLeftCol || isLeftCol && !isEvenRow) && cellId - 14 > 0)
         {
            if(this._cellZones[cellId - 14] > 0)
            {
               isBorder = true;
            }
            if(this._cellZones[cellId - 14] != -1)
            {
               isUseless = false;
            }
         }
         if(cellId - 28 > 0)
         {
            if(this._cellZones[cellId - 28] > 0)
            {
               isBorder = true;
            }
            if(this._cellZones[cellId - 28] != -1)
            {
               isUseless = false;
            }
         }
         if(isEvenRow)
         {
            if(!isLeftCol && cellId + 13 < this._cellZones.length)
            {
               if(this._cellZones[cellId + 13] > 0)
               {
                  isBorder = true;
               }
               if(this._cellZones[cellId + 13] != -1)
               {
                  isUseless = false;
               }
            }
            if(!isLeftCol && cellId - 15 > 0)
            {
               if(this._cellZones[cellId - 15] > 0)
               {
                  isBorder = true;
               }
               if(this._cellZones[cellId - 15] != -1)
               {
                  isUseless = false;
               }
            }
         }
         else
         {
            if(!isRightCol && cellId - 13 > 0)
            {
               if(this._cellZones[cellId - 13] > 0)
               {
                  isBorder = true;
               }
               if(this._cellZones[cellId - 13] != -1)
               {
                  isUseless = false;
               }
            }
            if(!isRightCol && cellId + 15 < this._cellZones.length)
            {
               if(this._cellZones[cellId + 15] > 0)
               {
                  isBorder = true;
               }
               if(this._cellZones[cellId + 15] != -1)
               {
                  isUseless = false;
               }
            }
         }
         return [isBorder,isUseless];
      }
      
      public function get tacticModeActivated() : Boolean
      {
         return this._tacticModeActivated;
      }
      
      private function loadBackground() : void
      {
         var loader:IResourceLoader = null;
         if(this._background == null)
         {
            loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            loader.addEventListener(ResourceLoadedEvent.LOADED,this.onBackgroundLoaded);
            loader.load(new Uri(SWF_LIB),null,AdvancedSwfAdapter);
         }
         else
         {
            MapDisplayManager.getInstance().renderer.container.addChildAt(this._background,0);
         }
      }
      
      private function removeBackground() : void
      {
         if(this._background != null && MapDisplayManager.getInstance().renderer.container.contains(this._background))
         {
            MapDisplayManager.getInstance().renderer.container.removeChild(this._background);
         }
      }
      
      private function onBackgroundLoaded(pEvt:ResourceLoadedEvent = null) : void
      {
         pEvt.currentTarget.removeEventListener(ResourceLoadedEvent.LOADED,this.onBackgroundLoaded);
         var appDomain:ApplicationDomain = pEvt.resource.applicationDomain;
         this._background = new appDomain.getDefinition("BG")() as Sprite;
         this._background.name = "TacticModeBackground";
         MapDisplayManager.getInstance().renderer.container.addChildAt(this._background,0);
      }
      
      public function setDebugMode(pShowFightZone:Boolean = false, pUseCache:Boolean = false, pDebugType:int = 0, pShowInteractiveCells:Boolean = false, pShowScaleZone:Boolean = false, pFlattenCells:Boolean = true, pShowBlockMvt:Boolean = true) : void
      {
         this._showFightZone = pShowFightZone;
         this._debugCache = pUseCache;
         this._debugType = pDebugType;
         this._showInteractiveCells = pShowInteractiveCells;
         this._showScaleZone = pShowScaleZone;
         this._flattenCells = pFlattenCells;
         this._showBlockMvt = pShowBlockMvt;
      }
   }
}
