package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightRemoveTeamMemberMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8088;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightId:uint = 0;
      
      public var teamId:uint = 2;
      
      public var charId:Number = 0;
      
      public function GameFightRemoveTeamMemberMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8088;
      }
      
      public function initGameFightRemoveTeamMemberMessage(fightId:uint = 0, teamId:uint = 2, charId:Number = 0) : GameFightRemoveTeamMemberMessage
      {
         this.fightId = fightId;
         this.teamId = teamId;
         this.charId = charId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
         this.teamId = 2;
         this.charId = 0;
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
         this.serializeAs_GameFightRemoveTeamMemberMessage(output);
      }
      
      public function serializeAs_GameFightRemoveTeamMemberMessage(output:ICustomDataOutput) : void
      {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
         output.writeByte(this.teamId);
         if(this.charId < -9007199254740992 || this.charId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.charId + ") on element charId.");
         }
         output.writeDouble(this.charId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightRemoveTeamMemberMessage(input);
      }
      
      public function deserializeAs_GameFightRemoveTeamMemberMessage(input:ICustomDataInput) : void
      {
         this._fightIdFunc(input);
         this._teamIdFunc(input);
         this._charIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightRemoveTeamMemberMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightRemoveTeamMemberMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         tree.addChild(this._teamIdFunc);
         tree.addChild(this._charIdFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameFightRemoveTeamMemberMessage.fightId.");
         }
      }
      
      private function _teamIdFunc(input:ICustomDataInput) : void
      {
         this.teamId = input.readByte();
         if(this.teamId < 0)
         {
            throw new Error("Forbidden value (" + this.teamId + ") on element of GameFightRemoveTeamMemberMessage.teamId.");
         }
      }
      
      private function _charIdFunc(input:ICustomDataInput) : void
      {
         this.charId = input.readDouble();
         if(this.charId < -9007199254740992 || this.charId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.charId + ") on element of GameFightRemoveTeamMemberMessage.charId.");
         }
      }
   }
}
