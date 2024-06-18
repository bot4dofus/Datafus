package com.ankamagames.dofus.network.messages.game.context.display
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class DisplayNumericalValuePaddockMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4632;
       
      
      private var _isInitialized:Boolean = false;
      
      public var rideId:int = 0;
      
      public var value:int = 0;
      
      public var type:uint = 0;
      
      public function DisplayNumericalValuePaddockMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4632;
      }
      
      public function initDisplayNumericalValuePaddockMessage(rideId:int = 0, value:int = 0, type:uint = 0) : DisplayNumericalValuePaddockMessage
      {
         this.rideId = rideId;
         this.value = value;
         this.type = type;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.rideId = 0;
         this.value = 0;
         this.type = 0;
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
         this.serializeAs_DisplayNumericalValuePaddockMessage(output);
      }
      
      public function serializeAs_DisplayNumericalValuePaddockMessage(output:ICustomDataOutput) : void
      {
         output.writeInt(this.rideId);
         output.writeInt(this.value);
         output.writeByte(this.type);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DisplayNumericalValuePaddockMessage(input);
      }
      
      public function deserializeAs_DisplayNumericalValuePaddockMessage(input:ICustomDataInput) : void
      {
         this._rideIdFunc(input);
         this._valueFunc(input);
         this._typeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DisplayNumericalValuePaddockMessage(tree);
      }
      
      public function deserializeAsyncAs_DisplayNumericalValuePaddockMessage(tree:FuncTree) : void
      {
         tree.addChild(this._rideIdFunc);
         tree.addChild(this._valueFunc);
         tree.addChild(this._typeFunc);
      }
      
      private function _rideIdFunc(input:ICustomDataInput) : void
      {
         this.rideId = input.readInt();
      }
      
      private function _valueFunc(input:ICustomDataInput) : void
      {
         this.value = input.readInt();
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of DisplayNumericalValuePaddockMessage.type.");
         }
      }
   }
}
