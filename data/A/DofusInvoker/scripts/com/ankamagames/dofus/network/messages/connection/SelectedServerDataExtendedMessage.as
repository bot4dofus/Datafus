package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.dofus.network.types.connection.GameServerInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SelectedServerDataExtendedMessage extends SelectedServerDataMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7269;
       
      
      private var _isInitialized:Boolean = false;
      
      public var servers:Vector.<GameServerInformations>;
      
      private var _serverstree:FuncTree;
      
      public function SelectedServerDataExtendedMessage()
      {
         this.servers = new Vector.<GameServerInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7269;
      }
      
      public function initSelectedServerDataExtendedMessage(serverId:uint = 0, address:String = "", ports:Vector.<uint> = null, canCreateNewCharacter:Boolean = false, ticket:Vector.<int> = null, servers:Vector.<GameServerInformations> = null) : SelectedServerDataExtendedMessage
      {
         super.initSelectedServerDataMessage(serverId,address,ports,canCreateNewCharacter,ticket);
         this.servers = servers;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.servers = new Vector.<GameServerInformations>();
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SelectedServerDataExtendedMessage(output);
      }
      
      public function serializeAs_SelectedServerDataExtendedMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_SelectedServerDataMessage(output);
         output.writeShort(this.servers.length);
         for(var _i1:uint = 0; _i1 < this.servers.length; _i1++)
         {
            (this.servers[_i1] as GameServerInformations).serializeAs_GameServerInformations(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SelectedServerDataExtendedMessage(input);
      }
      
      public function deserializeAs_SelectedServerDataExtendedMessage(input:ICustomDataInput) : void
      {
         var _item1:GameServerInformations = null;
         super.deserialize(input);
         var _serversLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _serversLen; _i1++)
         {
            _item1 = new GameServerInformations();
            _item1.deserialize(input);
            this.servers.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SelectedServerDataExtendedMessage(tree);
      }
      
      public function deserializeAsyncAs_SelectedServerDataExtendedMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._serverstree = tree.addChild(this._serverstreeFunc);
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
   }
}
