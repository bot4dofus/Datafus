package com.ankamagames.dofus.network.types.game.guild.logbook.global
{
   import com.ankamagames.dofus.network.types.game.guild.logbook.GuildLogbookEntryBasicInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildPlayerFlowActivity extends GuildLogbookEntryBasicInformation implements INetworkType
   {
      
      public static const protocolId:uint = 148;
       
      
      public var playerId:Number = 0;
      
      public var playerName:String = "";
      
      public var playerFlowEventType:uint = 0;
      
      public function GuildPlayerFlowActivity()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 148;
      }
      
      public function initGuildPlayerFlowActivity(id:uint = 0, date:Number = 0, playerId:Number = 0, playerName:String = "", playerFlowEventType:uint = 0) : GuildPlayerFlowActivity
      {
         super.initGuildLogbookEntryBasicInformation(id,date);
         this.playerId = playerId;
         this.playerName = playerName;
         this.playerFlowEventType = playerFlowEventType;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.playerId = 0;
         this.playerName = "";
         this.playerFlowEventType = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildPlayerFlowActivity(output);
      }
      
      public function serializeAs_GuildPlayerFlowActivity(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildLogbookEntryBasicInformation(output);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeUTF(this.playerName);
         output.writeByte(this.playerFlowEventType);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildPlayerFlowActivity(input);
      }
      
      public function deserializeAs_GuildPlayerFlowActivity(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._playerIdFunc(input);
         this._playerNameFunc(input);
         this._playerFlowEventTypeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildPlayerFlowActivity(tree);
      }
      
      public function deserializeAsyncAs_GuildPlayerFlowActivity(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._playerNameFunc);
         tree.addChild(this._playerFlowEventTypeFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of GuildPlayerFlowActivity.playerId.");
         }
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
      
      private function _playerFlowEventTypeFunc(input:ICustomDataInput) : void
      {
         this.playerFlowEventType = input.readByte();
         if(this.playerFlowEventType < 0)
         {
            throw new Error("Forbidden value (" + this.playerFlowEventType + ") on element of GuildPlayerFlowActivity.playerFlowEventType.");
         }
      }
   }
}
