package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.DungeonPartyFinderPlayer;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class DungeonPartyFinderRoomContentMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1307;
       
      
      private var _isInitialized:Boolean = false;
      
      public var dungeonId:uint = 0;
      
      public var players:Vector.<DungeonPartyFinderPlayer>;
      
      private var _playerstree:FuncTree;
      
      public function DungeonPartyFinderRoomContentMessage()
      {
         this.players = new Vector.<DungeonPartyFinderPlayer>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1307;
      }
      
      public function initDungeonPartyFinderRoomContentMessage(dungeonId:uint = 0, players:Vector.<DungeonPartyFinderPlayer> = null) : DungeonPartyFinderRoomContentMessage
      {
         this.dungeonId = dungeonId;
         this.players = players;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.dungeonId = 0;
         this.players = new Vector.<DungeonPartyFinderPlayer>();
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
         this.serializeAs_DungeonPartyFinderRoomContentMessage(output);
      }
      
      public function serializeAs_DungeonPartyFinderRoomContentMessage(output:ICustomDataOutput) : void
      {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         output.writeVarShort(this.dungeonId);
         output.writeShort(this.players.length);
         for(var _i2:uint = 0; _i2 < this.players.length; _i2++)
         {
            (this.players[_i2] as DungeonPartyFinderPlayer).serializeAs_DungeonPartyFinderPlayer(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DungeonPartyFinderRoomContentMessage(input);
      }
      
      public function deserializeAs_DungeonPartyFinderRoomContentMessage(input:ICustomDataInput) : void
      {
         var _item2:DungeonPartyFinderPlayer = null;
         this._dungeonIdFunc(input);
         var _playersLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _playersLen; _i2++)
         {
            _item2 = new DungeonPartyFinderPlayer();
            _item2.deserialize(input);
            this.players.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DungeonPartyFinderRoomContentMessage(tree);
      }
      
      public function deserializeAsyncAs_DungeonPartyFinderRoomContentMessage(tree:FuncTree) : void
      {
         tree.addChild(this._dungeonIdFunc);
         this._playerstree = tree.addChild(this._playerstreeFunc);
      }
      
      private function _dungeonIdFunc(input:ICustomDataInput) : void
      {
         this.dungeonId = input.readVarUhShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of DungeonPartyFinderRoomContentMessage.dungeonId.");
         }
      }
      
      private function _playerstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._playerstree.addChild(this._playersFunc);
         }
      }
      
      private function _playersFunc(input:ICustomDataInput) : void
      {
         var _item:DungeonPartyFinderPlayer = new DungeonPartyFinderPlayer();
         _item.deserialize(input);
         this.players.push(_item);
      }
   }
}
