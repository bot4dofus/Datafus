package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.renderers.CellLinkRenderer;
   import com.ankamagames.atouin.renderers.TrapZoneRenderer;
   import com.ankamagames.atouin.types.CellLink;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.spells.SpellScript;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.dofus.network.enums.GameActionMarkCellsTypeEnum;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
   import com.ankamagames.dofus.scripts.SpellScriptContext;
   import com.ankamagames.dofus.scripts.SpellScriptManager;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import tools.enumeration.GameActionMarkTypeEnum;
   
   public class MarkedCellsManager implements IDestroyable
   {
      
      private static const MARK_SELECTIONS_PREFIX:String = "FightMark";
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(MarkedCellsManager));
      
      private static var _self:MarkedCellsManager;
       
      
      private var _marks:Dictionary;
      
      private var _glyphs:Dictionary;
      
      private var _markUid:uint;
      
      public function MarkedCellsManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("MarkedCellsManager is a singleton and should not be instanciated directly.");
         }
         this._marks = new Dictionary(true);
         this._glyphs = new Dictionary(true);
         this._markUid = 0;
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
      }
      
      public static function getInstance() : MarkedCellsManager
      {
         if(_self == null)
         {
            _self = new MarkedCellsManager();
         }
         return _self;
      }
      
      public function addMark(markCasterId:Number, markId:int, markType:int, associatedSpell:Spell, associatedSpellLevel:SpellLevel, cells:Vector.<GameActionMarkedCell>, teamId:int = 2, markActive:Boolean = true, markImpactCellId:int = -1) : void
      {
         var mi:MarkInstance = null;
         var markedCell:GameActionMarkedCell = null;
         var s:Selection = null;
         var selectionStrata:uint = 0;
         var cellsId:Vector.<uint> = null;
         var gamcell:GameActionMarkedCell = null;
         var cell:uint = 0;
         if(!this._marks[markId] || this._marks[markId].cells.length == 0)
         {
            mi = new MarkInstance();
            mi.markCasterId = markCasterId;
            mi.markId = markId;
            mi.markType = markType;
            mi.associatedSpell = associatedSpell;
            mi.associatedSpellLevel = associatedSpellLevel;
            mi.selections = new Vector.<Selection>(0,false);
            mi.cells = new Vector.<uint>(0,false);
            mi.teamId = teamId;
            mi.active = markActive;
            if(markImpactCellId != -1)
            {
               mi.markImpactCellId = markImpactCellId;
            }
            else if(cells && cells.length && cells[0])
            {
               mi.markImpactCellId = cells[0].cellId;
            }
            else
            {
               _log.warn("Adding a mark with unknown markImpactCellId!");
            }
            if(cells.length > 0)
            {
               markedCell = cells[0];
               s = new Selection();
               s.color = new Color(markedCell.cellColor);
               selectionStrata = !!Atouin.getInstance().options.getOption("transparentOverlayMode") ? uint(PlacementStrataEnums.STRATA_NO_Z_ORDER) : (markType == GameActionMarkTypeEnum.PORTAL ? uint(PlacementStrataEnums.STRATA_PORTAL) : uint(PlacementStrataEnums.STRATA_GLYPH));
               s.renderer = new TrapZoneRenderer(selectionStrata);
               cellsId = new Vector.<uint>();
               for each(gamcell in cells)
               {
                  cellsId.push(gamcell.cellId);
               }
               if(markedCell.cellsType == GameActionMarkCellsTypeEnum.CELLS_CROSS)
               {
                  s.zone = new Cross(SpellShapeEnum.UNKNOWN,0,markedCell.zoneSize,DataMapProvider.getInstance());
               }
               else if(markedCell.zoneSize > 0)
               {
                  s.zone = new Lozenge(SpellShapeEnum.UNKNOWN,0,markedCell.zoneSize,DataMapProvider.getInstance());
               }
               else
               {
                  s.zone = new Custom(cellsId);
               }
               SelectionManager.getInstance().addSelection(s,this.getSelectionUid(),markedCell.cellId);
               for each(cell in s.cells)
               {
                  mi.cells.push(cell);
                  if(mi.markType == GameActionMarkTypeEnum.TRAP)
                  {
                     DataMapProvider.getInstance().obstaclesCells.push(cell);
                  }
               }
               mi.selections.push(s);
            }
            this._marks[markId] = mi;
            this.updateDataMapProvider();
         }
      }
      
      public function getMarks(pMarkType:int, pTeamId:int, pActiveOnly:Boolean = true) : Vector.<MarkInstance>
      {
         var mi:MarkInstance = null;
         var marks:Vector.<MarkInstance> = new Vector.<MarkInstance>();
         for each(mi in this._marks)
         {
            if((pMarkType == 0 || mi.markType == pMarkType) && (pTeamId == TeamEnum.TEAM_SPECTATOR || mi.teamId == pTeamId) && (!pActiveOnly || mi.active))
            {
               marks.push(mi);
            }
         }
         return marks;
      }
      
      public function getAllMarks() : Dictionary
      {
         return this._marks;
      }
      
      public function getMarkDatas(markId:int) : MarkInstance
      {
         return this._marks[markId];
      }
      
      public function removeMark(markId:int) : void
      {
         var cell:uint = 0;
         var cellIndex:int = 0;
         var s:Selection = null;
         var selections:Vector.<Selection> = (this._marks[markId] as MarkInstance).selections;
         for each(s in selections)
         {
            s.remove();
            if(this._marks[markId].markType == GameActionMarkTypeEnum.TRAP)
            {
               for each(cell in s.cells)
               {
                  cellIndex = DataMapProvider.getInstance().obstaclesCells.indexOf(cell);
                  if(cellIndex != -1)
                  {
                     DataMapProvider.getInstance().obstaclesCells.splice(cellIndex,1);
                  }
               }
            }
         }
         delete this._marks[markId];
         this.updateDataMapProvider();
      }
      
      public function addGlyph(glyph:Glyph, markId:int) : void
      {
         var glyphList:Vector.<Glyph> = null;
         var currentGlyph:* = this._glyphs[markId];
         if(currentGlyph)
         {
            if(currentGlyph is Glyph)
            {
               glyphList = Vector.<Glyph>([this._glyphs[markId],glyph]);
               this._glyphs[markId] = glyphList;
            }
            else
            {
               this._glyphs[markId].push(glyph);
            }
         }
         else
         {
            this._glyphs[markId] = glyph;
         }
      }
      
      public function getGlyph(markId:int) : Glyph
      {
         if(this._glyphs[markId] is Vector.<Glyph>)
         {
            if(this._glyphs[markId].length)
            {
               return this._glyphs[markId][0];
            }
            return null;
         }
         return this._glyphs[markId] as Glyph;
      }
      
      public function removeGlyph(markId:int) : void
      {
         var i:int = 0;
         if(this._glyphs[markId])
         {
            if(this._glyphs[markId] is Glyph)
            {
               Glyph(this._glyphs[markId]).remove();
            }
            else
            {
               for(i = 0; i < this._glyphs[markId].length; i++)
               {
                  Glyph(this._glyphs[markId][i]).remove();
               }
            }
            delete this._glyphs[markId];
         }
      }
      
      public function getMarksMapPoint(markType:int, teamId:int = 2, activeOnly:Boolean = true) : Vector.<MapPoint>
      {
         var mi:MarkInstance = null;
         var mapPoints:Vector.<MapPoint> = new Vector.<MapPoint>();
         for each(mi in this._marks)
         {
            if(mi.markType == markType && (teamId == TeamEnum.TEAM_SPECTATOR || mi.teamId == teamId) && (!activeOnly || mi.active))
            {
               mapPoints.push(MapPoint.fromCellId(mi.cells[0]));
            }
         }
         return mapPoints;
      }
      
      public function getMarkAtCellId(cellId:uint, markType:int = -1) : MarkInstance
      {
         var mark:MarkInstance = null;
         for each(mark in this._marks)
         {
            if(mark.markImpactCellId == cellId && (markType == -1 || markType == mark.markType))
            {
               return mark;
            }
         }
         return null;
      }
      
      public function cellHasTrap(cellId:uint) : Boolean
      {
         var mark:MarkInstance = null;
         for each(mark in this._marks)
         {
            if(mark.markImpactCellId == cellId && mark.markType == GameActionMarkTypeEnum.TRAP)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getCellIdsFromMarkIds(markIds:Vector.<int>) : Vector.<int>
      {
         var markId:int = 0;
         var cellIds:Vector.<int> = new Vector.<int>();
         for each(markId in markIds)
         {
            if(this._marks[markId] && this._marks[markId].cells && this._marks[markId].cells.length == 1)
            {
               cellIds.push(this._marks[markId].cells[0]);
            }
            else
            {
               _log.warn("Can\'t find cellId for markId " + markId + " in getCellIdsFromMarkIds()");
            }
         }
         cellIds.fixed = true;
         return cellIds;
      }
      
      public function getMapPointsFromMarkIds(markIds:Vector.<int>) : Vector.<MapPoint>
      {
         var markId:int = 0;
         var mapPoints:Vector.<MapPoint> = new Vector.<MapPoint>();
         for each(markId in markIds)
         {
            if(this._marks[markId] && this._marks[markId].cells && this._marks[markId].cells.length == 1)
            {
               mapPoints.push(MapPoint.fromCellId(this._marks[markId].cells[0]));
            }
            else
            {
               _log.warn("Can\'t find cellId for markId " + markId + " in getMapPointsFromMarkIds()");
            }
         }
         mapPoints.fixed = true;
         return mapPoints;
      }
      
      public function getActivePortalsCount(teamId:int = 2) : uint
      {
         var mi:MarkInstance = null;
         var count:uint = 0;
         for each(mi in this._marks)
         {
            if(mi.markType == GameActionMarkTypeEnum.PORTAL && (teamId == TeamEnum.TEAM_SPECTATOR || mi.teamId == teamId) && mi.active)
            {
               count++;
            }
         }
         return count;
      }
      
      public function destroy() : void
      {
         var mark:* = null;
         var i:int = 0;
         var num:int = 0;
         var glyph:* = null;
         Atouin.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         var bufferId:Array = new Array();
         for(mark in this._marks)
         {
            bufferId.push(int(mark));
         }
         i = -1;
         num = bufferId.length;
         while(++i < num)
         {
            this.removeMark(bufferId[i]);
         }
         bufferId.length = 0;
         for(glyph in this._glyphs)
         {
            bufferId.push(int(glyph));
         }
         i = -1;
         num = bufferId.length;
         while(++i < num)
         {
            this.removeGlyph(bufferId[i]);
         }
         _self = null;
      }
      
      private function onPropertyChanged(pEvent:PropertyChangeEvent) : void
      {
         var mi:MarkInstance = null;
         var strata:uint = 0;
         var markId:* = undefined;
         var selection:Selection = null;
         var glyph:Glyph = null;
         var glyphs:* = undefined;
         var portalsLinks:Selection = null;
         var cellLink:CellLink = null;
         if(pEvent.propertyName == "transparentOverlayMode")
         {
            for(markId in this._marks)
            {
               mi = this._marks[markId];
               if(pEvent.propertyValue == true)
               {
                  strata = PlacementStrataEnums.STRATA_NO_Z_ORDER;
               }
               else
               {
                  strata = mi.markType == GameActionMarkTypeEnum.PORTAL ? uint(PlacementStrataEnums.STRATA_PORTAL) : uint(PlacementStrataEnums.STRATA_GLYPH);
               }
               for each(selection in mi.selections)
               {
                  (selection.renderer as TrapZoneRenderer).strata = strata;
                  selection.update(true);
               }
               glyphs = this._glyphs[markId];
               if(glyphs is Glyph)
               {
                  EntitiesDisplayManager.getInstance().displayEntity(glyphs as IDisplayable,glyphs.position,strata,false);
               }
               else
               {
                  for each(glyph in glyphs)
                  {
                     EntitiesDisplayManager.getInstance().displayEntity(glyph as IDisplayable,glyph.position,strata,false);
                  }
               }
            }
            portalsLinks = SelectionManager.getInstance().getSelection("eliaPortals");
            if(portalsLinks)
            {
               for each(cellLink in (portalsLinks.renderer as CellLinkRenderer).getCellLinks())
               {
                  cellLink.display(pEvent.propertyValue == true ? uint(strata) : uint(PlacementStrataEnums.STRATA_LINK));
               }
            }
         }
      }
      
      private function getSelectionUid() : String
      {
         return MARK_SELECTIONS_PREFIX + this._markUid++;
      }
      
      private function updateDataMapProvider() : void
      {
         var mi:MarkInstance = null;
         var dmp:DataMapProvider = null;
         var mp:MapPoint = null;
         var i:uint = 0;
         var cell:uint = 0;
         var markedCells:Array = [];
         for each(mi in this._marks)
         {
            for each(cell in mi.cells)
            {
               markedCells[cell] |= mi.markType;
            }
         }
         dmp = DataMapProvider.getInstance();
         for(i = 0; i < AtouinConstants.MAP_CELLS_COUNT; i++)
         {
            mp = MapPoint.fromCellId(i);
            dmp.setSpecialEffects(i,(dmp.pointSpecialEffects(mp.x,mp.y) | 3) ^ 3);
            if(markedCells[i])
            {
               dmp.setSpecialEffects(i,dmp.pointSpecialEffects(mp.x,mp.y) | markedCells[i]);
            }
         }
         this.updateMarksNumber(GameActionMarkTypeEnum.PORTAL);
      }
      
      public function updateMarksNumber(marktype:uint) : void
      {
         var mi:MarkInstance = null;
         var teamId:int = 0;
         var num:int = 0;
         var color:Color = null;
         var mitn:MarkInstance = null;
         var markInstanceToNumber:Array = new Array();
         var teamIds:Array = new Array();
         for each(mi in this._marks)
         {
            if(mi.markType == marktype)
            {
               if(!markInstanceToNumber[mi.teamId])
               {
                  markInstanceToNumber[mi.teamId] = new Array();
                  teamIds.push(mi.teamId);
               }
               markInstanceToNumber[mi.teamId].push(mi);
            }
         }
         for each(teamId in teamIds)
         {
            markInstanceToNumber[teamId].sortOn("markId",Array.NUMERIC);
            num = 1;
            for each(mitn in markInstanceToNumber[teamId])
            {
               if(this._glyphs[mitn.markId])
               {
                  color = mitn.selections[0].color;
                  if(this._glyphs[mitn.markId] is Glyph)
                  {
                     Glyph(this._glyphs[mitn.markId]).addNumber(num,color);
                  }
               }
               num++;
            }
         }
      }
      
      public function getResolvedMarkGlyphId(casterId:Number, spellId:int, spellRank:int, markCellId:int) : int
      {
         var spell:SpellWrapper = SpellWrapper.create(spellId,spellRank,true,casterId);
         return this.getResolvedMarkGlyphIdFromSpell(spell,casterId,markCellId);
      }
      
      public function getResolvedMarkGlyphIdFromSpell(spell:SpellWrapper, casterId:Number, markCellId:int) : int
      {
         var contexts:Vector.<SpellScriptContext> = SpellScriptManager.getInstance().resolveScriptUsage(spell,false,casterId,markCellId);
         if(contexts === null || contexts.length === 0)
         {
            return 0;
         }
         var spellScriptData:SpellScript = SpellScript.getSpellScriptById(contexts[0].scriptId);
         return spellScriptData.getNumberParam("glyphGfxId");
      }
   }
}
