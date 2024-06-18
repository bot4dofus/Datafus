package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementAchieved;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AchievementListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9652;
       
      
      private var _isInitialized:Boolean = false;
      
      public var finishedAchievements:Vector.<AchievementAchieved>;
      
      private var _finishedAchievementstree:FuncTree;
      
      public function AchievementListMessage()
      {
         this.finishedAchievements = new Vector.<AchievementAchieved>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9652;
      }
      
      public function initAchievementListMessage(finishedAchievements:Vector.<AchievementAchieved> = null) : AchievementListMessage
      {
         this.finishedAchievements = finishedAchievements;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.finishedAchievements = new Vector.<AchievementAchieved>();
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
         this.serializeAs_AchievementListMessage(output);
      }
      
      public function serializeAs_AchievementListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.finishedAchievements.length);
         for(var _i1:uint = 0; _i1 < this.finishedAchievements.length; _i1++)
         {
            output.writeShort((this.finishedAchievements[_i1] as AchievementAchieved).getTypeId());
            (this.finishedAchievements[_i1] as AchievementAchieved).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementListMessage(input);
      }
      
      public function deserializeAs_AchievementListMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:AchievementAchieved = null;
         var _finishedAchievementsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _finishedAchievementsLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(AchievementAchieved,_id1);
            _item1.deserialize(input);
            this.finishedAchievements.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementListMessage(tree);
      }
      
      public function deserializeAsyncAs_AchievementListMessage(tree:FuncTree) : void
      {
         this._finishedAchievementstree = tree.addChild(this._finishedAchievementstreeFunc);
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
         var _id:uint = input.readUnsignedShort();
         var _item:AchievementAchieved = ProtocolTypeManager.getInstance(AchievementAchieved,_id);
         _item.deserialize(input);
         this.finishedAchievements.push(_item);
      }
   }
}
