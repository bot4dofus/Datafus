package com.ankamagames.jerakine.entities.interfaces
{
   import com.ankamagames.jerakine.messages.MessageHandler;
   import flash.events.IEventDispatcher;
   
   public interface IInteractive extends IEventDispatcher, IEntity
   {
       
      
      function get handler() : MessageHandler;
      
      function get useHandCursor() : Boolean;
      
      function get enabledInteractions() : uint;
   }
}
