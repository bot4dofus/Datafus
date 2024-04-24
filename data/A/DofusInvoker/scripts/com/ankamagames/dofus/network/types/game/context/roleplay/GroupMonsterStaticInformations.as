package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GroupMonsterStaticInformations implements INetworkType
   {
      
      public static const protocolId:uint = 1952;
       
      
      public var mainCreatureLightInfos:MonsterInGroupLightInformations;
      
      public var underlings:Vector.<MonsterInGroupInformations>;
      
      private var _mainCreatureLightInfostree:FuncTree;
      
      private var _underlingstree:FuncTree;
      
      public function GroupMonsterStaticInformations()
      {
         this.mainCreatureLightInfos = new MonsterInGroupLightInformations();
         this.underlings = new Vector.<MonsterInGroupInformations>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1952;
      }
      
      public function initGroupMonsterStaticInformations(mainCreatureLightInfos:MonsterInGroupLightInformations = null, underlings:Vector.<MonsterInGroupInformations> = null) : GroupMonsterStaticInformations
      {
         this.mainCreatureLightInfos = mainCreatureLightInfos;
         this.underlings = underlings;
         return this;
      }
      
      public function reset() : void
      {
         this.mainCreatureLightInfos = new MonsterInGroupLightInformations();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GroupMonsterStaticInformations(output);
      }
      
      public function serializeAs_GroupMonsterStaticInformations(output:ICustomDataOutput) : void
      {
         this.mainCreatureLightInfos.serializeAs_MonsterInGroupLightInformations(output);
         output.writeShort(this.underlings.length);
         for(var _i2:uint = 0; _i2 < this.underlings.length; _i2++)
         {
            (this.underlings[_i2] as MonsterInGroupInformations).serializeAs_MonsterInGroupInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GroupMonsterStaticInformations(input);
      }
      
      public function deserializeAs_GroupMonsterStaticInformations(input:ICustomDataInput) : void
      {
         var _item2:MonsterInGroupInformations = null;
         this.mainCreatureLightInfos = new MonsterInGroupLightInformations();
         this.mainCreatureLightInfos.deserialize(input);
         var _underlingsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _underlingsLen; _i2++)
         {
            _item2 = new MonsterInGroupInformations();
            _item2.deserialize(input);
            this.underlings.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GroupMonsterStaticInformations(tree);
      }
      
      public function deserializeAsyncAs_GroupMonsterStaticInformations(tree:FuncTree) : void
      {
         this._mainCreatureLightInfostree = tree.addChild(this._mainCreatureLightInfostreeFunc);
         this._underlingstree = tree.addChild(this._underlingstreeFunc);
      }
      
      private function _mainCreatureLightInfostreeFunc(input:ICustomDataInput) : void
      {
         this.mainCreatureLightInfos = new MonsterInGroupLightInformations();
         this.mainCreatureLightInfos.deserializeAsync(this._mainCreatureLightInfostree);
      }
      
      private function _underlingstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._underlingstree.addChild(this._underlingsFunc);
         }
      }
      
      private function _underlingsFunc(input:ICustomDataInput) : void
      {
         var _item:MonsterInGroupInformations = new MonsterInGroupInformations();
         _item.deserialize(input);
         this.underlings.push(_item);
      }
   }
}
