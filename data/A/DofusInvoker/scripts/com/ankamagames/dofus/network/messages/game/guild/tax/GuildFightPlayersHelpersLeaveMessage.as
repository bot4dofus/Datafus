package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildFightPlayersHelpersLeaveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5912;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightId:Number = 0;
      
      public var playerId:Number = 0;
      
      public function GuildFightPlayersHelpersLeaveMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5912;
      }
      
      public function initGuildFightPlayersHelpersLeaveMessage(fightId:Number = 0, playerId:Number = 0) : GuildFightPlayersHelpersLeaveMessage
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
         this.serializeAs_GuildFightPlayersHelpersLeaveMessage(output);
      }
      
      public function serializeAs_GuildFightPlayersHelpersLeaveMessage(output:ICustomDataOutput) : void
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
         this.deserializeAs_GuildFightPlayersHelpersLeaveMessage(input);
      }
      
      public function deserializeAs_GuildFightPlayersHelpersLeaveMessage(input:ICustomDataInput) : void
      {
         this._fightIdFunc(input);
         this._playerIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildFightPlayersHelpersLeaveMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildFightPlayersHelpersLeaveMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         tree.addChild(this._playerIdFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readDouble();
         if(this.fightId < 0 || this.fightId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GuildFightPlayersHelpersLeaveMessage.fightId.");
         }
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of GuildFightPlayersHelpersLeaveMessage.playerId.");
         }
      }
   }
}
