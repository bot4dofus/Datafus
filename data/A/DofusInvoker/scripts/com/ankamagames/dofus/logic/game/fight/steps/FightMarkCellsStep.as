package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightTurnFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
   import com.ankamagames.dofus.types.sequences.AddGlyphGfxStep;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import tools.enumeration.GameActionMarkTypeEnum;
   
   public class FightMarkCellsStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _markCasterId:Number;
      
      private var _markId:int;
      
      private var _markType:int;
      
      private var _markSpellGrade:int;
      
      private var _cells:Vector.<GameActionMarkedCell>;
      
      private var _markSpellId:int;
      
      private var _markTeamId:int;
      
      private var _markImpactCell:int;
      
      private var _markActive:Boolean;
      
      public function FightMarkCellsStep(markId:int, markType:int, cells:Vector.<GameActionMarkedCell>, markSpellId:int, markSpellGrade:int, markTeamId:int, markImpactCell:int, markCasterId:Number, markActive:Boolean = true)
      {
         super();
         this._markCasterId = markCasterId;
         this._markId = markId;
         this._markType = markType;
         this._cells = cells;
         this._markSpellId = markSpellId;
         this._markSpellGrade = markSpellGrade;
         this._markTeamId = markTeamId;
         this._markImpactCell = markImpactCell;
         this._markActive = markActive;
      }
      
      public function get stepType() : String
      {
         return "markCells";
      }
      
      override public function start() : void
      {
         var cellZone:GameActionMarkedCell = null;
         var step:AddGlyphGfxStep = null;
         var evt:String = null;
         var ftf:FightTurnFrame = null;
         var pe:PathElement = null;
         var updatePath:Boolean = false;
         var spell:Spell = Spell.getSpellById(this._markSpellId);
         var originMarkSpellLevel:SpellLevel = spell.getSpellLevel(this._markSpellGrade);
         var glyphGfxId:int = MarkedCellsManager.getInstance().getResolvedMarkGlyphId(this._markCasterId,this._markSpellId,this._markSpellGrade,this._markImpactCell);
         if(this._markType == GameActionMarkTypeEnum.WALL || originMarkSpellLevel.hasZoneShape(SpellShapeEnum.semicolon))
         {
            if(glyphGfxId !== 0)
            {
               for each(cellZone in this._cells)
               {
                  step = new AddGlyphGfxStep(glyphGfxId,cellZone.cellId,this._markId,this._markType,this._markTeamId);
                  step.start();
               }
            }
         }
         else if(glyphGfxId !== 0 && !MarkedCellsManager.getInstance().getGlyph(this._markId) && this._markImpactCell != -1)
         {
            step = new AddGlyphGfxStep(glyphGfxId,this._markImpactCell,this._markId,this._markType,this._markTeamId);
            step.start();
         }
         MarkedCellsManager.getInstance().addMark(this._markCasterId,this._markId,this._markType,spell,originMarkSpellLevel,this._cells,this._markTeamId,this._markActive,this._markImpactCell);
         var mi:MarkInstance = MarkedCellsManager.getInstance().getMarkDatas(this._markId);
         if(mi)
         {
            evt = FightEventEnum.UNKNOWN_FIGHT_EVENT;
            switch(mi.markType)
            {
               case GameActionMarkTypeEnum.GLYPH:
                  evt = FightEventEnum.GLYPH_APPEARED;
                  break;
               case GameActionMarkTypeEnum.TRAP:
                  evt = FightEventEnum.TRAP_APPEARED;
                  break;
               case GameActionMarkTypeEnum.PORTAL:
                  evt = FightEventEnum.PORTAL_APPEARED;
                  break;
               case GameActionMarkTypeEnum.RUNE:
                  evt = FightEventEnum.RUNE_APPEARED;
                  break;
               default:
                  _log.warn("Unknown mark type (" + mi.markType + ").");
            }
            FightEventsHelper.sendFightEvent(evt,[mi.associatedSpell.id],0,castingSpellId);
            ftf = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            if(ftf && ftf.myTurn && ftf.lastPath)
            {
               for each(pe in ftf.lastPath.path)
               {
                  if(mi.cells.indexOf(pe.cellId) != -1)
                  {
                     updatePath = true;
                     break;
                  }
               }
               if(updatePath)
               {
                  ftf.updatePath();
               }
            }
         }
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._markId as Number];
      }
   }
}
