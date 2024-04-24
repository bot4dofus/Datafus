package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AlternativeMonstersInGroupLightInformations implements INetworkType
   {
      
      public static const protocolId:uint = 494;
       
      
      public var playerCount:int = 0;
      
      public var monsters:Vector.<MonsterInGroupLightInformations>;
      
      private var _monsterstree:FuncTree;
      
      public function AlternativeMonstersInGroupLightInformations()
      {
         this.monsters = new Vector.<MonsterInGroupLightInformations>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 494;
      }
      
      public function initAlternativeMonstersInGroupLightInformations(playerCount:int = 0, monsters:Vector.<MonsterInGroupLightInformations> = null) : AlternativeMonstersInGroupLightInformations
      {
         this.playerCount = playerCount;
         this.monsters = monsters;
         return this;
      }
      
      public function reset() : void
      {
         this.playerCount = 0;
         this.monsters = new Vector.<MonsterInGroupLightInformations>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AlternativeMonstersInGroupLightInformations(output);
      }
      
      public function serializeAs_AlternativeMonstersInGroupLightInformations(output:ICustomDataOutput) : void
      {
         output.writeInt(this.playerCount);
         output.writeShort(this.monsters.length);
         for(var _i2:uint = 0; _i2 < this.monsters.length; _i2++)
         {
            (this.monsters[_i2] as MonsterInGroupLightInformations).serializeAs_MonsterInGroupLightInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AlternativeMonstersInGroupLightInformations(input);
      }
      
      public function deserializeAs_AlternativeMonstersInGroupLightInformations(input:ICustomDataInput) : void
      {
         var _item2:MonsterInGroupLightInformations = null;
         this._playerCountFunc(input);
         var _monstersLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _monstersLen; _i2++)
         {
            _item2 = new MonsterInGroupLightInformations();
            _item2.deserialize(input);
            this.monsters.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AlternativeMonstersInGroupLightInformations(tree);
      }
      
      public function deserializeAsyncAs_AlternativeMonstersInGroupLightInformations(tree:FuncTree) : void
      {
         tree.addChild(this._playerCountFunc);
         this._monsterstree = tree.addChild(this._monsterstreeFunc);
      }
      
      private function _playerCountFunc(input:ICustomDataInput) : void
      {
         this.playerCount = input.readInt();
      }
      
      private function _monsterstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._monsterstree.addChild(this._monstersFunc);
         }
      }
      
      private function _monstersFunc(input:ICustomDataInput) : void
      {
         var _item:MonsterInGroupLightInformations = new MonsterInGroupLightInformations();
         _item.deserialize(input);
         this.monsters.push(_item);
      }
   }
}
