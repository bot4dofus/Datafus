package com.ankamagames.dofus.scripts.api
{
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.steps.IFightStep;
   import com.ankamagames.dofus.scripts.SpellScriptRunner;
   import com.ankamagames.dofus.types.entities.ExplosionEntity;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.tiphon.TiphonConstants;
   
   public class SpellFxApi extends SpellScriptRunnerUtils
   {
       
      
      public function SpellFxApi()
      {
         super();
      }
      
      public static function GetPortalCells(runner:SpellScriptRunner) : Vector.<MapPoint>
      {
         return runner.castSequenceContext.portalMapPoints;
      }
      
      public static function GetPortalIds(runner:SpellScriptRunner) : Vector.<int>
      {
         return runner.castSequenceContext.portalIds;
      }
      
      public static function GetPortalEntity(runner:SpellScriptRunner, portalId:int) : Glyph
      {
         return MarkedCellsManager.getInstance().getGlyph(portalId);
      }
      
      public static function GetStepType(step:ISequencable) : String
      {
         if(step is IFightStep)
         {
            return (step as IFightStep).stepType;
         }
         return "other";
      }
      
      public static function GetStepsFromType(runner:SpellScriptRunner, type:String) : Vector.<IFightStep>
      {
         var stepInside:ISequencable = null;
         var fightStepInside:IFightStep = null;
         var steps:Vector.<IFightStep> = new Vector.<IFightStep>(0,false);
         for each(stepInside in runner.steps)
         {
            if(stepInside is IFightStep)
            {
               fightStepInside = stepInside as IFightStep;
               if(fightStepInside.stepType == type)
               {
                  steps.push(fightStepInside);
               }
            }
         }
         return steps;
      }
      
      public static function AddFrontStep(runner:SpellScriptRunner, step:ISequencable) : void
      {
         runner.steps.splice(0,0,step);
      }
      
      public static function AddBackStep(runner:SpellScriptRunner, step:ISequencable) : void
      {
         runner.steps.push(step);
      }
      
      public static function AddStepBefore(runner:SpellScriptRunner, referenceStep:ISequencable, stepToAdd:ISequencable) : void
      {
         var index:int = runner.steps.indexOf(referenceStep);
         if(index >= 0)
         {
            runner.steps.insertAt(index,stepToAdd);
         }
         else
         {
            _log.warn("Cannot add a step before " + referenceStep + "; step not found.");
         }
      }
      
      public static function AddStepAfter(runner:SpellScriptRunner, referenceStep:ISequencable, stepToAdd:ISequencable) : void
      {
         var index:int = runner.steps.indexOf(referenceStep);
         if(index >= 0)
         {
            runner.steps.insertAt(index + 1,stepToAdd);
         }
         else
         {
            _log.warn("Cannot add a step before " + referenceStep + "; step not found.");
         }
      }
      
      public static function CreateExplosionEntity(runner:SpellScriptRunner, gfxId:uint, startColors:String, particleCount:uint, levelChange:Boolean, subExplo:Boolean, exploType:uint) : ExplosionEntity
      {
         var tmp:Array = null;
         var i:uint = 0;
         var spellRank:int = 0;
         var uri:Uri = new Uri(TiphonConstants.SWF_SKULL_PATH + "/" + gfxId + ".swl");
         if(startColors)
         {
            tmp = startColors.split(";");
            for(i = 0; i < tmp.length; i++)
            {
               tmp[i] = parseInt(tmp[i],16);
            }
         }
         if(levelChange)
         {
            spellRank = runner.castSequenceContext.spellLevelData.spell.spellLevels.indexOf(runner.castSequenceContext.spellLevelData.id);
            if(spellRank != -1)
            {
               particleCount = particleCount * runner.castSequenceContext.spellLevelData.spell.spellLevels.length / 10 + particleCount * (spellRank + 1) / 10;
            }
         }
         return new ExplosionEntity(uri,tmp,particleCount,subExplo,exploType);
      }
   }
}
