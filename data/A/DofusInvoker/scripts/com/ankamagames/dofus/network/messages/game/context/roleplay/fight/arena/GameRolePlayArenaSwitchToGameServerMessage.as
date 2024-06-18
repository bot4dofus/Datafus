package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayArenaSwitchToGameServerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6763;
       
      
      private var _isInitialized:Boolean = false;
      
      public var validToken:Boolean = false;
      
      [Transient]
      public var token:String = "";
      
      public var homeServerId:int = 0;
      
      public function GameRolePlayArenaSwitchToGameServerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6763;
      }
      
      public function initGameRolePlayArenaSwitchToGameServerMessage(validToken:Boolean = false, token:String = "", homeServerId:int = 0) : GameRolePlayArenaSwitchToGameServerMessage
      {
         this.validToken = validToken;
         this.token = token;
         this.homeServerId = homeServerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.validToken = false;
         this.token = "";
         this.homeServerId = 0;
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
         this.serializeAs_GameRolePlayArenaSwitchToGameServerMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaSwitchToGameServerMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.validToken);
         output.writeUTF(this.token);
         output.writeShort(this.homeServerId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayArenaSwitchToGameServerMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaSwitchToGameServerMessage(input:ICustomDataInput) : void
      {
         this._validTokenFunc(input);
         this._tokenFunc(input);
         this._homeServerIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayArenaSwitchToGameServerMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayArenaSwitchToGameServerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._validTokenFunc);
         tree.addChild(this._tokenFunc);
         tree.addChild(this._homeServerIdFunc);
      }
      
      private function _validTokenFunc(input:ICustomDataInput) : void
      {
         this.validToken = input.readBoolean();
      }
      
      private function _tokenFunc(input:ICustomDataInput) : void
      {
         this.token = input.readUTF();
      }
      
      private function _homeServerIdFunc(input:ICustomDataInput) : void
      {
         this.homeServerId = input.readShort();
      }
   }
}
