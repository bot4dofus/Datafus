package com.ankamagames.dofus.network.types.game.presets
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FullStatsPreset extends Preset implements INetworkType
   {
      
      public static const protocolId:uint = 7800;
       
      
      public var stats:Vector.<CharacterCharacteristicForPreset>;
      
      private var _statstree:FuncTree;
      
      public function FullStatsPreset()
      {
         this.stats = new Vector.<CharacterCharacteristicForPreset>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7800;
      }
      
      public function initFullStatsPreset(id:int = 0, stats:Vector.<CharacterCharacteristicForPreset> = null) : FullStatsPreset
      {
         super.initPreset(id);
         this.stats = stats;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.stats = new Vector.<CharacterCharacteristicForPreset>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FullStatsPreset(output);
      }
      
      public function serializeAs_FullStatsPreset(output:ICustomDataOutput) : void
      {
         super.serializeAs_Preset(output);
         output.writeShort(this.stats.length);
         for(var _i1:uint = 0; _i1 < this.stats.length; _i1++)
         {
            (this.stats[_i1] as CharacterCharacteristicForPreset).serializeAs_CharacterCharacteristicForPreset(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FullStatsPreset(input);
      }
      
      public function deserializeAs_FullStatsPreset(input:ICustomDataInput) : void
      {
         var _item1:CharacterCharacteristicForPreset = null;
         super.deserialize(input);
         var _statsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _statsLen; _i1++)
         {
            _item1 = new CharacterCharacteristicForPreset();
            _item1.deserialize(input);
            this.stats.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FullStatsPreset(tree);
      }
      
      public function deserializeAsyncAs_FullStatsPreset(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._statstree = tree.addChild(this._statstreeFunc);
      }
      
      private function _statstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._statstree.addChild(this._statsFunc);
         }
      }
      
      private function _statsFunc(input:ICustomDataInput) : void
      {
         var _item:CharacterCharacteristicForPreset = new CharacterCharacteristicForPreset();
         _item.deserialize(input);
         this.stats.push(_item);
      }
   }
}
