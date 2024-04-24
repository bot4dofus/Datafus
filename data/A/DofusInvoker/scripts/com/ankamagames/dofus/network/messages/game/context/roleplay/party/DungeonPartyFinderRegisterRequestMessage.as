package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class DungeonPartyFinderRegisterRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3137;
       
      
      private var _isInitialized:Boolean = false;
      
      public var dungeonIds:Vector.<uint>;
      
      private var _dungeonIdstree:FuncTree;
      
      public function DungeonPartyFinderRegisterRequestMessage()
      {
         this.dungeonIds = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3137;
      }
      
      public function initDungeonPartyFinderRegisterRequestMessage(dungeonIds:Vector.<uint> = null) : DungeonPartyFinderRegisterRequestMessage
      {
         this.dungeonIds = dungeonIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.dungeonIds = new Vector.<uint>();
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
         this.serializeAs_DungeonPartyFinderRegisterRequestMessage(output);
      }
      
      public function serializeAs_DungeonPartyFinderRegisterRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.dungeonIds.length);
         for(var _i1:uint = 0; _i1 < this.dungeonIds.length; _i1++)
         {
            if(this.dungeonIds[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.dungeonIds[_i1] + ") on element 1 (starting at 1) of dungeonIds.");
            }
            output.writeVarShort(this.dungeonIds[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DungeonPartyFinderRegisterRequestMessage(input);
      }
      
      public function deserializeAs_DungeonPartyFinderRegisterRequestMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _dungeonIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _dungeonIdsLen; _i1++)
         {
            _val1 = input.readVarUhShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of dungeonIds.");
            }
            this.dungeonIds.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DungeonPartyFinderRegisterRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_DungeonPartyFinderRegisterRequestMessage(tree:FuncTree) : void
      {
         this._dungeonIdstree = tree.addChild(this._dungeonIdstreeFunc);
      }
      
      private function _dungeonIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._dungeonIdstree.addChild(this._dungeonIdsFunc);
         }
      }
      
      private function _dungeonIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of dungeonIds.");
         }
         this.dungeonIds.push(_val);
      }
   }
}
