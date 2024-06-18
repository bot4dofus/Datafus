package com.ankamagames.dofus.network.types.game.presets
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PresetsContainerPreset extends Preset implements INetworkType
   {
      
      public static const protocolId:uint = 5695;
       
      
      public var presets:Vector.<Preset>;
      
      private var _presetstree:FuncTree;
      
      public function PresetsContainerPreset()
      {
         this.presets = new Vector.<Preset>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5695;
      }
      
      public function initPresetsContainerPreset(id:int = 0, presets:Vector.<Preset> = null) : PresetsContainerPreset
      {
         super.initPreset(id);
         this.presets = presets;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.presets = new Vector.<Preset>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PresetsContainerPreset(output);
      }
      
      public function serializeAs_PresetsContainerPreset(output:ICustomDataOutput) : void
      {
         super.serializeAs_Preset(output);
         output.writeShort(this.presets.length);
         for(var _i1:uint = 0; _i1 < this.presets.length; _i1++)
         {
            output.writeShort((this.presets[_i1] as Preset).getTypeId());
            (this.presets[_i1] as Preset).serialize(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PresetsContainerPreset(input);
      }
      
      public function deserializeAs_PresetsContainerPreset(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:Preset = null;
         super.deserialize(input);
         var _presetsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _presetsLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(Preset,_id1);
            _item1.deserialize(input);
            this.presets.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PresetsContainerPreset(tree);
      }
      
      public function deserializeAsyncAs_PresetsContainerPreset(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
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
