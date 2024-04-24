package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobExperience;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class JobExperienceUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9580;
       
      
      private var _isInitialized:Boolean = false;
      
      public var experiencesUpdate:JobExperience;
      
      private var _experiencesUpdatetree:FuncTree;
      
      public function JobExperienceUpdateMessage()
      {
         this.experiencesUpdate = new JobExperience();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9580;
      }
      
      public function initJobExperienceUpdateMessage(experiencesUpdate:JobExperience = null) : JobExperienceUpdateMessage
      {
         this.experiencesUpdate = experiencesUpdate;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.experiencesUpdate = new JobExperience();
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
         this.serializeAs_JobExperienceUpdateMessage(output);
      }
      
      public function serializeAs_JobExperienceUpdateMessage(output:ICustomDataOutput) : void
      {
         this.experiencesUpdate.serializeAs_JobExperience(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobExperienceUpdateMessage(input);
      }
      
      public function deserializeAs_JobExperienceUpdateMessage(input:ICustomDataInput) : void
      {
         this.experiencesUpdate = new JobExperience();
         this.experiencesUpdate.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobExperienceUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_JobExperienceUpdateMessage(tree:FuncTree) : void
      {
         this._experiencesUpdatetree = tree.addChild(this._experiencesUpdatetreeFunc);
      }
      
      private function _experiencesUpdatetreeFunc(input:ICustomDataInput) : void
      {
         this.experiencesUpdate = new JobExperience();
         this.experiencesUpdate.deserializeAsync(this._experiencesUpdatetree);
      }
   }
}
