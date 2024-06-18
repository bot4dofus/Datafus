package com.ankamagames.dofus.network.messages.game.presets
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PresetUseResultWithMissingIdsMessage extends PresetUseResultMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5059;
       
      
      private var _isInitialized:Boolean = false;
      
      public var missingIds:Vector.<uint>;
      
      private var _missingIdstree:FuncTree;
      
      public function PresetUseResultWithMissingIdsMessage()
      {
         this.missingIds = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5059;
      }
      
      public function initPresetUseResultWithMissingIdsMessage(presetId:int = 0, code:uint = 3, missingIds:Vector.<uint> = null) : PresetUseResultWithMissingIdsMessage
      {
         super.initPresetUseResultMessage(presetId,code);
         this.missingIds = missingIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.missingIds = new Vector.<uint>();
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
         this.serializeAs_PresetUseResultWithMissingIdsMessage(output);
      }
      
      public function serializeAs_PresetUseResultWithMissingIdsMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_PresetUseResultMessage(output);
         output.writeShort(this.missingIds.length);
         for(var _i1:uint = 0; _i1 < this.missingIds.length; _i1++)
         {
            if(this.missingIds[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.missingIds[_i1] + ") on element 1 (starting at 1) of missingIds.");
            }
            output.writeVarShort(this.missingIds[_i1]);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PresetUseResultWithMissingIdsMessage(input);
      }
      
      public function deserializeAs_PresetUseResultWithMissingIdsMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         super.deserialize(input);
         var _missingIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _missingIdsLen; _i1++)
         {
            _val1 = input.readVarUhShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of missingIds.");
            }
            this.missingIds.push(_val1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PresetUseResultWithMissingIdsMessage(tree);
      }
      
      public function deserializeAsyncAs_PresetUseResultWithMissingIdsMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._missingIdstree = tree.addChild(this._missingIdstreeFunc);
      }
      
      private function _missingIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._missingIdstree.addChild(this._missingIdsFunc);
         }
      }
      
      private function _missingIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of missingIds.");
         }
         this.missingIds.push(_val);
      }
   }
}
