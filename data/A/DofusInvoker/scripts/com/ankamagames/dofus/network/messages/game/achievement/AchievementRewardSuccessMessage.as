package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AchievementRewardSuccessMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1060;
       
      
      private var _isInitialized:Boolean = false;
      
      public var achievementId:int = 0;
      
      public function AchievementRewardSuccessMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1060;
      }
      
      public function initAchievementRewardSuccessMessage(achievementId:int = 0) : AchievementRewardSuccessMessage
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
         this.serializeAs_AchievementRewardSuccessMessage(output);
      }
      
      public function serializeAs_AchievementRewardSuccessMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.achievementId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementRewardSuccessMessage(input);
      }
      
      public function deserializeAs_AchievementRewardSuccessMessage(input:ICustomDataInput) : void
      {
         this._achievementIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementRewardSuccessMessage(tree);
      }
      
      public function deserializeAsyncAs_AchievementRewardSuccessMessage(tree:FuncTree) : void
      {
         tree.addChild(this._achievementIdFunc);
      }
      
      private function _achievementIdFunc(input:ICustomDataInput) : void
      {
         this.achievementId = input.readShort();
      }
   }
}
