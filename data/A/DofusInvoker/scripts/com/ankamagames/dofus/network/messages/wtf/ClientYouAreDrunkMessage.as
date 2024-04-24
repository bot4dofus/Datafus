package com.ankamagames.dofus.network.messages.wtf
{
   import com.ankamagames.dofus.network.messages.debug.DebugInClientMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ClientYouAreDrunkMessage extends DebugInClientMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3378;
       
      
      private var _isInitialized:Boolean = false;
      
      public function ClientYouAreDrunkMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3378;
      }
      
      public function initClientYouAreDrunkMessage(level:uint = 0, message:String = "") : ClientYouAreDrunkMessage
      {
         super.initDebugInClientMessage(level,message);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
         this.serializeAs_ClientYouAreDrunkMessage(output);
      }
      
      public function serializeAs_ClientYouAreDrunkMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_DebugInClientMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ClientYouAreDrunkMessage(input);
      }
      
      public function deserializeAs_ClientYouAreDrunkMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ClientYouAreDrunkMessage(tree);
      }
      
      public function deserializeAsyncAs_ClientYouAreDrunkMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
