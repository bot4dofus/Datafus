package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightLeaveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6974;
       
      
      private var _isInitialized:Boolean = false;
      
      public var charId:Number = 0;
      
      public function GameFightLeaveMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6974;
      }
      
      public function initGameFightLeaveMessage(charId:Number = 0) : GameFightLeaveMessage
      {
         this.charId = charId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.charId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightLeaveMessage(output);
      }
      
      public function serializeAs_GameFightLeaveMessage(output:ICustomDataOutput) : void
      {
         if(this.charId < -9007199254740992 || this.charId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.charId + ") on element charId.");
         }
         output.writeDouble(this.charId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightLeaveMessage(input);
      }
      
      public function deserializeAs_GameFightLeaveMessage(input:ICustomDataInput) : void
      {
         this._charIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightLeaveMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightLeaveMessage(tree:FuncTree) : void
      {
         tree.addChild(this._charIdFunc);
      }
      
      private function _charIdFunc(input:ICustomDataInput) : void
      {
         this.charId = input.readDouble();
         if(this.charId < -9007199254740992 || this.charId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.charId + ") on element of GameFightLeaveMessage.charId.");
         }
      }
   }
}
