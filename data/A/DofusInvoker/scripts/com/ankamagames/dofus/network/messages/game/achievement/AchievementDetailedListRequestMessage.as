package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AchievementDetailedListRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4300;
       
      
      private var _isInitialized:Boolean = false;
      
      public var categoryId:uint = 0;
      
      public function AchievementDetailedListRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4300;
      }
      
      public function initAchievementDetailedListRequestMessage(categoryId:uint = 0) : AchievementDetailedListRequestMessage
      {
         this.categoryId = categoryId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.categoryId = 0;
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
         this.serializeAs_AchievementDetailedListRequestMessage(output);
      }
      
      public function serializeAs_AchievementDetailedListRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.categoryId < 0)
         {
            throw new Error("Forbidden value (" + this.categoryId + ") on element categoryId.");
         }
         output.writeVarShort(this.categoryId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementDetailedListRequestMessage(input);
      }
      
      public function deserializeAs_AchievementDetailedListRequestMessage(input:ICustomDataInput) : void
      {
         this._categoryIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementDetailedListRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_AchievementDetailedListRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._categoryIdFunc);
      }
      
      private function _categoryIdFunc(input:ICustomDataInput) : void
      {
         this.categoryId = input.readVarUhShort();
         if(this.categoryId < 0)
         {
            throw new Error("Forbidden value (" + this.categoryId + ") on element of AchievementDetailedListRequestMessage.categoryId.");
         }
      }
   }
}
