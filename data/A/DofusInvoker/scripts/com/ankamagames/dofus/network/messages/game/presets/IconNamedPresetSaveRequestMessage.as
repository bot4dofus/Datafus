package com.ankamagames.dofus.network.messages.game.presets
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IconNamedPresetSaveRequestMessage extends IconPresetSaveRequestMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6922;
       
      
      private var _isInitialized:Boolean = false;
      
      public var name:String = "";
      
      public var type:uint = 0;
      
      public function IconNamedPresetSaveRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6922;
      }
      
      public function initIconNamedPresetSaveRequestMessage(presetId:int = 0, symbolId:uint = 0, updateData:Boolean = false, name:String = "", type:uint = 0) : IconNamedPresetSaveRequestMessage
      {
         super.initIconPresetSaveRequestMessage(presetId,symbolId,updateData);
         this.name = name;
         this.type = type;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.name = "";
         this.type = 0;
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
         this.serializeAs_IconNamedPresetSaveRequestMessage(output);
      }
      
      public function serializeAs_IconNamedPresetSaveRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_IconPresetSaveRequestMessage(output);
         output.writeUTF(this.name);
         output.writeByte(this.type);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IconNamedPresetSaveRequestMessage(input);
      }
      
      public function deserializeAs_IconNamedPresetSaveRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._nameFunc(input);
         this._typeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IconNamedPresetSaveRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_IconNamedPresetSaveRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nameFunc);
         tree.addChild(this._typeFunc);
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of IconNamedPresetSaveRequestMessage.type.");
         }
      }
   }
}
