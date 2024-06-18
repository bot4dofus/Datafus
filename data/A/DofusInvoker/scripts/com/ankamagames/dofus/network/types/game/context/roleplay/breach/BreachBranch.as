package com.ankamagames.dofus.network.types.game.context.roleplay.breach
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class BreachBranch implements INetworkType
   {
      
      public static const protocolId:uint = 7507;
       
      
      public var room:uint = 0;
      
      public var element:uint = 0;
      
      public var bosses:Vector.<MonsterInGroupLightInformations>;
      
      public var map:Number = 0;
      
      public var score:int = 0;
      
      public var relativeScore:int = 0;
      
      public var monsters:Vector.<MonsterInGroupLightInformations>;
      
      private var _bossestree:FuncTree;
      
      private var _monsterstree:FuncTree;
      
      public function BreachBranch()
      {
         this.bosses = new Vector.<MonsterInGroupLightInformations>();
         this.monsters = new Vector.<MonsterInGroupLightInformations>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7507;
      }
      
      public function initBreachBranch(room:uint = 0, element:uint = 0, bosses:Vector.<MonsterInGroupLightInformations> = null, map:Number = 0, score:int = 0, relativeScore:int = 0, monsters:Vector.<MonsterInGroupLightInformations> = null) : BreachBranch
      {
         this.room = room;
         this.element = element;
         this.bosses = bosses;
         this.map = map;
         this.score = score;
         this.relativeScore = relativeScore;
         this.monsters = monsters;
         return this;
      }
      
      public function reset() : void
      {
         this.room = 0;
         this.element = 0;
         this.bosses = new Vector.<MonsterInGroupLightInformations>();
         this.map = 0;
         this.score = 0;
         this.relativeScore = 0;
         this.monsters = new Vector.<MonsterInGroupLightInformations>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_BreachBranch(output);
      }
      
      public function serializeAs_BreachBranch(output:ICustomDataOutput) : void
      {
         if(this.room < 0)
         {
            throw new Error("Forbidden value (" + this.room + ") on element room.");
         }
         output.writeByte(this.room);
         if(this.element < 0)
         {
            throw new Error("Forbidden value (" + this.element + ") on element element.");
         }
         output.writeInt(this.element);
         output.writeShort(this.bosses.length);
         for(var _i3:uint = 0; _i3 < this.bosses.length; _i3++)
         {
            (this.bosses[_i3] as MonsterInGroupLightInformations).serializeAs_MonsterInGroupLightInformations(output);
         }
         if(this.map < 0 || this.map > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.map + ") on element map.");
         }
         output.writeDouble(this.map);
         output.writeShort(this.score);
         output.writeShort(this.relativeScore);
         output.writeShort(this.monsters.length);
         for(var _i7:uint = 0; _i7 < this.monsters.length; _i7++)
         {
            (this.monsters[_i7] as MonsterInGroupLightInformations).serializeAs_MonsterInGroupLightInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachBranch(input);
      }
      
      public function deserializeAs_BreachBranch(input:ICustomDataInput) : void
      {
         var _item3:MonsterInGroupLightInformations = null;
         var _item7:MonsterInGroupLightInformations = null;
         this._roomFunc(input);
         this._elementFunc(input);
         var _bossesLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _bossesLen; _i3++)
         {
            _item3 = new MonsterInGroupLightInformations();
            _item3.deserialize(input);
            this.bosses.push(_item3);
         }
         this._mapFunc(input);
         this._scoreFunc(input);
         this._relativeScoreFunc(input);
         var _monstersLen:uint = input.readUnsignedShort();
         for(var _i7:uint = 0; _i7 < _monstersLen; _i7++)
         {
            _item7 = new MonsterInGroupLightInformations();
            _item7.deserialize(input);
            this.monsters.push(_item7);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachBranch(tree);
      }
      
      public function deserializeAsyncAs_BreachBranch(tree:FuncTree) : void
      {
         tree.addChild(this._roomFunc);
         tree.addChild(this._elementFunc);
         this._bossestree = tree.addChild(this._bossestreeFunc);
         tree.addChild(this._mapFunc);
         tree.addChild(this._scoreFunc);
         tree.addChild(this._relativeScoreFunc);
         this._monsterstree = tree.addChild(this._monsterstreeFunc);
      }
      
      private function _roomFunc(input:ICustomDataInput) : void
      {
         this.room = input.readByte();
         if(this.room < 0)
         {
            throw new Error("Forbidden value (" + this.room + ") on element of BreachBranch.room.");
         }
      }
      
      private function _elementFunc(input:ICustomDataInput) : void
      {
         this.element = input.readInt();
         if(this.element < 0)
         {
            throw new Error("Forbidden value (" + this.element + ") on element of BreachBranch.element.");
         }
      }
      
      private function _bossestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._bossestree.addChild(this._bossesFunc);
         }
      }
      
      private function _bossesFunc(input:ICustomDataInput) : void
      {
         var _item:MonsterInGroupLightInformations = new MonsterInGroupLightInformations();
         _item.deserialize(input);
         this.bosses.push(_item);
      }
      
      private function _mapFunc(input:ICustomDataInput) : void
      {
         this.map = input.readDouble();
         if(this.map < 0 || this.map > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.map + ") on element of BreachBranch.map.");
         }
      }
      
      private function _scoreFunc(input:ICustomDataInput) : void
      {
         this.score = input.readShort();
      }
      
      private function _relativeScoreFunc(input:ICustomDataInput) : void
      {
         this.relativeScore = input.readShort();
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
