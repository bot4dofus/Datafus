package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class RefreshFollowedQuestsOrderRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8406;
       
      
      private var _isInitialized:Boolean = false;
      
      public var quests:Vector.<uint>;
      
      private var _queststree:FuncTree;
      
      public function RefreshFollowedQuestsOrderRequestMessage()
      {
         this.quests = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8406;
      }
      
      public function initRefreshFollowedQuestsOrderRequestMessage(quests:Vector.<uint> = null) : RefreshFollowedQuestsOrderRequestMessage
      {
         this.quests = quests;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.quests = new Vector.<uint>();
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
         this.serializeAs_RefreshFollowedQuestsOrderRequestMessage(output);
      }
      
      public function serializeAs_RefreshFollowedQuestsOrderRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.quests.length);
         for(var _i1:uint = 0; _i1 < this.quests.length; _i1++)
         {
            if(this.quests[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.quests[_i1] + ") on element 1 (starting at 1) of quests.");
            }
            output.writeVarShort(this.quests[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_RefreshFollowedQuestsOrderRequestMessage(input);
      }
      
      public function deserializeAs_RefreshFollowedQuestsOrderRequestMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _questsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _questsLen; _i1++)
         {
            _val1 = input.readVarUhShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of quests.");
            }
            this.quests.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_RefreshFollowedQuestsOrderRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_RefreshFollowedQuestsOrderRequestMessage(tree:FuncTree) : void
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
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of quests.");
         }
         this.quests.push(_val);
      }
   }
}
