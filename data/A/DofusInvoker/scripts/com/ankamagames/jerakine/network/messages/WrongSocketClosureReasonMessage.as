package com.ankamagames.jerakine.network.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class WrongSocketClosureReasonMessage implements Message
   {
       
      
      private var _expectedReason:uint;
      
      private var _gotReason:uint;
      
      public function WrongSocketClosureReasonMessage(expectedReason:uint, gotReason:uint)
      {
         super();
         this._expectedReason = expectedReason;
         this._gotReason = gotReason;
      }
      
      public function get expectedReason() : uint
      {
         return this._expectedReason;
      }
      
      public function get gotReason() : uint
      {
         return this._gotReason;
      }
   }
}
