package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AcquaintanceOnlineInformation extends AcquaintanceInformation implements INetworkType
   {
      
      public static const protocolId:uint = 251;
       
      
      public var playerId:Number = 0;
      
      public var playerName:String = "";
      
      public var moodSmileyId:uint = 0;
      
      public var status:PlayerStatus;
      
      private var _statustree:FuncTree;
      
      public function AcquaintanceOnlineInformation()
      {
         this.status = new PlayerStatus();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 251;
      }
      
      public function initAcquaintanceOnlineInformation(accountId:uint = 0, accountTag:AccountTagInformation = null, playerState:uint = 99, playerId:Number = 0, playerName:String = "", moodSmileyId:uint = 0, status:PlayerStatus = null) : AcquaintanceOnlineInformation
      {
         super.initAcquaintanceInformation(accountId,accountTag,playerState);
         this.playerId = playerId;
         this.playerName = playerName;
         this.moodSmileyId = moodSmileyId;
         this.status = status;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.playerId = 0;
         this.playerName = "";
         this.moodSmileyId = 0;
         this.status = new PlayerStatus();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AcquaintanceOnlineInformation(output);
      }
      
      public function serializeAs_AcquaintanceOnlineInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_AcquaintanceInformation(output);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeUTF(this.playerName);
         if(this.moodSmileyId < 0)
         {
            throw new Error("Forbidden value (" + this.moodSmileyId + ") on element moodSmileyId.");
         }
         output.writeVarShort(this.moodSmileyId);
         output.writeShort(this.status.getTypeId());
         this.status.serialize(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AcquaintanceOnlineInformation(input);
      }
      
      public function deserializeAs_AcquaintanceOnlineInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._playerIdFunc(input);
         this._playerNameFunc(input);
         this._moodSmileyIdFunc(input);
         var _id4:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id4);
         this.status.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AcquaintanceOnlineInformation(tree);
      }
      
      public function deserializeAsyncAs_AcquaintanceOnlineInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._playerNameFunc);
         tree.addChild(this._moodSmileyIdFunc);
         this._statustree = tree.addChild(this._statustreeFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of AcquaintanceOnlineInformation.playerId.");
         }
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
      
      private function _moodSmileyIdFunc(input:ICustomDataInput) : void
      {
         this.moodSmileyId = input.readVarUhShort();
         if(this.moodSmileyId < 0)
         {
            throw new Error("Forbidden value (" + this.moodSmileyId + ") on element of AcquaintanceOnlineInformation.moodSmileyId.");
         }
      }
      
      private function _statustreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id);
         this.status.deserializeAsync(this._statustree);
      }
   }
}
