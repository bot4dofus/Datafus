package com.ankamagames.dofus.kernel.zaap.messages.impl
{
   import com.ankamagames.dofus.kernel.zaap.messages.IZaapOutputMessage;
   
   public class RequestApiTokenMessage implements IZaapOutputMessage
   {
       
      
      private var _gameId:int;
      
      public function RequestApiTokenMessage(gameId:int)
      {
         super();
         this._gameId = gameId;
      }
      
      public function get gameId() : int
      {
         return this._gameId;
      }
   }
}
