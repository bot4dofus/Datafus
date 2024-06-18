package com.ankamagames.dofus.network.messages.game.presets
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IconPresetSaveRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6591;
       
      
      private var _isInitialized:Boolean = false;
      
      public var presetId:int = 0;
      
      public var symbolId:uint = 0;
      
      public var updateData:Boolean = false;
      
      public function IconPresetSaveRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6591;
      }
      
      public function initIconPresetSaveRequestMessage(presetId:int = 0, symbolId:uint = 0, updateData:Boolean = false) : IconPresetSaveRequestMessage
      {
         this.presetId = presetId;
         this.symbolId = symbolId;
         this.updateData = updateData;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.presetId = 0;
         this.symbolId = 0;
         this.updateData = false;
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
         this.serializeAs_IconPresetSaveRequestMessage(output);
      }
      
      public function serializeAs_IconPresetSaveRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.presetId);
         if(this.symbolId < 0)
         {
            throw new Error("Forbidden value (" + this.symbolId + ") on element symbolId.");
         }
         output.writeByte(this.symbolId);
         output.writeBoolean(this.updateData);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IconPresetSaveRequestMessage(input);
      }
      
      public function deserializeAs_IconPresetSaveRequestMessage(input:ICustomDataInput) : void
      {
         this._presetIdFunc(input);
         this._symbolIdFunc(input);
         this._updateDataFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IconPresetSaveRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_IconPresetSaveRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._presetIdFunc);
         tree.addChild(this._symbolIdFunc);
         tree.addChild(this._updateDataFunc);
      }
      
      private function _presetIdFunc(input:ICustomDataInput) : void
      {
         this.presetId = input.readShort();
      }
      
      private function _symbolIdFunc(input:ICustomDataInput) : void
      {
         this.symbolId = input.readByte();
         if(this.symbolId < 0)
         {
            throw new Error("Forbidden value (" + this.symbolId + ") on element of IconPresetSaveRequestMessage.symbolId.");
         }
      }
      
      private function _updateDataFunc(input:ICustomDataInput) : void
      {
         this.updateData = input.readBoolean();
      }
   }
}
