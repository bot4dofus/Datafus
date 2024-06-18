package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.dofus.network.types.game.achievement.AchievementAchievedRewardable;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AchievementFinishedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1474;
       
      
      private var _isInitialized:Boolean = false;
      
      public var achievement:AchievementAchievedRewardable;
      
      private var _achievementtree:FuncTree;
      
      public function AchievementFinishedMessage()
      {
         this.achievement = new AchievementAchievedRewardable();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1474;
      }
      
      public function initAchievementFinishedMessage(achievement:AchievementAchievedRewardable = null) : AchievementFinishedMessage
      {
         this.achievement = achievement;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.achievement = new AchievementAchievedRewardable();
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
         this.serializeAs_AchievementFinishedMessage(output);
      }
      
      public function serializeAs_AchievementFinishedMessage(output:ICustomDataOutput) : void
      {
         this.achievement.serializeAs_AchievementAchievedRewardable(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementFinishedMessage(input);
      }
      
      public function deserializeAs_AchievementFinishedMessage(input:ICustomDataInput) : void
      {
         this.achievement = new AchievementAchievedRewardable();
         this.achievement.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementFinishedMessage(tree);
      }
      
      public function deserializeAsyncAs_AchievementFinishedMessage(tree:FuncTree) : void
      {
         this._achievementtree = tree.addChild(this._achievementtreeFunc);
      }
      
      private function _achievementtreeFunc(input:ICustomDataInput) : void
      {
         this.achievement = new AchievementAchievedRewardable();
         this.achievement.deserializeAsync(this._achievementtree);
      }
   }
}
