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
   
   public class AchievementDetailedListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9668;
       
      
      private var _isInitialized:Boolean = false;
      
      public var startedAchievements:Vector.<Achievement>;
      
      public var finishedAchievements:Vector.<Achievement>;
      
      private var _startedAchievementstree:FuncTree;
      
      private var _finishedAchievementstree:FuncTree;
      
      public function AchievementDetailedListMessage()
      {
         this.startedAchievements = new Vector.<Achievement>();
         this.finishedAchievements = new Vector.<Achievement>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9668;
      }
      
      public function initAchievementDetailedListMessage(startedAchievements:Vector.<Achievement> = null, finishedAchievements:Vector.<Achievement> = null) : AchievementDetailedListMessage
      {
         this.startedAchievements = startedAchievements;
         this.finishedAchievements = finishedAchievements;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.startedAchievements = new Vector.<Achievement>();
         this.finishedAchievements = new Vector.<Achievement>();
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
         this.serializeAs_AchievementDetailedListMessage(output);
      }
      
      public function serializeAs_AchievementDetailedListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.startedAchievements.length);
         for(var _i1:uint = 0; _i1 < this.startedAchievements.length; _i1++)
         {
            (this.startedAchievements[_i1] as Achievement).serializeAs_Achievement(output);
         }
         output.writeShort(this.finishedAchievements.length);
         for(var _i2:uint = 0; _i2 < this.finishedAchievements.length; _i2++)
         {
            (this.finishedAchievements[_i2] as Achievement).serializeAs_Achievement(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementDetailedListMessage(input);
      }
      
      public function deserializeAs_AchievementDetailedListMessage(input:ICustomDataInput) : void
      {
         var _item1:Achievement = null;
         var _item2:Achievement = null;
         var _startedAchievementsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _startedAchievementsLen; _i1++)
         {
            _item1 = new Achievement();
            _item1.deserialize(input);
            this.startedAchievements.push(_item1);
         }
         var _finishedAchievementsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _finishedAchievementsLen; _i2++)
         {
            _item2 = new Achievement();
            _item2.deserialize(input);
            this.finishedAchievements.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementDetailedListMessage(tree);
      }
      
      public function deserializeAsyncAs_AchievementDetailedListMessage(tree:FuncTree) : void
      {
         this._startedAchievementstree = tree.addChild(this._startedAchievementstreeFunc);
         this._finishedAchievementstree = tree.addChild(this._finishedAchievementstreeFunc);
      }
      
      private function _startedAchievementstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._startedAchievementstree.addChild(this._startedAchievementsFunc);
         }
      }
      
      private function _startedAchievementsFunc(input:ICustomDataInput) : void
      {
         var _item:Achievement = new Achievement();
         _item.deserialize(input);
         this.startedAchievements.push(_item);
      }
      
      private function _finishedAchievementstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._finishedAchievementstree.addChild(this._finishedAchievementsFunc);
         }
      }
      
      private function _finishedAchievementsFunc(input:ICustomDataInput) : void
      {
         var _item:Achievement = new Achievement();
         _item.deserialize(input);
         this.finishedAchievements.push(_item);
      }
   }
}
