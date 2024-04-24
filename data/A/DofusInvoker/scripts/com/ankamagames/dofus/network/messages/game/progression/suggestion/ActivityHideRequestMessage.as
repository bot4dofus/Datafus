package com.ankamagames.dofus.network.messages.game.progression.suggestion
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ActivityHideRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8594;
       
      
      private var _isInitialized:Boolean = false;
      
      public var activityId:uint = 0;
      
      public function ActivityHideRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8594;
      }
      
      public function initActivityHideRequestMessage(activityId:uint = 0) : ActivityHideRequestMessage
      {
         this.activityId = activityId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.activityId = 0;
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
         this.serializeAs_ActivityHideRequestMessage(output);
      }
      
      public function serializeAs_ActivityHideRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.activityId < 0)
         {
            throw new Error("Forbidden value (" + this.activityId + ") on element activityId.");
         }
         output.writeVarShort(this.activityId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ActivityHideRequestMessage(input);
      }
      
      public function deserializeAs_ActivityHideRequestMessage(input:ICustomDataInput) : void
      {
         this._activityIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ActivityHideRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_ActivityHideRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._activityIdFunc);
      }
      
      private function _activityIdFunc(input:ICustomDataInput) : void
      {
         this.activityId = input.readVarUhShort();
         if(this.activityId < 0)
         {
            throw new Error("Forbidden value (" + this.activityId + ") on element of ActivityHideRequestMessage.activityId.");
         }
      }
   }
}
