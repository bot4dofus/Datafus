package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveDetailedInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class FollowedQuestsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7010;
       
      
      private var _isInitialized:Boolean = false;
      
      public var quests:Vector.<QuestActiveDetailedInformations>;
      
      private var _queststree:FuncTree;
      
      public function FollowedQuestsMessage()
      {
         this.quests = new Vector.<QuestActiveDetailedInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7010;
      }
      
      public function initFollowedQuestsMessage(quests:Vector.<QuestActiveDetailedInformations> = null) : FollowedQuestsMessage
      {
         this.quests = quests;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.quests = new Vector.<QuestActiveDetailedInformations>();
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
         this.serializeAs_FollowedQuestsMessage(output);
      }
      
      public function serializeAs_FollowedQuestsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.quests.length);
         for(var _i1:uint = 0; _i1 < this.quests.length; _i1++)
         {
            (this.quests[_i1] as QuestActiveDetailedInformations).serializeAs_QuestActiveDetailedInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FollowedQuestsMessage(input);
      }
      
      public function deserializeAs_FollowedQuestsMessage(input:ICustomDataInput) : void
      {
         var _item1:QuestActiveDetailedInformations = null;
         var _questsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _questsLen; _i1++)
         {
            _item1 = new QuestActiveDetailedInformations();
            _item1.deserialize(input);
            this.quests.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FollowedQuestsMessage(tree);
      }
      
      public function deserializeAsyncAs_FollowedQuestsMessage(tree:FuncTree) : void
      {
         this._queststree = tree.addChild(this._queststreeFunc);
      }
      
      private function _queststreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._queststree.addChild(this._questsFunc);
         }
      }
      
      private function _questsFunc(input:ICustomDataInput) : void
      {
         var _item:QuestActiveDetailedInformations = new QuestActiveDetailedInformations();
         _item.deserialize(input);
         this.quests.push(_item);
      }
   }
}
