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
   
   public class GuildFightPlayersHelpersJoinMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5728;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightId:Number = 0;
      
      public var playerInfo:CharacterMinimalPlusLookInformations;
      
      private var _playerInfotree:FuncTree;
      
      public function GuildFightPlayersHelpersJoinMessage()
      {
         this.playerInfo = new CharacterMinimalPlusLookInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5728;
      }
      
      public function initGuildFightPlayersHelpersJoinMessage(fightId:Number = 0, playerInfo:CharacterMinimalPlusLookInformations = null) : GuildFightPlayersHelpersJoinMessage
      {
         this.fightId = fightId;
         this.playerInfo = playerInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
         this.playerInfo = new CharacterMinimalPlusLookInformations();
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
         this.serializeAs_GuildFightPlayersHelpersJoinMessage(output);
      }
      
      public function serializeAs_GuildFightPlayersHelpersJoinMessage(output:ICustomDataOutput) : void
      {
         if(this.fightId < 0 || this.fightId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeDouble(this.fightId);
         this.playerInfo.serializeAs_CharacterMinimalPlusLookInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildFightPlayersHelpersJoinMessage(input);
      }
      
      public function deserializeAs_GuildFightPlayersHelpersJoinMessage(input:ICustomDataInput) : void
      {
         this._fightIdFunc(input);
         this.playerInfo = new CharacterMinimalPlusLookInformations();
         this.playerInfo.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildFightPlayersHelpersJoinMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildFightPlayersHelpersJoinMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         this._playerInfotree = tree.addChild(this._playerInfotreeFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readDouble();
         if(this.fightId < 0 || this.fightId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GuildFightPlayersHelpersJoinMessage.fightId.");
         }
      }
      
      private function _playerInfotreeFunc(input:ICustomDataInput) : void
      {
         this.playerInfo = new CharacterMinimalPlusLookInformations();
         this.playerInfo.deserializeAsync(this._playerInfotree);
      }
   }
}
