package com.ankamagames.dofus.network.messages.game.interactive
{
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class InteractiveElementUpdatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6391;
       
      
      private var _isInitialized:Boolean = false;
      
      public var interactiveElement:InteractiveElement;
      
      private var _interactiveElementtree:FuncTree;
      
      public function InteractiveElementUpdatedMessage()
      {
         this.interactiveElement = new InteractiveElement();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6391;
      }
      
      public function initInteractiveElementUpdatedMessage(interactiveElement:InteractiveElement = null) : InteractiveElementUpdatedMessage
      {
         this.interactiveElement = interactiveElement;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.interactiveElement = new InteractiveElement();
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
         this.serializeAs_InteractiveElementUpdatedMessage(output);
      }
      
      public function serializeAs_InteractiveElementUpdatedMessage(output:ICustomDataOutput) : void
      {
         this.interactiveElement.serializeAs_InteractiveElement(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InteractiveElementUpdatedMessage(input);
      }
      
      public function deserializeAs_InteractiveElementUpdatedMessage(input:ICustomDataInput) : void
      {
         this.interactiveElement = new InteractiveElement();
         this.interactiveElement.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InteractiveElementUpdatedMessage(tree);
      }
      
      public function deserializeAsyncAs_InteractiveElementUpdatedMessage(tree:FuncTree) : void
      {
         this._interactiveElementtree = tree.addChild(this._interactiveElementtreeFunc);
      }
      
      private function _interactiveElementtreeFunc(input:ICustomDataInput) : void
      {
         this.interactiveElement = new InteractiveElement();
         this.interactiveElement.deserializeAsync(this._interactiveElementtree);
      }
   }
}
