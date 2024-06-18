package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobExperience;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class JobExperienceOtherPlayerUpdateMessage extends JobExperienceUpdateMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1331;
       
      
      private var _isInitialized:Boolean = false;
      
      public var playerId:Number = 0;
      
      public function JobExperienceOtherPlayerUpdateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1331;
      }
      
      public function initJobExperienceOtherPlayerUpdateMessage(experiencesUpdate:JobExperience = null, playerId:Number = 0) : JobExperienceOtherPlayerUpdateMessage
      {
         super.initJobExperienceUpdateMessage(experiencesUpdate);
         this.playerId = playerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
         this.serializeAs_JobExperienceOtherPlayerUpdateMessage(output);
      }
      
      public function serializeAs_JobExperienceOtherPlayerUpdateMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_JobExperienceUpdateMessage(output);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobExperienceOtherPlayerUpdateMessage(input);
      }
      
      public function deserializeAs_JobExperienceOtherPlayerUpdateMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._playerIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobExperienceOtherPlayerUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_JobExperienceOtherPlayerUpdateMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._playerIdFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of JobExperienceOtherPlayerUpdateMessage.playerId.");
         }
      }
   }
}
