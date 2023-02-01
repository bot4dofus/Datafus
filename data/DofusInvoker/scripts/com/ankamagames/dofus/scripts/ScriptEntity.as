package com.ankamagames.dofus.scripts
{
   import com.ankamagames.atouin.entities.behaviours.movements.RunningMovementBehavior;
   import com.ankamagames.atouin.entities.behaviours.movements.SlideMovementBehavior;
   import com.ankamagames.atouin.entities.behaviours.movements.WalkingMovementBehavior;
   import com.ankamagames.dofus.internalDatacenter.communication.ChatBubble;
   import com.ankamagames.dofus.internalDatacenter.communication.ThinkBubble;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.steps.DisplayEntityStep;
   import com.ankamagames.dofus.logic.game.common.steps.LookAtStep;
   import com.ankamagames.dofus.logic.game.common.steps.MoveStep;
   import com.ankamagames.dofus.logic.game.common.steps.PlayEmoteStep;
   import com.ankamagames.dofus.logic.game.common.steps.PlaySmileyStep;
   import com.ankamagames.dofus.logic.game.common.steps.RemoveEntityStep;
   import com.ankamagames.dofus.logic.game.common.steps.TeleportStep;
   import com.ankamagames.dofus.logic.game.common.steps.TextBubbleStep;
   import com.ankamagames.dofus.logic.game.common.steps.WaitStep;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.lua.LuaPackage;
   import com.ankamagames.jerakine.sequencer.CallbackStep;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.sequence.SetDirectionStep;
   import com.ankamagames.tiphon.types.look.EntityLookParser;
   import mapTools.MapTools;
   
   public class ScriptEntity implements LuaPackage
   {
       
      
      private var _id:Number;
      
      private var _look:String;
      
      private var _entity:TiphonSprite;
      
      private var _direction:int = 1;
      
      private var _x:int;
      
      private var _y:int;
      
      public function ScriptEntity(pId:Number, pLook:String, pEntity:TiphonSprite = null)
      {
         super();
         this._id = pId;
         this._look = pLook;
         this._entity = pEntity;
      }
      
      public function get x() : int
      {
         if(this.getEntitySprite())
         {
            this._x = AnimatedCharacter(this._entity).position.x;
         }
         return this._x;
      }
      
      public function get y() : int
      {
         if(this.getEntitySprite())
         {
            this._y = AnimatedCharacter(this._entity).position.y;
         }
         return this._y;
      }
      
      public function set x(pX:int) : void
      {
         this._x = pX;
         if(this.getEntitySprite())
         {
            this.teleport(this._x,this._y).start();
         }
      }
      
      public function set y(pY:int) : void
      {
         this._y = pY;
         if(this.getEntitySprite())
         {
            this.teleport(this._x,this._y).start();
         }
      }
      
      public function get cellId() : uint
      {
         return MapTools.getCellIdByCoord(this._x,this._y);
      }
      
      public function set cellId(pCellId:uint) : void
      {
         if(this.getEntitySprite())
         {
            this.teleport(pCellId).start();
         }
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function get look() : String
      {
         return this._look;
      }
      
      public function set look(pLook:String) : void
      {
         if(this.getEntitySprite())
         {
            this._look = pLook;
            this._entity.look.updateFrom(EntityLookParser.fromString(pLook));
         }
      }
      
      public function get direction() : int
      {
         return this._direction;
      }
      
      public function set direction(pDirection:int) : void
      {
         this._direction = pDirection;
         if(this.getEntitySprite())
         {
            this._entity.setDirection(pDirection);
         }
      }
      
      public function get scaleX() : Number
      {
         return !!this.getEntitySprite() ? Number(this._entity.scaleX) : Number(NaN);
      }
      
      public function set scaleX(pScaleX:Number) : void
      {
         if(this.getEntitySprite())
         {
            this._entity.scaleX = pScaleX;
         }
      }
      
      public function get scaleY() : Number
      {
         return !!this.getEntitySprite() ? Number(this._entity.scaleY) : Number(NaN);
      }
      
      public function set scaleY(pScaleY:Number) : void
      {
         if(this.getEntitySprite())
         {
            this._entity.scaleY = pScaleY;
         }
      }
      
      public function move(... pArgs) : ISequencable
      {
         var step:ISequencable = null;
         if(this.getEntitySprite())
         {
            step = new MoveStep(AnimatedCharacter(this._entity),pArgs);
         }
         return step;
      }
      
      public function walk(... pArgs) : ISequencable
      {
         var step:ISequencable = null;
         if(this.getEntitySprite())
         {
            step = new MoveStep(AnimatedCharacter(this._entity),pArgs,WalkingMovementBehavior.getInstance());
         }
         return step;
      }
      
      public function run(... pArgs) : ISequencable
      {
         var step:ISequencable = null;
         if(this.getEntitySprite())
         {
            step = new MoveStep(AnimatedCharacter(this._entity),pArgs,RunningMovementBehavior.getInstance());
         }
         return step;
      }
      
      public function slide(... pArgs) : ISequencable
      {
         var step:ISequencable = null;
         if(this.getEntitySprite())
         {
            step = new MoveStep(AnimatedCharacter(this._entity),pArgs,SlideMovementBehavior.getInstance());
         }
         return step;
      }
      
      public function teleport(... pArgs) : ISequencable
      {
         var step:ISequencable = null;
         if(this.getEntitySprite())
         {
            step = new TeleportStep(AnimatedCharacter(this._entity),pArgs);
         }
         return step;
      }
      
      public function lookAt(... pArgs) : ISequencable
      {
         var step:ISequencable = null;
         if(this.getEntitySprite())
         {
            step = new LookAtStep(AnimatedCharacter(this._entity),pArgs);
         }
         return step;
      }
      
      public function wait(pMilliseconds:int) : ISequencable
      {
         return new WaitStep(pMilliseconds);
      }
      
      public function stop() : ISequencable
      {
         var step:ISequencable = null;
         if(this.getEntitySprite())
         {
            step = new CallbackStep(new Callback(AnimatedCharacter(this._entity).stop));
         }
         return step;
      }
      
      public function setDirection(pDirection:int) : ISequencable
      {
         var step:ISequencable = null;
         if(this.getEntitySprite())
         {
            step = new SetDirectionStep(this._entity,pDirection);
         }
         return step;
      }
      
      public function setAnimation(pAnimation:String, pLoop:int = 1, pEndAnimation:String = "") : ISequencable
      {
         var step:ISequencable = null;
         if(this.getEntitySprite())
         {
            step = new PlayAnimationStep(this._entity,pAnimation,true,true,"animation_event_end",pLoop,pEndAnimation);
         }
         return step;
      }
      
      public function playEmote(pEmoteId:int, pWaitForEnd:Boolean = true) : ISequencable
      {
         var step:ISequencable = null;
         if(this.getEntitySprite())
         {
            step = new PlayEmoteStep(this._entity as AnimatedCharacter,pEmoteId,pWaitForEnd);
         }
         return step;
      }
      
      public function playSmiley(pSmileyId:int, pWaitForEnd:Boolean = true) : ISequencable
      {
         var step:ISequencable = null;
         if(this.getEntitySprite())
         {
            step = new PlaySmileyStep(this._entity as AnimatedCharacter,pSmileyId,pWaitForEnd);
         }
         return step;
      }
      
      public function think(pText:String, pWaitForEnd:Boolean = true) : ISequencable
      {
         var step:ISequencable = null;
         if(this.getEntitySprite())
         {
            step = new TextBubbleStep(this._entity as AnimatedCharacter,new ThinkBubble(pText),pWaitForEnd);
         }
         return step;
      }
      
      public function speak(pText:String, pWaitForEnd:Boolean = true) : ISequencable
      {
         var step:ISequencable = null;
         if(this.getEntitySprite())
         {
            step = new TextBubbleStep(this._entity as AnimatedCharacter,new ChatBubble(pText),pWaitForEnd);
         }
         return step;
      }
      
      public function setLook(pLook:String) : ISequencable
      {
         var step:ISequencable = null;
         if(this.getEntitySprite())
         {
            step = CallbackStep(new Callback(this._entity.look.updateFrom,EntityLookParser.fromString(pLook)));
         }
         return step;
      }
      
      public function display() : ISequencable
      {
         return new DisplayEntityStep(this._id,this._look,MapTools.getCellIdByCoord(this._x,this._y),this._direction);
      }
      
      public function remove() : ISequencable
      {
         return new RemoveEntityStep(this._id);
      }
      
      public function destroy() : void
      {
      }
      
      private function getEntitySprite() : TiphonSprite
      {
         if(!this._entity)
         {
            this._entity = DofusEntities.getEntity(this._id) as TiphonSprite;
         }
         return this._entity;
      }
   }
}
