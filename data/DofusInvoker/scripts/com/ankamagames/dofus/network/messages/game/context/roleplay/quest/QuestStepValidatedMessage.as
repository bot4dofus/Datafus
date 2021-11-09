package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class QuestStepValidatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 882;
       
      
      private var _isInitialized:Boolean = false;
      
      public var questId:uint = 0;
      
      public var stepId:uint = 0;
      
      public function QuestStepValidatedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 882;
      }
      
      public function initQuestStepValidatedMessage(questId:uint = 0, stepId:uint = 0) : QuestStepValidatedMessage
      {
         this.questId = questId;
         this.stepId = stepId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.questId = 0;
         this.stepId = 0;
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
         this.serializeAs_QuestStepValidatedMessage(output);
      }
      
      public function serializeAs_QuestStepValidatedMessage(output:ICustomDataOutput) : void
      {
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element questId.");
         }
         output.writeVarShort(this.questId);
         if(this.stepId < 0)
         {
            throw new Error("Forbidden value (" + this.stepId + ") on element stepId.");
         }
         output.writeVarShort(this.stepId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_QuestStepValidatedMessage(input);
      }
      
      public function deserializeAs_QuestStepValidatedMessage(input:ICustomDataInput) : void
      {
         this._questIdFunc(input);
         this._stepIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_QuestStepValidatedMessage(tree);
      }
      
      public function deserializeAsyncAs_QuestStepValidatedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._questIdFunc);
         tree.addChild(this._stepIdFunc);
      }
      
      private function _questIdFunc(input:ICustomDataInput) : void
      {
         this.questId = input.readVarUhShort();
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element of QuestStepValidatedMessage.questId.");
         }
      }
      
      private function _stepIdFunc(input:ICustomDataInput) : void
      {
         this.stepId = input.readVarUhShort();
         if(this.stepId < 0)
         {
            throw new Error("Forbidden value (" + this.stepId + ") on element of QuestStepValidatedMessage.stepId.");
         }
      }
   }
}
