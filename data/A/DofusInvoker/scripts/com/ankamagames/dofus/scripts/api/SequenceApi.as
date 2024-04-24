package com.ankamagames.dofus.scripts.api
{
   import com.ankamagames.atouin.types.sequences.AddWorldEntityStep;
   import com.ankamagames.atouin.types.sequences.DestroyEntityStep;
   import com.ankamagames.atouin.types.sequences.ParableGfxMovementStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightDestroyEntityStep;
   import com.ankamagames.dofus.scripts.SpellScriptRunner;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   import com.ankamagames.dofus.types.sequences.AddGfxInLineStep;
   import com.ankamagames.dofus.types.sequences.AddGlyphGfxStep;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.sequencer.ParallelStartSequenceStep;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.sequence.SetDirectionStep;
   import com.ankamagames.tiphon.types.CarriedSprite;
   import flash.display.DisplayObject;
   
   public class SequenceApi
   {
       
      
      public function SequenceApi()
      {
         super();
      }
      
      public static function CreateParallelStartSequenceStep(aSequence:Array, waitAllSequenceEnd:Boolean = true, waitFirstEndSequence:Boolean = false) : ISequencable
      {
         return new ParallelStartSequenceStep(aSequence,waitAllSequenceEnd,waitFirstEndSequence);
      }
      
      public static function CreateAddGfxEntityStep(runner:SpellScriptRunner, gfxId:uint, cell:MapPoint, angle:Number = 0, yOffset:int = 0, mode:uint = 0, startCell:MapPoint = null, endCell:MapPoint = null, popUnderPlayer:Boolean = false, startEntity:IEntity = null) : ISequencable
      {
         return new AddGfxEntityStep(gfxId,cell.cellId,angle,-DisplayObject(runner.caster).height * yOffset / 10,mode,startCell,endCell,popUnderPlayer,null,startEntity);
      }
      
      public static function CreateAddGlyphGfxStep(runner:SpellScriptRunner, gfxId:uint, cell:MapPoint, markId:int) : ISequencable
      {
         return new AddGlyphGfxStep(gfxId,cell.cellId,markId,runner.castSequenceContext.markType);
      }
      
      public static function CreatePlayAnimationStep(target:TiphonSprite, animationName:String, backToLastAnimationAtEnd:Boolean, waitForEvent:Boolean, eventEnd:String = "animation_event_end", loop:int = 1) : ISequencable
      {
         return new PlayAnimationStep(target,animationName,backToLastAnimationAtEnd,waitForEvent,eventEnd,loop);
      }
      
      public static function CreateSetDirectionStep(target:TiphonSprite, nDirection:uint) : ISequencable
      {
         return new SetDirectionStep(target,nDirection);
      }
      
      public static function CreateParableGfxMovementStep(runner:SpellScriptRunner, gfxEntity:IMovable, targetPoint:MapPoint, speed:Number = 100, curvePrc:Number = 0.5, yOffset:int = 0, waitEnd:Boolean = true) : ParableGfxMovementStep
      {
         var subEntityOffset:int = 0;
         var p:DisplayObject = TiphonSprite(runner.caster).parent;
         while(p)
         {
            if(p is CarriedSprite)
            {
               subEntityOffset += p.y;
            }
            p = p.parent;
         }
         return new ParableGfxMovementStep(gfxEntity,targetPoint,speed,curvePrc,-DisplayObject(runner.caster).height * yOffset / 10 + subEntityOffset,waitEnd);
      }
      
      public static function CreateAddGfxInLineStep(runner:SpellScriptRunner, gfxId:uint, startCell:MapPoint, endCell:MapPoint, yOffset:Number = 0, mode:uint = 0, minScale:Number = 0, maxScale:Number = 0, addOnStartCell:Boolean = false, addOnEndCell:Boolean = false, showUnder:Boolean = false, useSpellZone:Boolean = false, useOnlySpellZone:Boolean = false, startEntity:IEntity = null) : AddGfxInLineStep
      {
         return new AddGfxInLineStep(gfxId,runner.castSequenceContext,startCell,endCell,-DisplayObject(runner.caster).height * yOffset / 10,mode,minScale,maxScale,addOnStartCell,addOnEndCell,useSpellZone,useOnlySpellZone,showUnder,startEntity);
      }
      
      public static function CreateAddWorldEntityStep(entity:IEntity, strata:int = 200) : AddWorldEntityStep
      {
         return new AddWorldEntityStep(entity,strata);
      }
      
      public static function CreateDestroyEntityStep(entity:IEntity) : DestroyEntityStep
      {
         return new FightDestroyEntityStep(entity);
      }
   }
}
