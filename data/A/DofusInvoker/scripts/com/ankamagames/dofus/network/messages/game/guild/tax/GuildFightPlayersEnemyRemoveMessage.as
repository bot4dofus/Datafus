package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildFightPlayersEnemyRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5710;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightId:Number = 0;
      
      public var playerId:Number = 0;
      
      public function GuildFightPlayersEnemyRemoveMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5710;
      }
      
      public function initGuildFightPlayersEnemyRemoveMessage(fightId:Number = 0, playerId:Number = 0) : GuildFightPlayersEnemyRemoveMessage
      {
         this.fightId = fightId;
         this.playerId = playerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
         this.playerId = 0;
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
         this.serializeAs_GuildFightPlayersEnemyRemoveMessage(output);
      }
      
      public function serializeAs_GuildFightPlayersEnemyRemoveMessage(output:ICustomDataOutput) : void
      {
         if(this.fightId < 0 || this.fightId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeDouble(this.fightId);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildFightPlayersEnemyRemoveMessage(input);
      }
      
      public function deserializeAs_GuildFightPlayersEnemyRemoveMessage(input:ICustomDataInput) : void
      {
         this._fightIdFunc(input);
         this._playerIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildFightPlayersEnemyRemoveMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildFightPlayersEnemyRemoveMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         tree.addChild(this._playerIdFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readDouble();
         if(this.fightId < 0 || this.fightId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GuildFightPlayersEnemyRemoveMessage.fightId.");
         }
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of GuildFightPlayersEnemyRemoveMessage.playerId.");
         }
      }
   }
}
