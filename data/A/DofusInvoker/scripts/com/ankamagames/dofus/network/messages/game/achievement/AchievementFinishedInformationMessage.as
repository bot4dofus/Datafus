package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.dofus.network.types.game.achievement.AchievementAchievedRewardable;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AchievementFinishedInformationMessage extends AchievementFinishedMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6691;
       
      
      private var _isInitialized:Boolean = false;
      
      public var name:String = "";
      
      public var playerId:Number = 0;
      
      public function AchievementFinishedInformationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6691;
      }
      
      public function initAchievementFinishedInformationMessage(achievement:AchievementAchievedRewardable = null, name:String = "", playerId:Number = 0) : AchievementFinishedInformationMessage
      {
         super.initAchievementFinishedMessage(achievement);
         this.name = name;
         this.playerId = playerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.name = "";
         this.playerId = 0;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AchievementFinishedInformationMessage(output);
      }
      
      public function serializeAs_AchievementFinishedInformationMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AchievementFinishedMessage(output);
         output.writeUTF(this.name);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementFinishedInformationMessage(input);
      }
      
      public function deserializeAs_AchievementFinishedInformationMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._nameFunc(input);
         this._playerIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementFinishedInformationMessage(tree);
      }
      
      public function deserializeAsyncAs_AchievementFinishedInformationMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nameFunc);
         tree.addChild(this._playerIdFunc);
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of AchievementFinishedInformationMessage.playerId.");
         }
      }
   }
}
