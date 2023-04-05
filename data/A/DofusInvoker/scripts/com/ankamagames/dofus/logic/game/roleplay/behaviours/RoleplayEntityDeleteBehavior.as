package com.ankamagames.dofus.logic.game.roleplay.behaviours
{
   import com.ankamagames.dofus.logic.game.common.behaviours.IEntityDeleteBehavior;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   
   public class RoleplayEntityDeleteBehavior implements IEntityDeleteBehavior
   {
      
      private static var _self:RoleplayEntityDeleteBehavior;
       
      
      public function RoleplayEntityDeleteBehavior()
      {
         super();
      }
      
      public static function getInstance() : RoleplayEntityDeleteBehavior
      {
         if(!_self)
         {
            _self = new RoleplayEntityDeleteBehavior();
         }
         return _self;
      }
      
      public function entityDeleted(pEntity:AnimatedCharacter) : void
      {
      }
   }
}
