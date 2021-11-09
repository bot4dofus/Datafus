package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AchievementRewardRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7613;
       
      
      private var _isInitialized:Boolean = false;
      
      public var achievementId:int = 0;
      
      public function AchievementRewardRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7613;
      }
      
      public function initAchievementRewardRequestMessage(achievementId:int = 0) : AchievementRewardRequestMessage
      {
         this.achievementId = achievementId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.achievementId = 0;
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
         this.serializeAs_AchievementRewardRequestMessage(output);
      }
      
      public function serializeAs_AchievementRewardRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.achievementId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementRewardRequestMessage(input);
      }
      
      public function deserializeAs_AchievementRewardRequestMessage(input:ICustomDataInput) : void
      {
         this._achievementIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementRewardRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_AchievementRewardRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._achievementIdFunc);
      }
      
      private function _achievementIdFunc(input:ICustomDataInput) : void
      {
         this.achievementId = input.readShort();
      }
   }
}
