package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildFightPlayersEnemiesListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 881;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightId:Number = 0;
      
      public var playerInfo:Vector.<CharacterMinimalPlusLookInformations>;
      
      private var _playerInfotree:FuncTree;
      
      public function GuildFightPlayersEnemiesListMessage()
      {
         this.playerInfo = new Vector.<CharacterMinimalPlusLookInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 881;
      }
      
      public function initGuildFightPlayersEnemiesListMessage(fightId:Number = 0, playerInfo:Vector.<CharacterMinimalPlusLookInformations> = null) : GuildFightPlayersEnemiesListMessage
      {
         this.fightId = fightId;
         this.playerInfo = playerInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
         this.playerInfo = new Vector.<CharacterMinimalPlusLookInformations>();
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
         this.serializeAs_GuildFightPlayersEnemiesListMessage(output);
      }
      
      public function serializeAs_GuildFightPlayersEnemiesListMessage(output:ICustomDataOutput) : void
      {
         if(this.fightId < 0 || this.fightId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeDouble(this.fightId);
         output.writeShort(this.playerInfo.length);
         for(var _i2:uint = 0; _i2 < this.playerInfo.length; _i2++)
         {
            (this.playerInfo[_i2] as CharacterMinimalPlusLookInformations).serializeAs_CharacterMinimalPlusLookInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildFightPlayersEnemiesListMessage(input);
      }
      
      public function deserializeAs_GuildFightPlayersEnemiesListMessage(input:ICustomDataInput) : void
      {
         var _item2:CharacterMinimalPlusLookInformations = null;
         this._fightIdFunc(input);
         var _playerInfoLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _playerInfoLen; _i2++)
         {
            _item2 = new CharacterMinimalPlusLookInformations();
            _item2.deserialize(input);
            this.playerInfo.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildFightPlayersEnemiesListMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildFightPlayersEnemiesListMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         this._playerInfotree = tree.addChild(this._playerInfotreeFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readDouble();
         if(this.fightId < 0 || this.fightId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GuildFightPlayersEnemiesListMessage.fightId.");
         }
      }
      
      private function _playerInfotreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._playerInfotree.addChild(this._playerInfoFunc);
         }
      }
      
      private function _playerInfoFunc(input:ICustomDataInput) : void
      {
         var _item:CharacterMinimalPlusLookInformations = new CharacterMinimalPlusLookInformations();
         _item.deserialize(input);
         this.playerInfo.push(_item);
      }
   }
}
