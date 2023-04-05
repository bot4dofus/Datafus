package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.atouin.entities.behaviours.display.AtouinDisplayBehavior;
   import com.ankamagames.dofus.misc.BenchmarkMovementBehavior;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.jerakine.entities.behaviours.IMovementBehavior;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class BenchmarkCharacter extends AnimatedCharacter
   {
       
      
      public function BenchmarkCharacter(nId:Number, look:TiphonEntityLook)
      {
         super(nId,look);
         _displayBehavior = AtouinDisplayBehavior.getInstance();
         _movementBehavior = BenchmarkMovementBehavior.getInstance();
         setAnimationAndDirection(AnimationEnum.ANIM_STATIQUE,DirectionsEnum.RIGHT);
         this.id = nId;
      }
      
      override public function move(path:MovementPath, callback:Function = null, movementBehavior:IMovementBehavior = null) : void
      {
         if(!path.start.equals(position))
         {
            _log.warn("Unsynchronized position for entity " + id + ", jumping from " + position + " to " + path.start + ".");
            jump(path.start);
         }
         _movementBehavior = BenchmarkMovementBehavior.getInstance();
         _movementBehavior.move(this,path,callback);
      }
   }
}
