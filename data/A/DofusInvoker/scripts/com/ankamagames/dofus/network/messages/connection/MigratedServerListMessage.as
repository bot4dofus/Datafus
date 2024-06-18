package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MigratedServerListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2491;
       
      
      private var _isInitialized:Boolean = false;
      
      public var migratedServerIds:Vector.<uint>;
      
      private var _migratedServerIdstree:FuncTree;
      
      public function MigratedServerListMessage()
      {
         this.migratedServerIds = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2491;
      }
      
      public function initMigratedServerListMessage(migratedServerIds:Vector.<uint> = null) : MigratedServerListMessage
      {
         this.migratedServerIds = migratedServerIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.migratedServerIds = new Vector.<uint>();
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
         this.serializeAs_MigratedServerListMessage(output);
      }
      
      public function serializeAs_MigratedServerListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.migratedServerIds.length);
         for(var _i1:uint = 0; _i1 < this.migratedServerIds.length; _i1++)
         {
            if(this.migratedServerIds[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.migratedServerIds[_i1] + ") on element 1 (starting at 1) of migratedServerIds.");
            }
            output.writeVarShort(this.migratedServerIds[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MigratedServerListMessage(input);
      }
      
      public function deserializeAs_MigratedServerListMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _migratedServerIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _migratedServerIdsLen; _i1++)
         {
            _val1 = input.readVarUhShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of migratedServerIds.");
            }
            this.migratedServerIds.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MigratedServerListMessage(tree);
      }
      
      public function deserializeAsyncAs_MigratedServerListMessage(tree:FuncTree) : void
      {
         this._migratedServerIdstree = tree.addChild(this._migratedServerIdstreeFunc);
      }
      
      private function _migratedServerIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._migratedServerIdstree.addChild(this._migratedServerIdsFunc);
         }
      }
      
      private function _migratedServerIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of migratedServerIds.");
         }
         this.migratedServerIds.push(_val);
      }
   }
}
