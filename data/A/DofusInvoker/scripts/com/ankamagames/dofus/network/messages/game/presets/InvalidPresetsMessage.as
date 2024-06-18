package com.ankamagames.dofus.network.messages.game.presets
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class InvalidPresetsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1001;
       
      
      private var _isInitialized:Boolean = false;
      
      public var presetIds:Vector.<uint>;
      
      private var _presetIdstree:FuncTree;
      
      public function InvalidPresetsMessage()
      {
         this.presetIds = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1001;
      }
      
      public function initInvalidPresetsMessage(presetIds:Vector.<uint> = null) : InvalidPresetsMessage
      {
         this.presetIds = presetIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.presetIds = new Vector.<uint>();
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
         this.serializeAs_InvalidPresetsMessage(output);
      }
      
      public function serializeAs_InvalidPresetsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.presetIds.length);
         for(var _i1:uint = 0; _i1 < this.presetIds.length; _i1++)
         {
            if(this.presetIds[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.presetIds[_i1] + ") on element 1 (starting at 1) of presetIds.");
            }
            output.writeShort(this.presetIds[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InvalidPresetsMessage(input);
      }
      
      public function deserializeAs_InvalidPresetsMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _presetIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _presetIdsLen; _i1++)
         {
            _val1 = input.readShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of presetIds.");
            }
            this.presetIds.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InvalidPresetsMessage(tree);
      }
      
      public function deserializeAsyncAs_InvalidPresetsMessage(tree:FuncTree) : void
      {
         this._presetIdstree = tree.addChild(this._presetIdstreeFunc);
      }
      
      private function _presetIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._presetIdstree.addChild(this._presetIdsFunc);
         }
      }
      
      private function _presetIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of presetIds.");
         }
         this.presetIds.push(_val);
      }
   }
}
