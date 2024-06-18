package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class WatchQuestListMessage extends QuestListMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5644;
       
      
      private var _isInitialized:Boolean = false;
      
      public var playerId:Number = 0;
      
      public function WatchQuestListMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5644;
      }
      
      public function initWatchQuestListMessage(finishedQuestsIds:Vector.<uint> = null, finishedQuestsCounts:Vector.<uint> = null, activeQuests:Vector.<QuestActiveInformations> = null, reinitDoneQuestsIds:Vector.<uint> = null, playerId:Number = 0) : WatchQuestListMessage
      {
         super.initQuestListMessage(finishedQuestsIds,finishedQuestsCounts,activeQuests,reinitDoneQuestsIds);
         this.playerId = playerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_WatchQuestListMessage(output);
      }
      
      public function serializeAs_WatchQuestListMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_QuestListMessage(output);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_WatchQuestListMessage(input);
      }
      
      public function deserializeAs_WatchQuestListMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._playerIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_WatchQuestListMessage(tree);
      }
      
      public function deserializeAsyncAs_WatchQuestListMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._playerIdFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of WatchQuestListMessage.playerId.");
         }
      }
   }
}
