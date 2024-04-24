package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceRightsUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1711;
       
      
      private var _isInitialized:Boolean = false;
      
      public var rankId:uint = 0;
      
      public var rights:Vector.<uint>;
      
      private var _rightstree:FuncTree;
      
      public function AllianceRightsUpdateMessage()
      {
         this.rights = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1711;
      }
      
      public function initAllianceRightsUpdateMessage(rankId:uint = 0, rights:Vector.<uint> = null) : AllianceRightsUpdateMessage
      {
         this.rankId = rankId;
         this.rights = rights;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.rankId = 0;
         this.rights = new Vector.<uint>();
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
         this.serializeAs_AllianceRightsUpdateMessage(output);
      }
      
      public function serializeAs_AllianceRightsUpdateMessage(output:ICustomDataOutput) : void
      {
         if(this.rankId < 0)
         {
            throw new Error("Forbidden value (" + this.rankId + ") on element rankId.");
         }
         output.writeVarInt(this.rankId);
         output.writeShort(this.rights.length);
         for(var _i2:uint = 0; _i2 < this.rights.length; _i2++)
         {
            if(this.rights[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.rights[_i2] + ") on element 2 (starting at 1) of rights.");
            }
            output.writeVarInt(this.rights[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceRightsUpdateMessage(input);
      }
      
      public function deserializeAs_AllianceRightsUpdateMessage(input:ICustomDataInput) : void
      {
         var _val2:uint = 0;
         this._rankIdFunc(input);
         var _rightsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _rightsLen; _i2++)
         {
            _val2 = input.readVarUhInt();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of rights.");
            }
            this.rights.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceRightsUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceRightsUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._rankIdFunc);
         this._rightstree = tree.addChild(this._rightstreeFunc);
      }
      
      private function _rankIdFunc(input:ICustomDataInput) : void
      {
         this.rankId = input.readVarUhInt();
         if(this.rankId < 0)
         {
            throw new Error("Forbidden value (" + this.rankId + ") on element of AllianceRightsUpdateMessage.rankId.");
         }
      }
      
      private function _rightstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._rightstree.addChild(this._rightsFunc);
         }
      }
      
      private function _rightsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of rights.");
         }
         this.rights.push(_val);
      }
   }
}
