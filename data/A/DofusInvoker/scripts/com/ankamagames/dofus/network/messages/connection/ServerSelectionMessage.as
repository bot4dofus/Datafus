package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ServerSelectionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2862;
       
      
      private var _isInitialized:Boolean = false;
      
      public var serverId:uint = 0;
      
      public function ServerSelectionMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2862;
      }
      
      public function initServerSelectionMessage(serverId:uint = 0) : ServerSelectionMessage
      {
         this.serverId = serverId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.serverId = 0;
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
         this.serializeAs_ServerSelectionMessage(output);
      }
      
      public function serializeAs_ServerSelectionMessage(output:ICustomDataOutput) : void
      {
         if(this.serverId < 0)
         {
            throw new Error("Forbidden value (" + this.serverId + ") on element serverId.");
         }
         output.writeVarShort(this.serverId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ServerSelectionMessage(input);
      }
      
      public function deserializeAs_ServerSelectionMessage(input:ICustomDataInput) : void
      {
         this._serverIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ServerSelectionMessage(tree);
      }
      
      public function deserializeAsyncAs_ServerSelectionMessage(tree:FuncTree) : void
      {
         tree.addChild(this._serverIdFunc);
      }
      
      private function _serverIdFunc(input:ICustomDataInput) : void
      {
         this.serverId = input.readVarUhShort();
         if(this.serverId < 0)
         {
            throw new Error("Forbidden value (" + this.serverId + ") on element of ServerSelectionMessage.serverId.");
         }
      }
   }
}
