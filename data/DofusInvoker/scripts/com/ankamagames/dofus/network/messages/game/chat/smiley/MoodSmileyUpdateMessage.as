package com.ankamagames.dofus.network.messages.game.chat.smiley
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MoodSmileyUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2215;
       
      
      private var _isInitialized:Boolean = false;
      
      public var accountId:uint = 0;
      
      public var playerId:Number = 0;
      
      public var smileyId:uint = 0;
      
      public function MoodSmileyUpdateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2215;
      }
      
      public function initMoodSmileyUpdateMessage(accountId:uint = 0, playerId:Number = 0, smileyId:uint = 0) : MoodSmileyUpdateMessage
      {
         this.accountId = accountId;
         this.playerId = playerId;
         this.smileyId = smileyId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.accountId = 0;
         this.playerId = 0;
         this.smileyId = 0;
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
         this.serializeAs_MoodSmileyUpdateMessage(output);
      }
      
      public function serializeAs_MoodSmileyUpdateMessage(output:ICustomDataOutput) : void
      {
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         output.writeInt(this.accountId);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element smileyId.");
         }
         output.writeVarShort(this.smileyId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MoodSmileyUpdateMessage(input);
      }
      
      public function deserializeAs_MoodSmileyUpdateMessage(input:ICustomDataInput) : void
      {
         this._accountIdFunc(input);
         this._playerIdFunc(input);
         this._smileyIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MoodSmileyUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_MoodSmileyUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._accountIdFunc);
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._smileyIdFunc);
      }
      
      private function _accountIdFunc(input:ICustomDataInput) : void
      {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of MoodSmileyUpdateMessage.accountId.");
         }
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of MoodSmileyUpdateMessage.playerId.");
         }
      }
      
      private function _smileyIdFunc(input:ICustomDataInput) : void
      {
         this.smileyId = input.readVarUhShort();
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element of MoodSmileyUpdateMessage.smileyId.");
         }
      }
   }
}
