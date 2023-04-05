package com.ankamagames.dofus.logic.game.roleplay.messages
{
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.jerakine.messages.Message;
   
   public class InteractiveElementMouseOutMessage implements Message
   {
       
      
      private var _ie:InteractiveElement;
      
      public function InteractiveElementMouseOutMessage(ie:InteractiveElement)
      {
         super();
         this._ie = ie;
      }
      
      public function get interactiveElement() : InteractiveElement
      {
         return this._ie;
      }
   }
}
