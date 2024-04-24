package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GroupMonsterStaticInformationsWithAlternatives extends GroupMonsterStaticInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7716;
       
      
      public var alternatives:Vector.<AlternativeMonstersInGroupLightInformations>;
      
      private var _alternativestree:FuncTree;
      
      public function GroupMonsterStaticInformationsWithAlternatives()
      {
         this.alternatives = new Vector.<AlternativeMonstersInGroupLightInformations>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7716;
      }
      
      public function initGroupMonsterStaticInformationsWithAlternatives(mainCreatureLightInfos:MonsterInGroupLightInformations = null, underlings:Vector.<MonsterInGroupInformations> = null, alternatives:Vector.<AlternativeMonstersInGroupLightInformations> = null) : GroupMonsterStaticInformationsWithAlternatives
      {
         super.initGroupMonsterStaticInformations(mainCreatureLightInfos,underlings);
         this.alternatives = alternatives;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.alternatives = new Vector.<AlternativeMonstersInGroupLightInformations>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GroupMonsterStaticInformationsWithAlternatives(output);
      }
      
      public function serializeAs_GroupMonsterStaticInformationsWithAlternatives(output:ICustomDataOutput) : void
      {
         super.serializeAs_GroupMonsterStaticInformations(output);
         output.writeShort(this.alternatives.length);
         for(var _i1:uint = 0; _i1 < this.alternatives.length; _i1++)
         {
            (this.alternatives[_i1] as AlternativeMonstersInGroupLightInformations).serializeAs_AlternativeMonstersInGroupLightInformations(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GroupMonsterStaticInformationsWithAlternatives(input);
      }
      
      public function deserializeAs_GroupMonsterStaticInformationsWithAlternatives(input:ICustomDataInput) : void
      {
         var _item1:AlternativeMonstersInGroupLightInformations = null;
         super.deserialize(input);
         var _alternativesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _alternativesLen; _i1++)
         {
            _item1 = new AlternativeMonstersInGroupLightInformations();
            _item1.deserialize(input);
            this.alternatives.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GroupMonsterStaticInformationsWithAlternatives(tree);
      }
      
      public function deserializeAsyncAs_GroupMonsterStaticInformationsWithAlternatives(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._alternativestree = tree.addChild(this._alternativestreeFunc);
      }
      
      private function _alternativestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._alternativestree.addChild(this._alternativesFunc);
         }
      }
      
      private function _alternativesFunc(input:ICustomDataInput) : void
      {
         var _item:AlternativeMonstersInGroupLightInformations = new AlternativeMonstersInGroupLightInformations();
         _item.deserialize(input);
         this.alternatives.push(_item);
      }
   }
}
