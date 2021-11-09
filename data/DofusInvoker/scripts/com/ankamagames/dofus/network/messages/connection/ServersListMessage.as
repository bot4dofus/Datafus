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
   
   public class ServersListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2559;
       
      
      private var _isInitialized:Boolean = false;
      
      public var servers:Vector.<GameServerInformations>;
      
      public var alreadyConnectedToServerId:uint = 0;
      
      public var canCreateNewCharacter:Boolean = false;
      
      private var _serverstree:FuncTree;
      
      public function ServersListMessage()
      {
         this.servers = new Vector.<GameServerInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2559;
      }
      
      public function initServersListMessage(servers:Vector.<GameServerInformations> = null, alreadyConnectedToServerId:uint = 0, canCreateNewCharacter:Boolean = false) : ServersListMessage
      {
         this.servers = servers;
         this.alreadyConnectedToServerId = alreadyConnectedToServerId;
         this.canCreateNewCharacter = canCreateNewCharacter;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.servers = new Vector.<GameServerInformations>();
         this.alreadyConnectedToServerId = 0;
         this.canCreateNewCharacter = false;
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
         this.serializeAs_ServersListMessage(output);
      }
      
      public function serializeAs_ServersListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.servers.length);
         for(var _i1:uint = 0; _i1 < this.servers.length; _i1++)
         {
            (this.servers[_i1] as GameServerInformations).serializeAs_GameServerInformations(output);
         }
         if(this.alreadyConnectedToServerId < 0)
         {
            throw new Error("Forbidden value (" + this.alreadyConnectedToServerId + ") on element alreadyConnectedToServerId.");
         }
         output.writeVarShort(this.alreadyConnectedToServerId);
         output.writeBoolean(this.canCreateNewCharacter);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ServersListMessage(input);
      }
      
      public function deserializeAs_ServersListMessage(input:ICustomDataInput) : void
      {
         var _item1:GameServerInformations = null;
         var _serversLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _serversLen; _i1++)
         {
            _item1 = new GameServerInformations();
            _item1.deserialize(input);
            this.servers.push(_item1);
         }
         this._alreadyConnectedToServerIdFunc(input);
         this._canCreateNewCharacterFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ServersListMessage(tree);
      }
      
      public function deserializeAsyncAs_ServersListMessage(tree:FuncTree) : void
      {
         this._serverstree = tree.addChild(this._serverstreeFunc);
         tree.addChild(this._alreadyConnectedToServerIdFunc);
         tree.addChild(this._canCreateNewCharacterFunc);
      }
      
      private function _serverstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._serverstree.addChild(this._serversFunc);
         }
      }
      
      private function _serversFunc(input:ICustomDataInput) : void
      {
         var _item:GameServerInformations = new GameServerInformations();
         _item.deserialize(input);
         this.servers.push(_item);
      }
      
      private function _alreadyConnectedToServerIdFunc(input:ICustomDataInput) : void
      {
         this.alreadyConnectedToServerId = input.readVarUhShort();
         if(this.alreadyConnectedToServerId < 0)
         {
            throw new Error("Forbidden value (" + this.alreadyConnectedToServerId + ") on element of ServersListMessage.alreadyConnectedToServerId.");
         }
      }
      
      private function _canCreateNewCharacterFunc(input:ICustomDataInput) : void
      {
         this.canCreateNewCharacter = input.readBoolean();
      }
   }
}
