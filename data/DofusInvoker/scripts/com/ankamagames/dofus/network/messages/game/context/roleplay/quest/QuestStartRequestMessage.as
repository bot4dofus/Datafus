package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class QuestStartRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4821;
       
      
      private var _isInitialized:Boolean = false;
      
      public var questId:uint = 0;
      
      public function QuestStartRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4821;
      }
      
      public function initQuestStartRequestMessage(questId:uint = 0) : QuestStartRequestMessage
      {
         this.questId = questId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.questId = 0;
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
         this.serializeAs_QuestStartRequestMessage(output);
      }
      
      public function serializeAs_QuestStartRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element questId.");
         }
         output.writeVarShort(this.questId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_QuestStartRequestMessage(input);
      }
      
      public function deserializeAs_QuestStartRequestMessage(input:ICustomDataInput) : void
      {
         this._questIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_QuestStartRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_QuestStartRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._questIdFunc);
      }
      
      private function _questIdFunc(input:ICustomDataInput) : void
      {
         this.questId = input.readVarUhShort();
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element of QuestStartRequestMessage.questId.");
         }
      }
   }
}
