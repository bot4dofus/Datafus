package com.ankamagames.dofus.network.messages.game.progression.suggestion
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ActivitySuggestionsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5717;
       
      
      private var _isInitialized:Boolean = false;
      
      public var lockedActivitiesIds:Vector.<uint>;
      
      public var unlockedActivitiesIds:Vector.<uint>;
      
      private var _lockedActivitiesIdstree:FuncTree;
      
      private var _unlockedActivitiesIdstree:FuncTree;
      
      public function ActivitySuggestionsMessage()
      {
         this.lockedActivitiesIds = new Vector.<uint>();
         this.unlockedActivitiesIds = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5717;
      }
      
      public function initActivitySuggestionsMessage(lockedActivitiesIds:Vector.<uint> = null, unlockedActivitiesIds:Vector.<uint> = null) : ActivitySuggestionsMessage
      {
         this.lockedActivitiesIds = lockedActivitiesIds;
         this.unlockedActivitiesIds = unlockedActivitiesIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.lockedActivitiesIds = new Vector.<uint>();
         this.unlockedActivitiesIds = new Vector.<uint>();
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
         this.serializeAs_ActivitySuggestionsMessage(output);
      }
      
      public function serializeAs_ActivitySuggestionsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.lockedActivitiesIds.length);
         for(var _i1:uint = 0; _i1 < this.lockedActivitiesIds.length; _i1++)
         {
            if(this.lockedActivitiesIds[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.lockedActivitiesIds[_i1] + ") on element 1 (starting at 1) of lockedActivitiesIds.");
            }
            output.writeVarShort(this.lockedActivitiesIds[_i1]);
         }
         output.writeShort(this.unlockedActivitiesIds.length);
         for(var _i2:uint = 0; _i2 < this.unlockedActivitiesIds.length; _i2++)
         {
            if(this.unlockedActivitiesIds[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.unlockedActivitiesIds[_i2] + ") on element 2 (starting at 1) of unlockedActivitiesIds.");
            }
            output.writeVarShort(this.unlockedActivitiesIds[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ActivitySuggestionsMessage(input);
      }
      
      public function deserializeAs_ActivitySuggestionsMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _val2:uint = 0;
         var _lockedActivitiesIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _lockedActivitiesIdsLen; _i1++)
         {
            _val1 = input.readVarUhShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of lockedActivitiesIds.");
            }
            this.lockedActivitiesIds.push(_val1);
         }
         var _unlockedActivitiesIdsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _unlockedActivitiesIdsLen; _i2++)
         {
            _val2 = input.readVarUhShort();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of unlockedActivitiesIds.");
            }
            this.unlockedActivitiesIds.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ActivitySuggestionsMessage(tree);
      }
      
      public function deserializeAsyncAs_ActivitySuggestionsMessage(tree:FuncTree) : void
      {
         this._lockedActivitiesIdstree = tree.addChild(this._lockedActivitiesIdstreeFunc);
         this._unlockedActivitiesIdstree = tree.addChild(this._unlockedActivitiesIdstreeFunc);
      }
      
      private function _lockedActivitiesIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._lockedActivitiesIdstree.addChild(this._lockedActivitiesIdsFunc);
         }
      }
      
      private function _lockedActivitiesIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of lockedActivitiesIds.");
         }
         this.lockedActivitiesIds.push(_val);
      }
      
      private function _unlockedActivitiesIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._unlockedActivitiesIdstree.addChild(this._unlockedActivitiesIdsFunc);
         }
      }
      
      private function _unlockedActivitiesIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of unlockedActivitiesIds.");
         }
         this.unlockedActivitiesIds.push(_val);
      }
   }
}
