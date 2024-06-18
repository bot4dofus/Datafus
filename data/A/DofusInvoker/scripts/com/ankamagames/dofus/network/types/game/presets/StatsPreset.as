package com.ankamagames.dofus.network.types.game.presets
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class StatsPreset extends Preset implements INetworkType
   {
      
      public static const protocolId:uint = 1993;
       
      
      public var stats:Vector.<SimpleCharacterCharacteristicForPreset>;
      
      private var _statstree:FuncTree;
      
      public function StatsPreset()
      {
         this.stats = new Vector.<SimpleCharacterCharacteristicForPreset>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1993;
      }
      
      public function initStatsPreset(id:int = 0, stats:Vector.<SimpleCharacterCharacteristicForPreset> = null) : StatsPreset
      {
         super.initPreset(id);
         this.stats = stats;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.stats = new Vector.<SimpleCharacterCharacteristicForPreset>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_StatsPreset(output);
      }
      
      public function serializeAs_StatsPreset(output:ICustomDataOutput) : void
      {
         super.serializeAs_Preset(output);
         output.writeShort(this.stats.length);
         for(var _i1:uint = 0; _i1 < this.stats.length; _i1++)
         {
            (this.stats[_i1] as SimpleCharacterCharacteristicForPreset).serializeAs_SimpleCharacterCharacteristicForPreset(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StatsPreset(input);
      }
      
      public function deserializeAs_StatsPreset(input:ICustomDataInput) : void
      {
         var _item1:SimpleCharacterCharacteristicForPreset = null;
         super.deserialize(input);
         var _statsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _statsLen; _i1++)
         {
            _item1 = new SimpleCharacterCharacteristicForPreset();
            _item1.deserialize(input);
            this.stats.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StatsPreset(tree);
      }
      
      public function deserializeAsyncAs_StatsPreset(tree:FuncTree) : void
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
         var _item:SimpleCharacterCharacteristicForPreset = new SimpleCharacterCharacteristicForPreset();
         _item.deserialize(input);
         this.stats.push(_item);
      }
   }
}
