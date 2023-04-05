package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GroundObject extends GameRolePlayActorInformations
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GroundObject));
       
      
      public var object:Item;
      
      public function GroundObject(pObject:Item)
      {
         super();
         this.object = pObject;
      }
   }
}
