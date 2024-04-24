package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameContextRemoveElementWithEventMessage extends GameContextRemoveElementMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1450;
       
      
      private var _isInitialized:Boolean = false;
      
      public var elementEventId:uint = 0;
      
      public function GameContextRemoveElementWithEventMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1450;
      }
      
      public function initGameContextRemoveElementWithEventMessage(id:Number = 0, elementEventId:uint = 0) : GameContextRemoveElementWithEventMessage
      {
         super.initGameContextRemoveElementMessage(id);
         this.elementEventId = elementEventId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.elementEventId = 0;
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
         this.serializeAs_GameContextRemoveElementWithEventMessage(output);
      }
      
      public function serializeAs_GameContextRemoveElementWithEventMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameContextRemoveElementMessage(output);
         if(this.elementEventId < 0)
         {
            throw new Error("Forbidden value (" + this.elementEventId + ") on element elementEventId.");
         }
         output.writeByte(this.elementEventId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameContextRemoveElementWithEventMessage(input);
      }
      
      public function deserializeAs_GameContextRemoveElementWithEventMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._elementEventIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameContextRemoveElementWithEventMessage(tree);
      }
      
      public function deserializeAsyncAs_GameContextRemoveElementWithEventMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._elementEventIdFunc);
      }
      
      private function _elementEventIdFunc(input:ICustomDataInput) : void
      {
         this.elementEventId = input.readByte();
         if(this.elementEventId < 0)
         {
            throw new Error("Forbidden value (" + this.elementEventId + ") on element of GameContextRemoveElementWithEventMessage.elementEventId.");
         }
      }
   }
}
