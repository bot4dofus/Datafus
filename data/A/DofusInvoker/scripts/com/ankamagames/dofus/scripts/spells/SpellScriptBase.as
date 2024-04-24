package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.types.sequences.AddWorldEntityStep;
   import com.ankamagames.atouin.types.sequences.DestroyEntityStep;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.steps.FightLifeVariationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.IFightStep;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastSequenceContext;
   import com.ankamagames.dofus.scripts.SpellScriptRunner;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.dofus.scripts.api.SpellScriptRunnerUtils;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.dofus.types.enums.PortalAnimationEnum;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.enum.AddGfxModeEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.sequence.SetDirectionStep;
   import flash.utils.getQualifiedClassName;
   
   public class SpellScriptBase
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellScriptBase));
      
      protected static const PREFIX_CASTER:String = "caster";
      
      protected static const PREFIX_TARGET:String = "target";
      
      protected static const PREFIX_GLYPH:String = "glyph";
      
      protected static const DEFAULT_CASTER_ANIMATION:int = 4;
       
      
      protected var latestStep:ISequencable;
      
      protected var runner:SpellScriptRunner;
      
      protected var spell:SpellCastSequenceContext;
      
      protected var caster:AnimatedCharacter;
      
      public function SpellScriptBase(spellFxRunner:SpellScriptRunner)
      {
         super();
         this.runner = spellFxRunner;
         this.spell = this.runner.castSequenceContext;
         this.caster = this.runner.caster as AnimatedCharacter;
         if(this.runner.steps && this.runner.steps.length > 0)
         {
            this.latestStep = this.runner.steps[this.runner.steps.length - 1];
         }
      }
      
      protected function addCasterSetDirectionStep(target:MapPoint, forcedDirection:int = -1) : void
      {
         var orientationStep:SetDirectionStep = null;
         if(this.caster && this.caster.position && target)
         {
            orientationStep = new SetDirectionStep(this.caster,forcedDirection,target);
            if(!this.latestStep && this.runner.steps.length > 0)
            {
               this.latestStep = this.runner.steps[this.runner.steps.length - 1];
            }
            if(!this.latestStep)
            {
               SpellFxApi.AddFrontStep(this.runner,orientationStep);
            }
            else
            {
               SpellFxApi.AddStepAfter(this.runner,this.latestStep,orientationStep);
            }
            this.latestStep = orientationStep;
         }
      }
      
      protected function addCasterAnimationStep() : void
      {
         var animId:int = 0;
         var allowSpellEffects:Boolean = false;
         var animationStep:ISequencable = null;
         if(this.caster && this.runner.scriptData.hasParam("animId"))
         {
            animId = this.runner.scriptData.getNumberParam("animId");
            allowSpellEffects = OptionManager.getOptionManager("dofus").getOption("allowSpellEffects");
            if(!allowSpellEffects && this.caster.id > 0 && PlayedCharacterManager.getInstance().isFighting)
            {
               animId = DEFAULT_CASTER_ANIMATION;
            }
            animationStep = SequenceApi.CreatePlayAnimationStep(this.caster,"AnimAttaque" + animId,true,true,"SHOT");
            if(animId > 400000)
            {
               animationStep.timeout *= 2;
            }
            if(!this.latestStep)
            {
               SpellFxApi.AddFrontStep(this.runner,animationStep);
            }
            else
            {
               SpellFxApi.AddStepAfter(this.runner,this.latestStep,animationStep);
            }
            this.latestStep = animationStep;
         }
      }
      
      protected function addNewGfxEntityStep(originCell:MapPoint, casterCell:MapPoint, targetCell:MapPoint, stringPrefix:String, stringSuffix:String = "", startEntity:IEntity = null, pGfxId:uint = 0) : void
      {
         var startCell:MapPoint = null;
         var endCell:MapPoint = null;
         if(!originCell || !casterCell || !targetCell)
         {
            return;
         }
         var gfxAngle:int = 0;
         if(this.runner.scriptData.hasParam(stringPrefix + "GfxOriented" + stringSuffix))
         {
            if(this.runner.scriptData.getBoolParam(stringPrefix + "GfxOriented" + stringSuffix))
            {
               gfxAngle = SpellScriptRunnerUtils.GetAngleTo(casterCell,targetCell);
            }
         }
         var spellGfxEntityYOffset:int = 0;
         if(this.runner.scriptData.hasParam(stringPrefix + "GfxYOffset" + stringSuffix))
         {
            spellGfxEntityYOffset = this.runner.scriptData.getNumberParam(stringPrefix + "GfxYOffset" + stringSuffix);
         }
         var spellGfxEntityShowUnder:Boolean = false;
         if(this.runner.scriptData.hasParam(stringPrefix + "GfxShowUnder" + stringSuffix))
         {
            spellGfxEntityShowUnder = this.runner.scriptData.getBoolParam(stringPrefix + "GfxShowUnder" + stringSuffix);
         }
         var gfxDisplayMode:uint = this.runner.scriptData.getNumberParam(stringPrefix + "GfxDisplayType" + stringSuffix);
         if(gfxDisplayMode == AddGfxModeEnum.ORIENTED)
         {
            startCell = casterCell;
            endCell = targetCell;
            if(casterCell && endCell && casterCell.cellId == endCell.cellId)
            {
               endCell = endCell.getNearestCellInDirection(this.caster.getDirection());
               if(endCell == null)
               {
                  endCell = targetCell;
               }
            }
            if(!endCell)
            {
               _log.debug("Failed to add a GfxEntityStep, expecting it to be oriented, but found no endCell!");
               return;
            }
         }
         var gfxEntityStep:ISequencable = SequenceApi.CreateAddGfxEntityStep(this.runner,!!pGfxId ? uint(pGfxId) : uint(this.runner.scriptData.getNumberParam(stringPrefix + "GfxId" + stringSuffix)),originCell,gfxAngle,spellGfxEntityYOffset,gfxDisplayMode,startCell,endCell,spellGfxEntityShowUnder,startEntity);
         if(!this.latestStep)
         {
            SpellFxApi.AddFrontStep(this.runner,gfxEntityStep);
         }
         else if(stringPrefix == PREFIX_TARGET && this.runner.scriptData.hasParam("playTargetGfxFirst" + stringSuffix) && this.runner.scriptData.getNumberParam("playTargetGfxFirst" + stringSuffix) > 0)
         {
            SpellFxApi.AddStepBefore(this.runner,this.latestStep,gfxEntityStep);
         }
         else
         {
            SpellFxApi.AddStepAfter(this.runner,this.latestStep,gfxEntityStep);
         }
         this.latestStep = gfxEntityStep;
      }
      
      protected function addAnimHitSteps() : void
      {
         var lifeVariationStep:FightLifeVariationStep = null;
         var hitAnimName:String = null;
         var lifeVariationSteps:Vector.<IFightStep> = SpellFxApi.GetStepsFromType(this.runner,"lifeVariation");
         for each(lifeVariationStep in lifeVariationSteps)
         {
            if(lifeVariationStep.value < 0)
            {
               hitAnimName = "AnimHit";
               if(this.runner.scriptData.hasParam("customHitAnim"))
               {
                  hitAnimName = this.runner.scriptData.getStringParam("customHitAnim");
               }
               SpellFxApi.AddStepBefore(this.runner,lifeVariationStep,SequenceApi.CreatePlayAnimationStep(lifeVariationStep.target as TiphonSprite,hitAnimName,true,false));
            }
         }
      }
      
      protected function addPortalAnimationSteps(portalIds:Vector.<int>) : void
      {
         var glyphAnimationStep:ISequencable = null;
         if(this.spell.spellLevelData.canThrowPlayer)
         {
            return;
         }
         var glyph:Glyph = SpellFxApi.GetPortalEntity(this.runner,portalIds[0]);
         if(glyph)
         {
            if(glyph.getAnimation() != PortalAnimationEnum.STATE_NORMAL)
            {
               glyphAnimationStep = new PlayAnimationStep(glyph,PortalAnimationEnum.STATE_NORMAL,false,false);
               if(!this.latestStep)
               {
                  SpellFxApi.AddFrontStep(this.runner,glyphAnimationStep);
               }
               else
               {
                  SpellFxApi.AddStepAfter(this.runner,this.latestStep,glyphAnimationStep);
               }
               this.latestStep = glyphAnimationStep;
            }
            glyphAnimationStep = new PlayAnimationStep(glyph,PortalAnimationEnum.STATE_ENTRY_SPELL,false,true,TiphonEvent.ANIMATION_SHOT);
            if(!this.latestStep)
            {
               SpellFxApi.AddFrontStep(this.runner,glyphAnimationStep);
            }
            else
            {
               SpellFxApi.AddStepAfter(this.runner,this.latestStep,glyphAnimationStep);
            }
            this.latestStep = glyphAnimationStep;
         }
         for(var i:int = 1; i < portalIds.length - 1; i++)
         {
            glyph = SpellFxApi.GetPortalEntity(this.runner,portalIds[i]);
            if(glyph)
            {
               if(glyph.getAnimation() != PortalAnimationEnum.STATE_NORMAL)
               {
                  glyphAnimationStep = new PlayAnimationStep(glyph,PortalAnimationEnum.STATE_NORMAL,false,false);
                  if(!this.latestStep)
                  {
                     SpellFxApi.AddFrontStep(this.runner,glyphAnimationStep);
                  }
                  else
                  {
                     SpellFxApi.AddStepAfter(this.runner,this.latestStep,glyphAnimationStep);
                  }
                  this.latestStep = glyphAnimationStep;
               }
               glyphAnimationStep = new PlayAnimationStep(glyph,PortalAnimationEnum.STATE_ENTRY_SPELL,false,true,TiphonEvent.ANIMATION_SHOT);
               SpellFxApi.AddStepAfter(this.runner,this.latestStep,glyphAnimationStep);
               this.latestStep = glyphAnimationStep;
            }
         }
         glyph = SpellFxApi.GetPortalEntity(this.runner,portalIds[portalIds.length - 1]);
         if(glyph)
         {
            if(glyph.getAnimation() != PortalAnimationEnum.STATE_NORMAL)
            {
               glyphAnimationStep = new PlayAnimationStep(glyph,PortalAnimationEnum.STATE_NORMAL,false,false);
               if(!this.latestStep)
               {
                  SpellFxApi.AddFrontStep(this.runner,glyphAnimationStep);
               }
               else
               {
                  SpellFxApi.AddStepAfter(this.runner,this.latestStep,glyphAnimationStep);
               }
               this.latestStep = glyphAnimationStep;
            }
            glyphAnimationStep = new PlayAnimationStep(glyph,PortalAnimationEnum.STATE_EXIT_SPELL,false,false);
            SpellFxApi.AddStepAfter(this.runner,this.latestStep,glyphAnimationStep);
            this.latestStep = glyphAnimationStep;
         }
      }
      
      protected function addFBackgroundSteps() : void
      {
         var foregroundStrata:int = 0;
         var background:Projectile = null;
         var addBackgroundStep:AddWorldEntityStep = null;
         var destroyMissileStep:DestroyEntityStep = null;
         if(this.runner.scriptData.hasParam("foregroundGfxId"))
         {
            foregroundStrata = PlacementStrataEnums.STRATA_FOREGROUND;
            if(this.runner.scriptData.hasParam("foregroundGfxShowUnder"))
            {
               foregroundStrata = PlacementStrataEnums.STRATA_SPELL_BACKGROUND;
            }
            background = SpellScriptRunnerUtils.CreateGfxEntity(this.runner.scriptData.getNumberParam("foregroundGfxId"),MapPoint.fromCellId(272)) as Projectile;
            addBackgroundStep = SequenceApi.CreateAddWorldEntityStep(background,foregroundStrata);
            SpellFxApi.AddFrontStep(this.runner,addBackgroundStep);
            destroyMissileStep = SequenceApi.CreateDestroyEntityStep(background);
            SpellFxApi.AddBackStep(this.runner,destroyMissileStep);
         }
      }
      
      protected function destroy() : void
      {
         this.latestStep = null;
         this.spell = null;
         this.caster = null;
      }
   }
}
