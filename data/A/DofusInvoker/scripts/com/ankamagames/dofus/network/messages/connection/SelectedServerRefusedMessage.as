package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SelectedServerRefusedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2159;
       
      
      private var _isInitialized:Boolean = false;
      
      public var serverId:uint = 0;
      
      public var error:uint = 1;
      
      public var serverStatus:uint = 1;
      
      public function SelectedServerRefusedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2159;
      }
      
      public function initSelectedServerRefusedMessage(serverId:uint = 0, error:uint = 1, serverStatus:uint = 1) : SelectedServerRefusedMessage
      {
         this.serverId = serverId;
         this.error = error;
         this.serverStatus = serverStatus;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.serverId = 0;
         this.error = 1;
         this.serverStatus = 1;
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
         this.serializeAs_SelectedServerRefusedMessage(output);
      }
      
      public function serializeAs_SelectedServerRefusedMessage(output:ICustomDataOutput) : void
      {
         if(this.serverId < 0)
         {
            throw new Error("Forbidden value (" + this.serverId + ") on element serverId.");
         }
         output.writeVarShort(this.serverId);
         output.writeByte(this.error);
         output.writeByte(this.serverStatus);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SelectedServerRefusedMessage(input);
      }
      
      public function deserializeAs_SelectedServerRefusedMessage(input:ICustomDataInput) : void
      {
         this._serverIdFunc(input);
         this._errorFunc(input);
         this._serverStatusFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SelectedServerRefusedMessage(tree);
      }
      
      public function deserializeAsyncAs_SelectedServerRefusedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._serverIdFunc);
         tree.addChild(this._errorFunc);
         tree.addChild(this._serverStatusFunc);
      }
      
      private function _serverIdFunc(input:ICustomDataInput) : void
      {
         this.serverId = input.readVarUhShort();
         if(this.serverId < 0)
         {
            throw new Error("Forbidden value (" + this.serverId + ") on element of SelectedServerRefusedMessage.serverId.");
         }
      }
      
      private function _errorFunc(input:ICustomDataInput) : void
      {
         this.error = input.readByte();
         if(this.error < 0)
         {
            throw new Error("Forbidden value (" + this.error + ") on element of SelectedServerRefusedMessage.error.");
         }
      }
      
      private function _serverStatusFunc(input:ICustomDataInput) : void
      {
         this.serverStatus = input.readByte();
         if(this.serverStatus < 0)
         {
            throw new Error("Forbidden value (" + this.serverStatus + ") on element of SelectedServerRefusedMessage.serverStatus.");
         }
      }
   }
}
