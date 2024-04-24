package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class JobBookSubscription implements INetworkType
   {
      
      public static const protocolId:uint = 5877;
       
      
      public var jobId:uint = 0;
      
      public var subscribed:Boolean = false;
      
      public function JobBookSubscription()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 5877;
      }
      
      public function initJobBookSubscription(jobId:uint = 0, subscribed:Boolean = false) : JobBookSubscription
      {
         this.jobId = jobId;
         this.subscribed = subscribed;
         return this;
      }
      
      public function reset() : void
      {
         this.jobId = 0;
         this.subscribed = false;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_JobBookSubscription(output);
      }
      
      public function serializeAs_JobBookSubscription(output:ICustomDataOutput) : void
      {
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
         }
         output.writeByte(this.jobId);
         output.writeBoolean(this.subscribed);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobBookSubscription(input);
      }
      
      public function deserializeAs_JobBookSubscription(input:ICustomDataInput) : void
      {
         this._jobIdFunc(input);
         this._subscribedFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobBookSubscription(tree);
      }
      
      public function deserializeAsyncAs_JobBookSubscription(tree:FuncTree) : void
      {
         tree.addChild(this._jobIdFunc);
         tree.addChild(this._subscribedFunc);
      }
      
      private function _jobIdFunc(input:ICustomDataInput) : void
      {
         this.jobId = input.readByte();
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element of JobBookSubscription.jobId.");
         }
      }
      
      private function _subscribedFunc(input:ICustomDataInput) : void
      {
         this.subscribed = input.readBoolean();
      }
   }
}
