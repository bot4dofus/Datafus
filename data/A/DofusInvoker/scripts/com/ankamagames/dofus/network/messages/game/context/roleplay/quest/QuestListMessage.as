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
   
   public class QuestListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3323;
       
      
      private var _isInitialized:Boolean = false;
      
      public var finishedQuestsIds:Vector.<uint>;
      
      public var finishedQuestsCounts:Vector.<uint>;
      
      public var activeQuests:Vector.<QuestActiveInformations>;
      
      public var reinitDoneQuestsIds:Vector.<uint>;
      
      private var _finishedQuestsIdstree:FuncTree;
      
      private var _finishedQuestsCountstree:FuncTree;
      
      private var _activeQueststree:FuncTree;
      
      private var _reinitDoneQuestsIdstree:FuncTree;
      
      public function QuestListMessage()
      {
         this.finishedQuestsIds = new Vector.<uint>();
         this.finishedQuestsCounts = new Vector.<uint>();
         this.activeQuests = new Vector.<QuestActiveInformations>();
         this.reinitDoneQuestsIds = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3323;
      }
      
      public function initQuestListMessage(finishedQuestsIds:Vector.<uint> = null, finishedQuestsCounts:Vector.<uint> = null, activeQuests:Vector.<QuestActiveInformations> = null, reinitDoneQuestsIds:Vector.<uint> = null) : QuestListMessage
      {
         this.finishedQuestsIds = finishedQuestsIds;
         this.finishedQuestsCounts = finishedQuestsCounts;
         this.activeQuests = activeQuests;
         this.reinitDoneQuestsIds = reinitDoneQuestsIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.finishedQuestsIds = new Vector.<uint>();
         this.finishedQuestsCounts = new Vector.<uint>();
         this.activeQuests = new Vector.<QuestActiveInformations>();
         this.reinitDoneQuestsIds = new Vector.<uint>();
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
         this.serializeAs_QuestListMessage(output);
      }
      
      public function serializeAs_QuestListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.finishedQuestsIds.length);
         for(var _i1:uint = 0; _i1 < this.finishedQuestsIds.length; _i1++)
         {
            if(this.finishedQuestsIds[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.finishedQuestsIds[_i1] + ") on element 1 (starting at 1) of finishedQuestsIds.");
            }
            output.writeVarShort(this.finishedQuestsIds[_i1]);
         }
         output.writeShort(this.finishedQuestsCounts.length);
         for(var _i2:uint = 0; _i2 < this.finishedQuestsCounts.length; _i2++)
         {
            if(this.finishedQuestsCounts[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.finishedQuestsCounts[_i2] + ") on element 2 (starting at 1) of finishedQuestsCounts.");
            }
            output.writeVarShort(this.finishedQuestsCounts[_i2]);
         }
         output.writeShort(this.activeQuests.length);
         for(var _i3:uint = 0; _i3 < this.activeQuests.length; _i3++)
         {
            output.writeShort((this.activeQuests[_i3] as QuestActiveInformations).getTypeId());
            (this.activeQuests[_i3] as QuestActiveInformations).serialize(output);
         }
         output.writeShort(this.reinitDoneQuestsIds.length);
         for(var _i4:uint = 0; _i4 < this.reinitDoneQuestsIds.length; _i4++)
         {
            if(this.reinitDoneQuestsIds[_i4] < 0)
            {
               throw new Error("Forbidden value (" + this.reinitDoneQuestsIds[_i4] + ") on element 4 (starting at 1) of reinitDoneQuestsIds.");
            }
            output.writeVarShort(this.reinitDoneQuestsIds[_i4]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_QuestListMessage(input);
      }
      
      public function deserializeAs_QuestListMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _val2:uint = 0;
         var _id3:uint = 0;
         var _item3:QuestActiveInformations = null;
         var _val4:uint = 0;
         var _finishedQuestsIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _finishedQuestsIdsLen; _i1++)
         {
            _val1 = input.readVarUhShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of finishedQuestsIds.");
            }
            this.finishedQuestsIds.push(_val1);
         }
         var _finishedQuestsCountsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _finishedQuestsCountsLen; _i2++)
         {
            _val2 = input.readVarUhShort();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of finishedQuestsCounts.");
            }
            this.finishedQuestsCounts.push(_val2);
         }
         var _activeQuestsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _activeQuestsLen; _i3++)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(QuestActiveInformations,_id3);
            _item3.deserialize(input);
            this.activeQuests.push(_item3);
         }
         var _reinitDoneQuestsIdsLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _reinitDoneQuestsIdsLen; _i4++)
         {
            _val4 = input.readVarUhShort();
            if(_val4 < 0)
            {
               throw new Error("Forbidden value (" + _val4 + ") on elements of reinitDoneQuestsIds.");
            }
            this.reinitDoneQuestsIds.push(_val4);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_QuestListMessage(tree);
      }
      
      public function deserializeAsyncAs_QuestListMessage(tree:FuncTree) : void
      {
         this._finishedQuestsIdstree = tree.addChild(this._finishedQuestsIdstreeFunc);
         this._finishedQuestsCountstree = tree.addChild(this._finishedQuestsCountstreeFunc);
         this._activeQueststree = tree.addChild(this._activeQueststreeFunc);
         this._reinitDoneQuestsIdstree = tree.addChild(this._reinitDoneQuestsIdstreeFunc);
      }
      
      private function _finishedQuestsIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._finishedQuestsIdstree.addChild(this._finishedQuestsIdsFunc);
         }
      }
      
      private function _finishedQuestsIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of finishedQuestsIds.");
         }
         this.finishedQuestsIds.push(_val);
      }
      
      private function _finishedQuestsCountstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._finishedQuestsCountstree.addChild(this._finishedQuestsCountsFunc);
         }
      }
      
      private function _finishedQuestsCountsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of finishedQuestsCounts.");
         }
         this.finishedQuestsCounts.push(_val);
      }
      
      private function _activeQueststreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._activeQueststree.addChild(this._activeQuestsFunc);
         }
      }
      
      private function _activeQuestsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:QuestActiveInformations = ProtocolTypeManager.getInstance(QuestActiveInformations,_id);
         _item.deserialize(input);
         this.activeQuests.push(_item);
      }
      
      private function _reinitDoneQuestsIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._reinitDoneQuestsIdstree.addChild(this._reinitDoneQuestsIdsFunc);
         }
      }
      
      private function _reinitDoneQuestsIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of reinitDoneQuestsIds.");
         }
         this.reinitDoneQuestsIds.push(_val);
      }
   }
}
