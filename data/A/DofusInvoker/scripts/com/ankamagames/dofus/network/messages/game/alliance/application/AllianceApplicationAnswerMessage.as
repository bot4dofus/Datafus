package com.ankamagames.dofus.network.messages.game.alliance.application
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceApplicationAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5108;
       
      
      private var _isInitialized:Boolean = false;
      
      public var accepted:Boolean = false;
      
      public var playerId:Number = 0;
      
      public function AllianceApplicationAnswerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5108;
      }
      
      public function initAllianceApplicationAnswerMessage(accepted:Boolean = false, playerId:Number = 0) : AllianceApplicationAnswerMessage
      {
         this.accepted = accepted;
         this.playerId = playerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.accepted = false;
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
         this.serializeAs_AllianceApplicationAnswerMessage(output);
      }
      
      public function serializeAs_AllianceApplicationAnswerMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.accepted);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceApplicationAnswerMessage(input);
      }
      
      public function deserializeAs_AllianceApplicationAnswerMessage(input:ICustomDataInput) : void
      {
         this._acceptedFunc(input);
         this._playerIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceApplicationAnswerMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceApplicationAnswerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._acceptedFunc);
         tree.addChild(this._playerIdFunc);
      }
      
      private function _acceptedFunc(input:ICustomDataInput) : void
      {
         this.accepted = input.readBoolean();
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of AllianceApplicationAnswerMessage.playerId.");
         }
      }
   }
}
