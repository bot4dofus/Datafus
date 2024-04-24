package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class UnfollowQuestObjectiveRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6347;
       
      
      private var _isInitialized:Boolean = false;
      
      public var questId:uint = 0;
      
      public var objectiveId:int = 0;
      
      public function UnfollowQuestObjectiveRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6347;
      }
      
      public function initUnfollowQuestObjectiveRequestMessage(questId:uint = 0, objectiveId:int = 0) : UnfollowQuestObjectiveRequestMessage
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
         this.serializeAs_UnfollowQuestObjectiveRequestMessage(output);
      }
      
      public function serializeAs_UnfollowQuestObjectiveRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element questId.");
         }
         output.writeVarShort(this.questId);
         output.writeShort(this.objectiveId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_UnfollowQuestObjectiveRequestMessage(input);
      }
      
      public function deserializeAs_UnfollowQuestObjectiveRequestMessage(input:ICustomDataInput) : void
      {
         this._questIdFunc(input);
         this._objectiveIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_UnfollowQuestObjectiveRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_UnfollowQuestObjectiveRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._questIdFunc);
         tree.addChild(this._objectiveIdFunc);
      }
      
      private function _questIdFunc(input:ICustomDataInput) : void
      {
         this.questId = input.readVarUhShort();
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element of UnfollowQuestObjectiveRequestMessage.questId.");
         }
      }
      
      private function _objectiveIdFunc(input:ICustomDataInput) : void
      {
         this.objectiveId = input.readShort();
      }
   }
}
