package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobDescription;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class JobLevelUpMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8322;
       
      
      private var _isInitialized:Boolean = false;
      
      public var newLevel:uint = 0;
      
      public var jobsDescription:JobDescription;
      
      private var _jobsDescriptiontree:FuncTree;
      
      public function JobLevelUpMessage()
      {
         this.jobsDescription = new JobDescription();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8322;
      }
      
      public function initJobLevelUpMessage(newLevel:uint = 0, jobsDescription:JobDescription = null) : JobLevelUpMessage
      {
         this.newLevel = newLevel;
         this.jobsDescription = jobsDescription;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.newLevel = 0;
         this.jobsDescription = new JobDescription();
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
         this.serializeAs_JobLevelUpMessage(output);
      }
      
      public function serializeAs_JobLevelUpMessage(output:ICustomDataOutput) : void
      {
         if(this.newLevel < 0 || this.newLevel > 255)
         {
            throw new Error("Forbidden value (" + this.newLevel + ") on element newLevel.");
         }
         output.writeByte(this.newLevel);
         this.jobsDescription.serializeAs_JobDescription(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobLevelUpMessage(input);
      }
      
      public function deserializeAs_JobLevelUpMessage(input:ICustomDataInput) : void
      {
         this._newLevelFunc(input);
         this.jobsDescription = new JobDescription();
         this.jobsDescription.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobLevelUpMessage(tree);
      }
      
      public function deserializeAsyncAs_JobLevelUpMessage(tree:FuncTree) : void
      {
         tree.addChild(this._newLevelFunc);
         this._jobsDescriptiontree = tree.addChild(this._jobsDescriptiontreeFunc);
      }
      
      private function _newLevelFunc(input:ICustomDataInput) : void
      {
         this.newLevel = input.readUnsignedByte();
         if(this.newLevel < 0 || this.newLevel > 255)
         {
            throw new Error("Forbidden value (" + this.newLevel + ") on element of JobLevelUpMessage.newLevel.");
         }
      }
      
      private function _jobsDescriptiontreeFunc(input:ICustomDataInput) : void
      {
         this.jobsDescription = new JobDescription();
         this.jobsDescription.deserializeAsync(this._jobsDescriptiontree);
      }
   }
}
