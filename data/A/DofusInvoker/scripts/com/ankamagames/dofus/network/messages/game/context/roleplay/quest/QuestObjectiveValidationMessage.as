package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class QuestObjectiveValidationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4654;
       
      
      private var _isInitialized:Boolean = false;
      
      public var questId:uint = 0;
      
      public var objectiveId:uint = 0;
      
      public function QuestObjectiveValidationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4654;
      }
      
      public function initQuestObjectiveValidationMessage(questId:uint = 0, objectiveId:uint = 0) : QuestObjectiveValidationMessage
      {
         this.questId = questId;
         this.objectiveId = objectiveId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.questId = 0;
         this.objectiveId = 0;
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
         this.serializeAs_QuestObjectiveValidationMessage(output);
      }
      
      public function serializeAs_QuestObjectiveValidationMessage(output:ICustomDataOutput) : void
      {
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element questId.");
         }
         output.writeVarShort(this.questId);
         if(this.objectiveId < 0)
         {
            throw new Error("Forbidden value (" + this.objectiveId + ") on element objectiveId.");
         }
         output.writeVarShort(this.objectiveId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_QuestObjectiveValidationMessage(input);
      }
      
      public function deserializeAs_QuestObjectiveValidationMessage(input:ICustomDataInput) : void
      {
         this._questIdFunc(input);
         this._objectiveIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_QuestObjectiveValidationMessage(tree);
      }
      
      public function deserializeAsyncAs_QuestObjectiveValidationMessage(tree:FuncTree) : void
      {
         tree.addChild(this._questIdFunc);
         tree.addChild(this._objectiveIdFunc);
      }
      
      private function _questIdFunc(input:ICustomDataInput) : void
      {
         this.questId = input.readVarUhShort();
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element of QuestObjectiveValidationMessage.questId.");
         }
      }
      
      private function _objectiveIdFunc(input:ICustomDataInput) : void
      {
         this.objectiveId = input.readVarUhShort();
         if(this.objectiveId < 0)
         {
            throw new Error("Forbidden value (" + this.objectiveId + ") on element of QuestObjectiveValidationMessage.objectiveId.");
         }
      }
   }
}
