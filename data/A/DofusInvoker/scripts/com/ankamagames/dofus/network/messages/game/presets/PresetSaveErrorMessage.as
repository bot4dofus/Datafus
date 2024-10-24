package com.ankamagames.dofus.network.messages.game.presets
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PresetSaveErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7630;
       
      
      private var _isInitialized:Boolean = false;
      
      public var presetId:int = 0;
      
      public var code:uint = 2;
      
      public function PresetSaveErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7630;
      }
      
      public function initPresetSaveErrorMessage(presetId:int = 0, code:uint = 2) : PresetSaveErrorMessage
      {
         this.presetId = presetId;
         this.code = code;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.presetId = 0;
         this.code = 2;
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
         this.serializeAs_PresetSaveErrorMessage(output);
      }
      
      public function serializeAs_PresetSaveErrorMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.presetId);
         output.writeByte(this.code);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PresetSaveErrorMessage(input);
      }
      
      public function deserializeAs_PresetSaveErrorMessage(input:ICustomDataInput) : void
      {
         this._presetIdFunc(input);
         this._codeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PresetSaveErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_PresetSaveErrorMessage(tree:FuncTree) : void
      {
         tree.addChild(this._presetIdFunc);
         tree.addChild(this._codeFunc);
      }
      
      private function _presetIdFunc(input:ICustomDataInput) : void
      {
         this.presetId = input.readShort();
      }
      
      private function _codeFunc(input:ICustomDataInput) : void
      {
         this.code = input.readByte();
         if(this.code < 0)
         {
            throw new Error("Forbidden value (" + this.code + ") on element of PresetSaveErrorMessage.code.");
         }
      }
   }
}
