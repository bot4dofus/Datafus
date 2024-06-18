package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class JobCrafterDirectoryRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3245;
       
      
      private var _isInitialized:Boolean = false;
      
      public var jobId:uint = 0;
      
      public var playerId:Number = 0;
      
      public function JobCrafterDirectoryRemoveMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3245;
      }
      
      public function initJobCrafterDirectoryRemoveMessage(jobId:uint = 0, playerId:Number = 0) : JobCrafterDirectoryRemoveMessage
      {
         this.jobId = jobId;
         this.playerId = playerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.jobId = 0;
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
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_JobCrafterDirectoryRemoveMessage(output);
      }
      
      public function serializeAs_JobCrafterDirectoryRemoveMessage(output:ICustomDataOutput) : void
      {
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
         }
         output.writeByte(this.jobId);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobCrafterDirectoryRemoveMessage(input);
      }
      
      public function deserializeAs_JobCrafterDirectoryRemoveMessage(input:ICustomDataInput) : void
      {
         this._jobIdFunc(input);
         this._playerIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobCrafterDirectoryRemoveMessage(tree);
      }
      
      public function deserializeAsyncAs_JobCrafterDirectoryRemoveMessage(tree:FuncTree) : void
      {
         tree.addChild(this._jobIdFunc);
         tree.addChild(this._playerIdFunc);
      }
      
      private function _jobIdFunc(input:ICustomDataInput) : void
      {
         this.jobId = input.readByte();
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element of JobCrafterDirectoryRemoveMessage.jobId.");
         }
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of JobCrafterDirectoryRemoveMessage.playerId.");
         }
      }
   }
}
