package com.ankamagames.dofus.network.messages.game.presets
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.presets.Preset;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PresetSavedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 889;
       
      
      private var _isInitialized:Boolean = false;
      
      public var presetId:int = 0;
      
      public var preset:Preset;
      
      private var _presettree:FuncTree;
      
      public function PresetSavedMessage()
      {
         this.preset = new Preset();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 889;
      }
      
      public function initPresetSavedMessage(presetId:int = 0, preset:Preset = null) : PresetSavedMessage
      {
         this.presetId = presetId;
         this.preset = preset;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.presetId = 0;
         this.preset = new Preset();
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
         this.serializeAs_PresetSavedMessage(output);
      }
      
      public function serializeAs_PresetSavedMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.presetId);
         output.writeShort(this.preset.getTypeId());
         this.preset.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PresetSavedMessage(input);
      }
      
      public function deserializeAs_PresetSavedMessage(input:ICustomDataInput) : void
      {
         this._presetIdFunc(input);
         var _id2:uint = input.readUnsignedShort();
         this.preset = ProtocolTypeManager.getInstance(Preset,_id2);
         this.preset.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PresetSavedMessage(tree);
      }
      
      public function deserializeAsyncAs_PresetSavedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._presetIdFunc);
         this._presettree = tree.addChild(this._presettreeFunc);
      }
      
      private function _presetIdFunc(input:ICustomDataInput) : void
      {
         this.presetId = input.readShort();
      }
      
      private function _presettreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.preset = ProtocolTypeManager.getInstance(Preset,_id);
         this.preset.deserializeAsync(this._presettree);
      }
   }
}
