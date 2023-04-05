package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PrismUseRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 751;
       
      
      private var _isInitialized:Boolean = false;
      
      public var moduleToUse:uint = 0;
      
      public function PrismUseRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 751;
      }
      
      public function initPrismUseRequestMessage(moduleToUse:uint = 0) : PrismUseRequestMessage
      {
         this.moduleToUse = moduleToUse;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.moduleToUse = 0;
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
         this.serializeAs_PrismUseRequestMessage(output);
      }
      
      public function serializeAs_PrismUseRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.moduleToUse);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismUseRequestMessage(input);
      }
      
      public function deserializeAs_PrismUseRequestMessage(input:ICustomDataInput) : void
      {
         this._moduleToUseFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismUseRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismUseRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._moduleToUseFunc);
      }
      
      private function _moduleToUseFunc(input:ICustomDataInput) : void
      {
         this.moduleToUse = input.readByte();
         if(this.moduleToUse < 0)
         {
            throw new Error("Forbidden value (" + this.moduleToUse + ") on element of PrismUseRequestMessage.moduleToUse.");
         }
      }
   }
}
