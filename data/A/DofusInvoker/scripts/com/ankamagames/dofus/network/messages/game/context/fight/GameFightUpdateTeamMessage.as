package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightUpdateTeamMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3874;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightId:uint = 0;
      
      public var team:FightTeamInformations;
      
      private var _teamtree:FuncTree;
      
      public function GameFightUpdateTeamMessage()
      {
         this.team = new FightTeamInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3874;
      }
      
      public function initGameFightUpdateTeamMessage(fightId:uint = 0, team:FightTeamInformations = null) : GameFightUpdateTeamMessage
      {
         this.fightId = fightId;
         this.team = team;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
         this.team = new FightTeamInformations();
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
         this.serializeAs_GameFightUpdateTeamMessage(output);
      }
      
      public function serializeAs_GameFightUpdateTeamMessage(output:ICustomDataOutput) : void
      {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
         this.team.serializeAs_FightTeamInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightUpdateTeamMessage(input);
      }
      
      public function deserializeAs_GameFightUpdateTeamMessage(input:ICustomDataInput) : void
      {
         this._fightIdFunc(input);
         this.team = new FightTeamInformations();
         this.team.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightUpdateTeamMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightUpdateTeamMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         this._teamtree = tree.addChild(this._teamtreeFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameFightUpdateTeamMessage.fightId.");
         }
      }
      
      private function _teamtreeFunc(input:ICustomDataInput) : void
      {
         this.team = new FightTeamInformations();
         this.team.deserializeAsync(this._teamtree);
      }
   }
}
