package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.atouin.types.sequences.DestroyEntityStep;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightEntitiesHolder;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   
   public class FightDestroyEntityStep extends DestroyEntityStep implements IFightStep
   {
       
      
      public function FightDestroyEntityStep(entity:IEntity, waitAnim:Boolean = false, waitAnimForCallback:Boolean = false)
      {
         super(entity,waitAnim,waitAnimForCallback);
         FightEntitiesHolder.getInstance().unholdEntity(entity.id);
      }
      
      public function get stepType() : String
      {
         return "destroyEntity";
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[_entity.id];
      }
   }
}
