package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class QuestStepInfoMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8324;
       
      
      private var _isInitialized:Boolean = false;
      
      public var infos:QuestActiveInformations;
      
      private var _infostree:FuncTree;
      
      public function QuestStepInfoMessage()
      {
         this.infos = new QuestActiveInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8324;
      }
      
      public function initQuestStepInfoMessage(infos:QuestActiveInformations = null) : QuestStepInfoMessage
      {
         this.infos = infos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.infos = new QuestActiveInformations();
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
         this.serializeAs_QuestStepInfoMessage(output);
      }
      
      public function serializeAs_QuestStepInfoMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.infos.getTypeId());
         this.infos.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_QuestStepInfoMessage(input);
      }
      
      public function deserializeAs_QuestStepInfoMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = input.readUnsignedShort();
         this.infos = ProtocolTypeManager.getInstance(QuestActiveInformations,_id1);
         this.infos.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_QuestStepInfoMessage(tree);
      }
      
      public function deserializeAsyncAs_QuestStepInfoMessage(tree:FuncTree) : void
      {
         this._infostree = tree.addChild(this._infostreeFunc);
      }
      
      private function _infostreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.infos = ProtocolTypeManager.getInstance(QuestActiveInformations,_id);
         this.infos.deserializeAsync(this._infostree);
      }
   }
}
