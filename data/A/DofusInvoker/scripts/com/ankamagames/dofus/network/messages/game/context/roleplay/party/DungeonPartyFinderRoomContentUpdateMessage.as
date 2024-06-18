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
   
   public class DungeonPartyFinderRoomContentUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5056;
       
      
      private var _isInitialized:Boolean = false;
      
      public var dungeonId:uint = 0;
      
      public var addedPlayers:Vector.<DungeonPartyFinderPlayer>;
      
      public var removedPlayersIds:Vector.<Number>;
      
      private var _addedPlayerstree:FuncTree;
      
      private var _removedPlayersIdstree:FuncTree;
      
      public function DungeonPartyFinderRoomContentUpdateMessage()
      {
         this.addedPlayers = new Vector.<DungeonPartyFinderPlayer>();
         this.removedPlayersIds = new Vector.<Number>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5056;
      }
      
      public function initDungeonPartyFinderRoomContentUpdateMessage(dungeonId:uint = 0, addedPlayers:Vector.<DungeonPartyFinderPlayer> = null, removedPlayersIds:Vector.<Number> = null) : DungeonPartyFinderRoomContentUpdateMessage
      {
         this.dungeonId = dungeonId;
         this.addedPlayers = addedPlayers;
         this.removedPlayersIds = removedPlayersIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.dungeonId = 0;
         this.addedPlayers = new Vector.<DungeonPartyFinderPlayer>();
         this.removedPlayersIds = new Vector.<Number>();
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
         this.serializeAs_DungeonPartyFinderRoomContentUpdateMessage(output);
      }
      
      public function serializeAs_DungeonPartyFinderRoomContentUpdateMessage(output:ICustomDataOutput) : void
      {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         output.writeVarShort(this.dungeonId);
         output.writeShort(this.addedPlayers.length);
         for(var _i2:uint = 0; _i2 < this.addedPlayers.length; _i2++)
         {
            (this.addedPlayers[_i2] as DungeonPartyFinderPlayer).serializeAs_DungeonPartyFinderPlayer(output);
         }
         output.writeShort(this.removedPlayersIds.length);
         for(var _i3:uint = 0; _i3 < this.removedPlayersIds.length; _i3++)
         {
            if(this.removedPlayersIds[_i3] < 0 || this.removedPlayersIds[_i3] > 9007199254740992)
            {
               throw new Error("Forbidden value (" + this.removedPlayersIds[_i3] + ") on element 3 (starting at 1) of removedPlayersIds.");
            }
            output.writeVarLong(this.removedPlayersIds[_i3]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DungeonPartyFinderRoomContentUpdateMessage(input);
      }
      
      public function deserializeAs_DungeonPartyFinderRoomContentUpdateMessage(input:ICustomDataInput) : void
      {
         var _item2:DungeonPartyFinderPlayer = null;
         var _val3:Number = NaN;
         this._dungeonIdFunc(input);
         var _addedPlayersLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _addedPlayersLen; _i2++)
         {
            _item2 = new DungeonPartyFinderPlayer();
            _item2.deserialize(input);
            this.addedPlayers.push(_item2);
         }
         var _removedPlayersIdsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _removedPlayersIdsLen; _i3++)
         {
            _val3 = input.readVarUhLong();
            if(_val3 < 0 || _val3 > 9007199254740992)
            {
               throw new Error("Forbidden value (" + _val3 + ") on elements of removedPlayersIds.");
            }
            this.removedPlayersIds.push(_val3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DungeonPartyFinderRoomContentUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_DungeonPartyFinderRoomContentUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._dungeonIdFunc);
         this._addedPlayerstree = tree.addChild(this._addedPlayerstreeFunc);
         this._removedPlayersIdstree = tree.addChild(this._removedPlayersIdstreeFunc);
      }
      
      private function _dungeonIdFunc(input:ICustomDataInput) : void
      {
         this.dungeonId = input.readVarUhShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of DungeonPartyFinderRoomContentUpdateMessage.dungeonId.");
         }
      }
      
      private function _addedPlayerstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._addedPlayerstree.addChild(this._addedPlayersFunc);
         }
      }
      
      private function _addedPlayersFunc(input:ICustomDataInput) : void
      {
         var _item:DungeonPartyFinderPlayer = new DungeonPartyFinderPlayer();
         _item.deserialize(input);
         this.addedPlayers.push(_item);
      }
      
      private function _removedPlayersIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._removedPlayersIdstree.addChild(this._removedPlayersIdsFunc);
         }
      }
      
      private function _removedPlayersIdsFunc(input:ICustomDataInput) : void
      {
         var _val:Number = input.readVarUhLong();
         if(_val < 0 || _val > 9007199254740992)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of removedPlayersIds.");
         }
         this.removedPlayersIds.push(_val);
      }
   }
}
