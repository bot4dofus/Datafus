package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterBoosts;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRefreshMonsterBoostsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3014;
       
      
      private var _isInitialized:Boolean = false;
      
      public var monsterBoosts:Vector.<MonsterBoosts>;
      
      public var familyBoosts:Vector.<MonsterBoosts>;
      
      private var _monsterBooststree:FuncTree;
      
      private var _familyBooststree:FuncTree;
      
      public function GameRefreshMonsterBoostsMessage()
      {
         this.monsterBoosts = new Vector.<MonsterBoosts>();
         this.familyBoosts = new Vector.<MonsterBoosts>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3014;
      }
      
      public function initGameRefreshMonsterBoostsMessage(monsterBoosts:Vector.<MonsterBoosts> = null, familyBoosts:Vector.<MonsterBoosts> = null) : GameRefreshMonsterBoostsMessage
      {
         this.monsterBoosts = monsterBoosts;
         this.familyBoosts = familyBoosts;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.monsterBoosts = new Vector.<MonsterBoosts>();
         this.familyBoosts = new Vector.<MonsterBoosts>();
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
         this.serializeAs_GameRefreshMonsterBoostsMessage(output);
      }
      
      public function serializeAs_GameRefreshMonsterBoostsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.monsterBoosts.length);
         for(var _i1:uint = 0; _i1 < this.monsterBoosts.length; _i1++)
         {
            (this.monsterBoosts[_i1] as MonsterBoosts).serializeAs_MonsterBoosts(output);
         }
         output.writeShort(this.familyBoosts.length);
         for(var _i2:uint = 0; _i2 < this.familyBoosts.length; _i2++)
         {
            (this.familyBoosts[_i2] as MonsterBoosts).serializeAs_MonsterBoosts(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRefreshMonsterBoostsMessage(input);
      }
      
      public function deserializeAs_GameRefreshMonsterBoostsMessage(input:ICustomDataInput) : void
      {
         var _item1:MonsterBoosts = null;
         var _item2:MonsterBoosts = null;
         var _monsterBoostsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _monsterBoostsLen; _i1++)
         {
            _item1 = new MonsterBoosts();
            _item1.deserialize(input);
            this.monsterBoosts.push(_item1);
         }
         var _familyBoostsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _familyBoostsLen; _i2++)
         {
            _item2 = new MonsterBoosts();
            _item2.deserialize(input);
            this.familyBoosts.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRefreshMonsterBoostsMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRefreshMonsterBoostsMessage(tree:FuncTree) : void
      {
         this._monsterBooststree = tree.addChild(this._monsterBooststreeFunc);
         this._familyBooststree = tree.addChild(this._familyBooststreeFunc);
      }
      
      private function _monsterBooststreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._monsterBooststree.addChild(this._monsterBoostsFunc);
         }
      }
      
      private function _monsterBoostsFunc(input:ICustomDataInput) : void
      {
         var _item:MonsterBoosts = new MonsterBoosts();
         _item.deserialize(input);
         this.monsterBoosts.push(_item);
      }
      
      private function _familyBooststreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._familyBooststree.addChild(this._familyBoostsFunc);
         }
      }
      
      private function _familyBoostsFunc(input:ICustomDataInput) : void
      {
         var _item:MonsterBoosts = new MonsterBoosts();
         _item.deserialize(input);
         this.familyBoosts.push(_item);
      }
   }
}
