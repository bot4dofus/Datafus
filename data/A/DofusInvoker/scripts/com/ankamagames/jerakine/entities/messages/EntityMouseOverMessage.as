package com.ankamagames.jerakine.entities.messages
{
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   
   public class EntityMouseOverMessage extends EntityInteractionMessage
   {
       
      
      public var virtual:Boolean;
      
      public var checkSuperposition:Boolean;
      
      public function EntityMouseOverMessage(entity:IInteractive, virtual:Boolean = false, checkSuperposition:Boolean = false)
      {
         super(entity);
         this.virtual = virtual;
         this.checkSuperposition = checkSuperposition;
      }
   }
}
