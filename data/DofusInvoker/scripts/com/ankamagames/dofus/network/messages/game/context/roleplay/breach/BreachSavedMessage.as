package com.ankamagames.dofus.network.messages.game.context.roleplay.breach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachSavedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6031;
       
      
      private var _isInitialized:Boolean = false;
      
      public var saved:Boolean = false;
      
      public function BreachSavedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6031;
      }
      
      public function initBreachSavedMessage(saved:Boolean = false) : BreachSavedMessage
      {
         this.saved = saved;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.saved = false;
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
         this.serializeAs_BreachSavedMessage(output);
      }
      
      public function serializeAs_BreachSavedMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.saved);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachSavedMessage(input);
      }
      
      public function deserializeAs_BreachSavedMessage(input:ICustomDataInput) : void
      {
         this._savedFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachSavedMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachSavedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._savedFunc);
      }
      
      private function _savedFunc(input:ICustomDataInput) : void
      {
         this.saved = input.readBoolean();
      }
   }
}
