package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.fight.arena.ArenaRankInfos;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayArenaUpdatePlayerInfosMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1665;
       
      
      private var _isInitialized:Boolean = false;
      
      public var arenaRanks:Vector.<ArenaRankInfos>;
      
      public var banEndDate:Number = 0;
      
      private var _arenaRankstree:FuncTree;
      
      public function GameRolePlayArenaUpdatePlayerInfosMessage()
      {
         this.arenaRanks = new Vector.<ArenaRankInfos>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1665;
      }
      
      public function initGameRolePlayArenaUpdatePlayerInfosMessage(arenaRanks:Vector.<ArenaRankInfos> = null, banEndDate:Number = 0) : GameRolePlayArenaUpdatePlayerInfosMessage
      {
         this.arenaRanks = arenaRanks;
         this.banEndDate = banEndDate;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.arenaRanks = new Vector.<ArenaRankInfos>();
         this.banEndDate = 0;
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
         this.serializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.arenaRanks.length);
         for(var _i1:uint = 0; _i1 < this.arenaRanks.length; _i1++)
         {
            (this.arenaRanks[_i1] as ArenaRankInfos).serializeAs_ArenaRankInfos(output);
         }
         if(this.banEndDate < -9007199254740992 || this.banEndDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.banEndDate + ") on element banEndDate.");
         }
         output.writeDouble(this.banEndDate);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(input:ICustomDataInput) : void
      {
         var _item1:ArenaRankInfos = null;
         var _arenaRanksLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _arenaRanksLen; _i1++)
         {
            _item1 = new ArenaRankInfos();
            _item1.deserialize(input);
            this.arenaRanks.push(_item1);
         }
         this._banEndDateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayArenaUpdatePlayerInfosMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayArenaUpdatePlayerInfosMessage(tree:FuncTree) : void
      {
         this._arenaRankstree = tree.addChild(this._arenaRankstreeFunc);
         tree.addChild(this._banEndDateFunc);
      }
      
      private function _arenaRankstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._arenaRankstree.addChild(this._arenaRanksFunc);
         }
      }
      
      private function _arenaRanksFunc(input:ICustomDataInput) : void
      {
         var _item:ArenaRankInfos = new ArenaRankInfos();
         _item.deserialize(input);
         this.arenaRanks.push(_item);
      }
      
      private function _banEndDateFunc(input:ICustomDataInput) : void
      {
         this.banEndDate = input.readDouble();
         if(this.banEndDate < -9007199254740992 || this.banEndDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.banEndDate + ") on element of GameRolePlayArenaUpdatePlayerInfosMessage.banEndDate.");
         }
      }
   }
}
