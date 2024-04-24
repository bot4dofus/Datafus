package com.ankamagames.dofus.network.messages.game.alliance.application
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceApplicationReceivedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9953;
       
      
      private var _isInitialized:Boolean = false;
      
      public var playerName:String = "";
      
      public var playerId:Number = 0;
      
      public function AllianceApplicationReceivedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9953;
      }
      
      public function initAllianceApplicationReceivedMessage(playerName:String = "", playerId:Number = 0) : AllianceApplicationReceivedMessage
      {
         this.playerName = playerName;
         this.playerId = playerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.playerName = "";
         this.playerId = 0;
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
         this.serializeAs_AllianceApplicationReceivedMessage(output);
      }
      
      public function serializeAs_AllianceApplicationReceivedMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.playerName);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceApplicationReceivedMessage(input);
      }
      
      public function deserializeAs_AllianceApplicationReceivedMessage(input:ICustomDataInput) : void
      {
         this._playerNameFunc(input);
         this._playerIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceApplicationReceivedMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceApplicationReceivedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._playerNameFunc);
         tree.addChild(this._playerIdFunc);
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of AllianceApplicationReceivedMessage.playerId.");
         }
      }
   }
}
