package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class QuestObjectiveInformationsWithCompletion extends QuestObjectiveInformations implements INetworkType
   {
      
      public static const protocolId:uint = 2966;
       
      
      public var curCompletion:uint = 0;
      
      public var maxCompletion:uint = 0;
      
      public function QuestObjectiveInformationsWithCompletion()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2966;
      }
      
      public function initQuestObjectiveInformationsWithCompletion(objectiveId:uint = 0, objectiveStatus:Boolean = false, dialogParams:Vector.<String> = null, curCompletion:uint = 0, maxCompletion:uint = 0) : QuestObjectiveInformationsWithCompletion
      {
         super.initQuestObjectiveInformations(objectiveId,objectiveStatus,dialogParams);
         this.curCompletion = curCompletion;
         this.maxCompletion = maxCompletion;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.curCompletion = 0;
         this.maxCompletion = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_QuestObjectiveInformationsWithCompletion(output);
      }
      
      public function serializeAs_QuestObjectiveInformationsWithCompletion(output:ICustomDataOutput) : void
      {
         super.serializeAs_QuestObjectiveInformations(output);
         if(this.curCompletion < 0)
         {
            throw new Error("Forbidden value (" + this.curCompletion + ") on element curCompletion.");
         }
         output.writeVarShort(this.curCompletion);
         if(this.maxCompletion < 0)
         {
            throw new Error("Forbidden value (" + this.maxCompletion + ") on element maxCompletion.");
         }
         output.writeVarShort(this.maxCompletion);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_QuestObjectiveInformationsWithCompletion(input);
      }
      
      public function deserializeAs_QuestObjectiveInformationsWithCompletion(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._curCompletionFunc(input);
         this._maxCompletionFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_QuestObjectiveInformationsWithCompletion(tree);
      }
      
      public function deserializeAsyncAs_QuestObjectiveInformationsWithCompletion(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._curCompletionFunc);
         tree.addChild(this._maxCompletionFunc);
      }
      
      private function _curCompletionFunc(input:ICustomDataInput) : void
      {
         this.curCompletion = input.readVarUhShort();
         if(this.curCompletion < 0)
         {
            throw new Error("Forbidden value (" + this.curCompletion + ") on element of QuestObjectiveInformationsWithCompletion.curCompletion.");
         }
      }
      
      private function _maxCompletionFunc(input:ICustomDataInput) : void
      {
         this.maxCompletion = input.readVarUhShort();
         if(this.maxCompletion < 0)
         {
            throw new Error("Forbidden value (" + this.maxCompletion + ") on element of QuestObjectiveInformationsWithCompletion.maxCompletion.");
         }
      }
   }
}
