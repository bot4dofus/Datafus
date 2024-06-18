package com.ankamagames.dofus.network.messages.game.interactive
{
   import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class StatedElementUpdatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7859;
       
      
      private var _isInitialized:Boolean = false;
      
      public var statedElement:StatedElement;
      
      private var _statedElementtree:FuncTree;
      
      public function StatedElementUpdatedMessage()
      {
         this.statedElement = new StatedElement();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7859;
      }
      
      public function initStatedElementUpdatedMessage(statedElement:StatedElement = null) : StatedElementUpdatedMessage
      {
         this.statedElement = statedElement;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.statedElement = new StatedElement();
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
         this.serializeAs_StatedElementUpdatedMessage(output);
      }
      
      public function serializeAs_StatedElementUpdatedMessage(output:ICustomDataOutput) : void
      {
         this.statedElement.serializeAs_StatedElement(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StatedElementUpdatedMessage(input);
      }
      
      public function deserializeAs_StatedElementUpdatedMessage(input:ICustomDataInput) : void
      {
         this.statedElement = new StatedElement();
         this.statedElement.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StatedElementUpdatedMessage(tree);
      }
      
      public function deserializeAsyncAs_StatedElementUpdatedMessage(tree:FuncTree) : void
      {
         this._statedElementtree = tree.addChild(this._statedElementtreeFunc);
      }
      
      private function _statedElementtreeFunc(input:ICustomDataInput) : void
      {
         this.statedElement = new StatedElement();
         this.statedElement.deserializeAsync(this._statedElementtree);
      }
   }
}
