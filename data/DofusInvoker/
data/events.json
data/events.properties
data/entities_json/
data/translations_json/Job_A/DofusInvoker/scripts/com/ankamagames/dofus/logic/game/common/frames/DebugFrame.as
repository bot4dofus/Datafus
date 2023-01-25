package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.dofus.console.debug.StatsInstructionHandler;
   import com.ankamagames.dofus.network.enums.DebugLevelEnum;
   import com.ankamagames.dofus.network.messages.debug.DebugClearHighlightCellsMessage;
   import com.ankamagames.dofus.network.messages.debug.DebugHighlightCellsMessage;
   import com.ankamagames.dofus.network.messages.debug.DebugInClientMessage;
   import com.ankamagames.dofus.network.messages.debug.DumpedEntityStatsMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
   import com.ankamagames.jerakine.console.ConsolesManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.ARGBColor;
   import com.ankamagames.jerakine.types.zones.Custom;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class DebugFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DebugFrame));
       
      
      private var _sName:String;
      
      private var _aZones:Array;
      
      private var _cells:Dictionary;
      
      public function DebugFrame()
      {
         this._aZones = [];
         this._cells = new Dictionary();
         super();
      }
      
      public function get priority() : int
      {
         return 0;
      }
      
      public function process(msg:Message) : Boolean
      {
         var dhcmsg:DebugHighlightCellsMessage = null;
         var cellId:uint = 0;
         var foregroundCells:Vector.<uint> = null;
         var normalCells:Vector.<uint> = null;
         var cellToRemove:Vector.<uint> = null;
         var dicmsg:DebugInClientMessage = null;
         var desmsg:DumpedEntityStatsMessage = null;
         switch(true)
         {
            case msg is DebugHighlightCellsMessage:
               dhcmsg = msg as DebugHighlightCellsMessage;
               if(dhcmsg.cells.length == 0)
               {
                  this.clear();
                  return true;
               }
               this._sName = "debug_zone" + dhcmsg.color + "_" + Math.round(Math.random() * 10000);
               foregroundCells = new Vector.<uint>(0);
               normalCells = new Vector.<uint>(0);
               for each(cellId in dhcmsg.cells)
               {
                  if(this._cells[cellId] != null)
                  {
                     cellToRemove = new Vector.<uint>();
                     cellToRemove.push(cellId);
                     (this._cells[cellId] as Selection).remove(cellToRemove);
                  }
                  if(MapDisplayManager.getInstance().renderer.isCellUnderFixture(cellId))
                  {
                     foregroundCells.push(cellId);
                  }
                  else
                  {
                     normalCells.push(cellId);
                  }
               }
               if(dhcmsg.color != 0)
               {
                  if(foregroundCells.length > 0)
                  {
                     this.displayZone(this._sName + "_foreground",foregroundCells,dhcmsg.color,PlacementStrataEnums.STRATA_FOREGROUND);
                     this._aZones.push(this._sName + "_foreground");
                  }
                  if(normalCells.length > 0)
                  {
                     this.displayZone(this._sName,normalCells,dhcmsg.color,PlacementStrataEnums.STRATA_MOVEMENT);
                     this._aZones.push(this._sName);
                  }
               }
               return true;
               break;
            case msg is DebugClearHighlightCellsMessage:
            case msg is CurrentMapMessage:
            case msg is GameFightJoinMessage:
               this.clear();
               return false;
            case msg is DebugInClientMessage:
               dicmsg = msg as DebugInClientMessage;
               switch(dicmsg.level)
               {
                  case DebugLevelEnum.LEVEL_DEBUG:
                     _log.debug(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_ERROR:
                     _log.error(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_FATAL:
                     _log.fatal(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_INFO:
                     _log.info(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_TRACE:
                     _log.trace(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_WARN:
                     _log.warn(dicmsg.message);
               }
               return true;
            case msg is DumpedEntityStatsMessage:
               desmsg = msg as DumpedEntityStatsMessage;
               StatsInstructionHandler.applyStatsDiff(ConsolesManager.getConsole("debug"),desmsg.actorId,desmsg.stats.characteristics);
               return true;
            default:
               return false;
         }
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      private function clear() : void
      {
         var sName:String = null;
         for each(sName in this._aZones)
         {
            SelectionManager.getInstance().getSelection(sName).remove();
         }
         this._cells = new Dictionary();
      }
      
      private function displayZone(name:String, cells:Vector.<uint>, color:Number, pStrata:uint) : void
      {
         var cellID:uint = 0;
         var s:Selection = new Selection();
         s.renderer = new ZoneDARenderer(pStrata);
         s.color = new ARGBColor(color);
         s.zone = new Custom(cells);
         for each(cellID in cells)
         {
            this._cells[cellID] = s;
         }
         SelectionManager.getInstance().addSelection(s,name);
         SelectionManager.getInstance().update(name);
      }
   }
}
