package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class JobAllowMultiCraftRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1737;
       
      
      private var _isInitialized:Boolean = false;
      
      public var enabled:Boolean = false;
      
      public function JobAllowMultiCraftRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1737;
      }
      
      public function initJobAllowMultiCraftRequestMessage(enabled:Boolean = false) : JobAllowMultiCraftRequestMessage
      {
         this.enabled = enabled;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.enabled = false;
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
         this.serializeAs_JobAllowMultiCraftRequestMessage(output);
      }
      
      public function serializeAs_JobAllowMultiCraftRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.enabled);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobAllowMultiCraftRequestMessage(input);
      }
      
      public function deserializeAs_JobAllowMultiCraftRequestMessage(input:ICustomDataInput) : void
      {
         this._enabledFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobAllowMultiCraftRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_JobAllowMultiCraftRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._enabledFunc);
      }
      
      private function _enabledFunc(input:ICustomDataInput) : void
      {
         this.enabled = input.readBoolean();
      }
   }
}
