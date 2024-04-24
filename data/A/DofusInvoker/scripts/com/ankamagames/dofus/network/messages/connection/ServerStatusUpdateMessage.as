package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.dofus.network.types.connection.GameServerInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ServerStatusUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2732;
       
      
      private var _isInitialized:Boolean = false;
      
      public var server:GameServerInformations;
      
      private var _servertree:FuncTree;
      
      public function ServerStatusUpdateMessage()
      {
         this.server = new GameServerInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2732;
      }
      
      public function initServerStatusUpdateMessage(server:GameServerInformations = null) : ServerStatusUpdateMessage
      {
         this.server = server;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.server = new GameServerInformations();
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
         this.serializeAs_ServerStatusUpdateMessage(output);
      }
      
      public function serializeAs_ServerStatusUpdateMessage(output:ICustomDataOutput) : void
      {
         this.server.serializeAs_GameServerInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ServerStatusUpdateMessage(input);
      }
      
      public function deserializeAs_ServerStatusUpdateMessage(input:ICustomDataInput) : void
      {
         this.server = new GameServerInformations();
         this.server.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ServerStatusUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_ServerStatusUpdateMessage(tree:FuncTree) : void
      {
         this._servertree = tree.addChild(this._servertreeFunc);
      }
      
      private function _servertreeFunc(input:ICustomDataInput) : void
      {
         this.server = new GameServerInformations();
         this.server.deserializeAsync(this._servertree);
      }
   }
}
