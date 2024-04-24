package com.ankamagames.dofus.network.messages.connection.search
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AcquaintanceServerListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9101;
       
      
      private var _isInitialized:Boolean = false;
      
      public var servers:Vector.<uint>;
      
      private var _serverstree:FuncTree;
      
      public function AcquaintanceServerListMessage()
      {
         this.servers = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9101;
      }
      
      public function initAcquaintanceServerListMessage(servers:Vector.<uint> = null) : AcquaintanceServerListMessage
      {
         this.servers = servers;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.servers = new Vector.<uint>();
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
         this.serializeAs_AcquaintanceServerListMessage(output);
      }
      
      public function serializeAs_AcquaintanceServerListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.servers.length);
         for(var _i1:uint = 0; _i1 < this.servers.length; _i1++)
         {
            if(this.servers[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.servers[_i1] + ") on element 1 (starting at 1) of servers.");
            }
            output.writeVarShort(this.servers[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AcquaintanceServerListMessage(input);
      }
      
      public function deserializeAs_AcquaintanceServerListMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _serversLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _serversLen; _i1++)
         {
            _val1 = input.readVarUhShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of servers.");
            }
            this.servers.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AcquaintanceServerListMessage(tree);
      }
      
      public function deserializeAsyncAs_AcquaintanceServerListMessage(tree:FuncTree) : void
      {
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
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of servers.");
         }
         this.servers.push(_val);
      }
   }
}
