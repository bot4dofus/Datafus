package com.ankamagames.dofus.network.messages.game.context.roleplay.breach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachExitResponseMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4083;
       
      
      private var _isInitialized:Boolean = false;
      
      public var exited:Boolean = false;
      
      public function BreachExitResponseMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4083;
      }
      
      public function initBreachExitResponseMessage(exited:Boolean = false) : BreachExitResponseMessage
      {
         this.exited = exited;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.exited = false;
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
         this.serializeAs_BreachExitResponseMessage(output);
      }
      
      public function serializeAs_BreachExitResponseMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.exited);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachExitResponseMessage(input);
      }
      
      public function deserializeAs_BreachExitResponseMessage(input:ICustomDataInput) : void
      {
         this._exitedFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachExitResponseMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachExitResponseMessage(tree:FuncTree) : void
      {
         tree.addChild(this._exitedFunc);
      }
      
      private function _exitedFunc(input:ICustomDataInput) : void
      {
         this.exited = input.readBoolean();
      }
   }
}
