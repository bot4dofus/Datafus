package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.dofus.network.types.game.achievement.AchievementPioneerRank;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AchievementsPioneerRanksMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3443;
       
      
      private var _isInitialized:Boolean = false;
      
      public var achievementsPioneerRanks:Vector.<AchievementPioneerRank>;
      
      private var _achievementsPioneerRankstree:FuncTree;
      
      public function AchievementsPioneerRanksMessage()
      {
         this.achievementsPioneerRanks = new Vector.<AchievementPioneerRank>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3443;
      }
      
      public function initAchievementsPioneerRanksMessage(achievementsPioneerRanks:Vector.<AchievementPioneerRank> = null) : AchievementsPioneerRanksMessage
      {
         this.achievementsPioneerRanks = achievementsPioneerRanks;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.achievementsPioneerRanks = new Vector.<AchievementPioneerRank>();
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
         this.serializeAs_AchievementsPioneerRanksMessage(output);
      }
      
      public function serializeAs_AchievementsPioneerRanksMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.achievementsPioneerRanks.length);
         for(var _i1:uint = 0; _i1 < this.achievementsPioneerRanks.length; _i1++)
         {
            (this.achievementsPioneerRanks[_i1] as AchievementPioneerRank).serializeAs_AchievementPioneerRank(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementsPioneerRanksMessage(input);
      }
      
      public function deserializeAs_AchievementsPioneerRanksMessage(input:ICustomDataInput) : void
      {
         var _item1:AchievementPioneerRank = null;
         var _achievementsPioneerRanksLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _achievementsPioneerRanksLen; _i1++)
         {
            _item1 = new AchievementPioneerRank();
            _item1.deserialize(input);
            this.achievementsPioneerRanks.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementsPioneerRanksMessage(tree);
      }
      
      public function deserializeAsyncAs_AchievementsPioneerRanksMessage(tree:FuncTree) : void
      {
         this._achievementsPioneerRankstree = tree.addChild(this._achievementsPioneerRankstreeFunc);
      }
      
      private function _achievementsPioneerRankstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._achievementsPioneerRankstree.addChild(this._achievementsPioneerRanksFunc);
         }
      }
      
      private function _achievementsPioneerRanksFunc(input:ICustomDataInput) : void
      {
         var _item:AchievementPioneerRank = new AchievementPioneerRank();
         _item.deserialize(input);
         this.achievementsPioneerRanks.push(_item);
      }
   }
}
