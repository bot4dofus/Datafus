package com.ankamagames.dofus.network.messages.game.presets
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IdolsPresetSaveRequestMessage extends IconPresetSaveRequestMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4449;
       
      
      private var _isInitialized:Boolean = false;
      
      public function IdolsPresetSaveRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4449;
      }
      
      public function initIdolsPresetSaveRequestMessage(presetId:int = 0, symbolId:uint = 0, updateData:Boolean = false) : IdolsPresetSaveRequestMessage
      {
         super.initIconPresetSaveRequestMessage(presetId,symbolId,updateData);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
         this.serializeAs_IdolsPresetSaveRequestMessage(output);
      }
      
      public function serializeAs_IdolsPresetSaveRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_IconPresetSaveRequestMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IdolsPresetSaveRequestMessage(input);
      }
      
      public function deserializeAs_IdolsPresetSaveRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IdolsPresetSaveRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_IdolsPresetSaveRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
