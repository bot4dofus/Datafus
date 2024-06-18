package com.ankamagames.dofus.network.messages.game.nuggets
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class NuggetsInformationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5214;
       
      
      private var _isInitialized:Boolean = false;
      
      public var nuggetsQuantity:int = 0;
      
      public function NuggetsInformationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5214;
      }
      
      public function initNuggetsInformationMessage(nuggetsQuantity:int = 0) : NuggetsInformationMessage
      {
         this.nuggetsQuantity = nuggetsQuantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.nuggetsQuantity = 0;
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
         this.serializeAs_NuggetsInformationMessage(output);
      }
      
      public function serializeAs_NuggetsInformationMessage(output:ICustomDataOutput) : void
      {
         output.writeInt(this.nuggetsQuantity);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_NuggetsInformationMessage(input);
      }
      
      public function deserializeAs_NuggetsInformationMessage(input:ICustomDataInput) : void
      {
         this._nuggetsQuantityFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_NuggetsInformationMessage(tree);
      }
      
      public function deserializeAsyncAs_NuggetsInformationMessage(tree:FuncTree) : void
      {
         tree.addChild(this._nuggetsQuantityFunc);
      }
      
      private function _nuggetsQuantityFunc(input:ICustomDataInput) : void
      {
         this.nuggetsQuantity = input.readInt();
      }
   }
}
