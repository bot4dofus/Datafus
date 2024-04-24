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
   
   public class PresetsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8776;
       
      
      private var _isInitialized:Boolean = false;
      
      public var presets:Vector.<Preset>;
      
      private var _presetstree:FuncTree;
      
      public function PresetsMessage()
      {
         this.presets = new Vector.<Preset>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8776;
      }
      
      public function initPresetsMessage(presets:Vector.<Preset> = null) : PresetsMessage
      {
         this.presets = presets;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.presets = new Vector.<Preset>();
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
         this.serializeAs_PresetsMessage(output);
      }
      
      public function serializeAs_PresetsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.presets.length);
         for(var _i1:uint = 0; _i1 < this.presets.length; _i1++)
         {
            output.writeShort((this.presets[_i1] as Preset).getTypeId());
            (this.presets[_i1] as Preset).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PresetsMessage(input);
      }
      
      public function deserializeAs_PresetsMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:Preset = null;
         var _presetsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _presetsLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(Preset,_id1);
            _item1.deserialize(input);
            this.presets.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PresetsMessage(tree);
      }
      
      public function deserializeAsyncAs_PresetsMessage(tree:FuncTree) : void
      {
         this._presetstree = tree.addChild(this._presetstreeFunc);
      }
      
      private function _presetstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._presetstree.addChild(this._presetsFunc);
         }
      }
      
      private function _presetsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:Preset = ProtocolTypeManager.getInstance(Preset,_id);
         _item.deserialize(input);
         this.presets.push(_item);
      }
   }
}
