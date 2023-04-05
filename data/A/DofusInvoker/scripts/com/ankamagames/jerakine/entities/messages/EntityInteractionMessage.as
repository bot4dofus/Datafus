package com.ankamagames.jerakine.entities.messages
{
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   import com.ankamagames.jerakine.messages.Message;
   
   public class EntityInteractionMessage implements Message
   {
       
      
      private var _entity:IInteractive;
      
      public function EntityInteractionMessage(entity:IInteractive)
      {
         super();
         this._entity = entity;
      }
      
      public function get entity() : IInteractive
      {
         return this._entity;
      }
   }
}
