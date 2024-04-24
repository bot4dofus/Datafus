package com.ankamagames.dofus.network.messages.game.progression.suggestion
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ActivitySuggestionsRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3114;
       
      
      private var _isInitialized:Boolean = false;
      
      public var minLevel:uint = 0;
      
      public var maxLevel:uint = 0;
      
      public var areaId:uint = 0;
      
      public var activityCategoryId:uint = 0;
      
      public var nbCards:uint = 0;
      
      public function ActivitySuggestionsRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3114;
      }
      
      public function initActivitySuggestionsRequestMessage(minLevel:uint = 0, maxLevel:uint = 0, areaId:uint = 0, activityCategoryId:uint = 0, nbCards:uint = 0) : ActivitySuggestionsRequestMessage
      {
         this.minLevel = minLevel;
         this.maxLevel = maxLevel;
         this.areaId = areaId;
         this.activityCategoryId = activityCategoryId;
         this.nbCards = nbCards;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.minLevel = 0;
         this.maxLevel = 0;
         this.areaId = 0;
         this.activityCategoryId = 0;
         this.nbCards = 0;
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
         this.serializeAs_ActivitySuggestionsRequestMessage(output);
      }
      
      public function serializeAs_ActivitySuggestionsRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.minLevel < 0)
         {
            throw new Error("Forbidden value (" + this.minLevel + ") on element minLevel.");
         }
         output.writeVarShort(this.minLevel);
         if(this.maxLevel < 0)
         {
            throw new Error("Forbidden value (" + this.maxLevel + ") on element maxLevel.");
         }
         output.writeVarShort(this.maxLevel);
         if(this.areaId < 0)
         {
            throw new Error("Forbidden value (" + this.areaId + ") on element areaId.");
         }
         output.writeVarShort(this.areaId);
         if(this.activityCategoryId < 0)
         {
            throw new Error("Forbidden value (" + this.activityCategoryId + ") on element activityCategoryId.");
         }
         output.writeVarShort(this.activityCategoryId);
         if(this.nbCards < 0 || this.nbCards > 65535)
         {
            throw new Error("Forbidden value (" + this.nbCards + ") on element nbCards.");
         }
         output.writeShort(this.nbCards);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ActivitySuggestionsRequestMessage(input);
      }
      
      public function deserializeAs_ActivitySuggestionsRequestMessage(input:ICustomDataInput) : void
      {
         this._minLevelFunc(input);
         this._maxLevelFunc(input);
         this._areaIdFunc(input);
         this._activityCategoryIdFunc(input);
         this._nbCardsFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ActivitySuggestionsRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_ActivitySuggestionsRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._minLevelFunc);
         tree.addChild(this._maxLevelFunc);
         tree.addChild(this._areaIdFunc);
         tree.addChild(this._activityCategoryIdFunc);
         tree.addChild(this._nbCardsFunc);
      }
      
      private function _minLevelFunc(input:ICustomDataInput) : void
      {
         this.minLevel = input.readVarUhShort();
         if(this.minLevel < 0)
         {
            throw new Error("Forbidden value (" + this.minLevel + ") on element of ActivitySuggestionsRequestMessage.minLevel.");
         }
      }
      
      private function _maxLevelFunc(input:ICustomDataInput) : void
      {
         this.maxLevel = input.readVarUhShort();
         if(this.maxLevel < 0)
         {
            throw new Error("Forbidden value (" + this.maxLevel + ") on element of ActivitySuggestionsRequestMessage.maxLevel.");
         }
      }
      
      private function _areaIdFunc(input:ICustomDataInput) : void
      {
         this.areaId = input.readVarUhShort();
         if(this.areaId < 0)
         {
            throw new Error("Forbidden value (" + this.areaId + ") on element of ActivitySuggestionsRequestMessage.areaId.");
         }
      }
      
      private function _activityCategoryIdFunc(input:ICustomDataInput) : void
      {
         this.activityCategoryId = input.readVarUhShort();
         if(this.activityCategoryId < 0)
         {
            throw new Error("Forbidden value (" + this.activityCategoryId + ") on element of ActivitySuggestionsRequestMessage.activityCategoryId.");
         }
      }
      
      private function _nbCardsFunc(input:ICustomDataInput) : void
      {
         this.nbCards = input.readUnsignedShort();
         if(this.nbCards < 0 || this.nbCards > 65535)
         {
            throw new Error("Forbidden value (" + this.nbCards + ") on element of ActivitySuggestionsRequestMessage.nbCards.");
         }
      }
   }
}
