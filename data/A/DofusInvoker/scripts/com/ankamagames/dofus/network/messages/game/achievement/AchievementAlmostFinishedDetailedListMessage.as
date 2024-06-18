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
   
   public class AchievementAlmostFinishedDetailedListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1205;
       
      
      private var _isInitialized:Boolean = false;
      
      public var almostFinishedAchievements:Vector.<Achievement>;
      
      private var _almostFinishedAchievementstree:FuncTree;
      
      public function AchievementAlmostFinishedDetailedListMessage()
      {
         this.almostFinishedAchievements = new Vector.<Achievement>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1205;
      }
      
      public function initAchievementAlmostFinishedDetailedListMessage(almostFinishedAchievements:Vector.<Achievement> = null) : AchievementAlmostFinishedDetailedListMessage
      {
         this.almostFinishedAchievements = almostFinishedAchievements;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.almostFinishedAchievements = new Vector.<Achievement>();
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
         this.serializeAs_AchievementAlmostFinishedDetailedListMessage(output);
      }
      
      public function serializeAs_AchievementAlmostFinishedDetailedListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.almostFinishedAchievements.length);
         for(var _i1:uint = 0; _i1 < this.almostFinishedAchievements.length; _i1++)
         {
            (this.almostFinishedAchievements[_i1] as Achievement).serializeAs_Achievement(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementAlmostFinishedDetailedListMessage(input);
      }
      
      public function deserializeAs_AchievementAlmostFinishedDetailedListMessage(input:ICustomDataInput) : void
      {
         var _item1:Achievement = null;
         var _almostFinishedAchievementsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _almostFinishedAchievementsLen; _i1++)
         {
            _item1 = new Achievement();
            _item1.deserialize(input);
            this.almostFinishedAchievements.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementAlmostFinishedDetailedListMessage(tree);
      }
      
      public function deserializeAsyncAs_AchievementAlmostFinishedDetailedListMessage(tree:FuncTree) : void
      {
         this._almostFinishedAchievementstree = tree.addChild(this._almostFinishedAchievementstreeFunc);
      }
      
      private function _almostFinishedAchievementstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._almostFinishedAchievementstree.addChild(this._almostFinishedAchievementsFunc);
         }
      }
      
      private function _almostFinishedAchievementsFunc(input:ICustomDataInput) : void
      {
         var _item:Achievement = new Achievement();
         _item.deserialize(input);
         this.almostFinishedAchievements.push(_item);
      }
   }
}
