package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayArenaFightAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7230;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightId:uint = 0;
      
      public var accept:Boolean = false;
      
      public function GameRolePlayArenaFightAnswerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7230;
      }
      
      public function initGameRolePlayArenaFightAnswerMessage(fightId:uint = 0, accept:Boolean = false) : GameRolePlayArenaFightAnswerMessage
      {
         this.fightId = fightId;
         this.accept = accept;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
         this.accept = false;
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
         this.serializeAs_GameRolePlayArenaFightAnswerMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaFightAnswerMessage(output:ICustomDataOutput) : void
      {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
         output.writeBoolean(this.accept);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayArenaFightAnswerMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaFightAnswerMessage(input:ICustomDataInput) : void
      {
         this._fightIdFunc(input);
         this._acceptFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayArenaFightAnswerMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayArenaFightAnswerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         tree.addChild(this._acceptFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameRolePlayArenaFightAnswerMessage.fightId.");
         }
      }
      
      private function _acceptFunc(input:ICustomDataInput) : void
      {
         this.accept = input.readBoolean();
      }
   }
}
