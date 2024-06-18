package com.ankamagames.dofus.network.messages.game.social
{
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ContactLookMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4925;
       
      
      private var _isInitialized:Boolean = false;
      
      public var requestId:uint = 0;
      
      public var playerName:String = "";
      
      public var playerId:Number = 0;
      
      public var look:EntityLook;
      
      private var _looktree:FuncTree;
      
      public function ContactLookMessage()
      {
         this.look = new EntityLook();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4925;
      }
      
      public function initContactLookMessage(requestId:uint = 0, playerName:String = "", playerId:Number = 0, look:EntityLook = null) : ContactLookMessage
      {
         this.requestId = requestId;
         this.playerName = playerName;
         this.playerId = playerId;
         this.look = look;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.requestId = 0;
         this.playerName = "";
         this.playerId = 0;
         this.look = new EntityLook();
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
         this.serializeAs_ContactLookMessage(output);
      }
      
      public function serializeAs_ContactLookMessage(output:ICustomDataOutput) : void
      {
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
         }
         output.writeVarInt(this.requestId);
         output.writeUTF(this.playerName);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         this.look.serializeAs_EntityLook(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ContactLookMessage(input);
      }
      
      public function deserializeAs_ContactLookMessage(input:ICustomDataInput) : void
      {
         this._requestIdFunc(input);
         this._playerNameFunc(input);
         this._playerIdFunc(input);
         this.look = new EntityLook();
         this.look.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ContactLookMessage(tree);
      }
      
      public function deserializeAsyncAs_ContactLookMessage(tree:FuncTree) : void
      {
         tree.addChild(this._requestIdFunc);
         tree.addChild(this._playerNameFunc);
         tree.addChild(this._playerIdFunc);
         this._looktree = tree.addChild(this._looktreeFunc);
      }
      
      private function _requestIdFunc(input:ICustomDataInput) : void
      {
         this.requestId = input.readVarUhInt();
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element of ContactLookMessage.requestId.");
         }
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
            throw new Error("Forbidden value (" + this.playerId + ") on element of ContactLookMessage.playerId.");
         }
      }
      
      private function _looktreeFunc(input:ICustomDataInput) : void
      {
         this.look = new EntityLook();
         this.look.deserializeAsync(this._looktree);
      }
   }
}
