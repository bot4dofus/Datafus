package com.ankamagames.dofus.network.messages.game.look
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AccessoryPreviewRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1230;
       
      
      private var _isInitialized:Boolean = false;
      
      public var genericId:Vector.<uint>;
      
      private var _genericIdtree:FuncTree;
      
      public function AccessoryPreviewRequestMessage()
      {
         this.genericId = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1230;
      }
      
      public function initAccessoryPreviewRequestMessage(genericId:Vector.<uint> = null) : AccessoryPreviewRequestMessage
      {
         this.genericId = genericId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.genericId = new Vector.<uint>();
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
         this.serializeAs_AccessoryPreviewRequestMessage(output);
      }
      
      public function serializeAs_AccessoryPreviewRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.genericId.length);
         for(var _i1:uint = 0; _i1 < this.genericId.length; _i1++)
         {
            if(this.genericId[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.genericId[_i1] + ") on element 1 (starting at 1) of genericId.");
            }
            output.writeVarInt(this.genericId[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AccessoryPreviewRequestMessage(input);
      }
      
      public function deserializeAs_AccessoryPreviewRequestMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _genericIdLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _genericIdLen; _i1++)
         {
            _val1 = input.readVarUhInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of genericId.");
            }
            this.genericId.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AccessoryPreviewRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_AccessoryPreviewRequestMessage(tree:FuncTree) : void
      {
         this._genericIdtree = tree.addChild(this._genericIdtreeFunc);
      }
      
      private function _genericIdtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._genericIdtree.addChild(this._genericIdFunc);
         }
      }
      
      private function _genericIdFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of genericId.");
         }
         this.genericId.push(_val);
      }
   }
}
