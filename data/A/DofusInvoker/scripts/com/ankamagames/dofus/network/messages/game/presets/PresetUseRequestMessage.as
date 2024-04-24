package com.ankamagames.dofus.network.messages.game.presets
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PresetUseRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3079;
       
      
      private var _isInitialized:Boolean = false;
      
      public var presetId:int = 0;
      
      public function PresetUseRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3079;
      }
      
      public function initPresetUseRequestMessage(presetId:int = 0) : PresetUseRequestMessage
      {
         this.presetId = presetId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.presetId = 0;
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
         this.serializeAs_PresetUseRequestMessage(output);
      }
      
      public function serializeAs_PresetUseRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.presetId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PresetUseRequestMessage(input);
      }
      
      public function deserializeAs_PresetUseRequestMessage(input:ICustomDataInput) : void
      {
         this._presetIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PresetUseRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_PresetUseRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._presetIdFunc);
      }
      
      private function _presetIdFunc(input:ICustomDataInput) : void
      {
         this.presetId = input.readShort();
      }
   }
}
