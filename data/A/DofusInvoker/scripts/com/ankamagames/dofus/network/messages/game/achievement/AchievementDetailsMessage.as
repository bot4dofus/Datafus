package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.dofus.network.types.game.achievement.Achievement;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AchievementDetailsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8282;
       
      
      private var _isInitialized:Boolean = false;
      
      public var achievement:Achievement;
      
      private var _achievementtree:FuncTree;
      
      public function AchievementDetailsMessage()
      {
         this.achievement = new Achievement();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8282;
      }
      
      public function initAchievementDetailsMessage(achievement:Achievement = null) : AchievementDetailsMessage
      {
         this.achievement = achievement;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.achievement = new Achievement();
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
         this.serializeAs_AchievementDetailsMessage(output);
      }
      
      public function serializeAs_AchievementDetailsMessage(output:ICustomDataOutput) : void
      {
         this.achievement.serializeAs_Achievement(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementDetailsMessage(input);
      }
      
      public function deserializeAs_AchievementDetailsMessage(input:ICustomDataInput) : void
      {
         this.achievement = new Achievement();
         this.achievement.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementDetailsMessage(tree);
      }
      
      public function deserializeAsyncAs_AchievementDetailsMessage(tree:FuncTree) : void
      {
         this._achievementtree = tree.addChild(this._achievementtreeFunc);
      }
      
      private function _achievementtreeFunc(input:ICustomDataInput) : void
      {
         this.achievement = new Achievement();
         this.achievement.deserializeAsync(this._achievementtree);
      }
   }
}
