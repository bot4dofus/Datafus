package com.ankamagames.jerakine.entities.messages
{
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   
   public class EntityClickMessage extends EntityInteractionMessage
   {
       
      
      public var fromStack:Boolean;
      
      public function EntityClickMessage(entity:IInteractive)
      {
         super(entity);
      }
   }
}
