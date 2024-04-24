package com.ankamagames.dofus.network.messages.security
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CheckFileMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2644;
       
      
      private var _isInitialized:Boolean = false;
      
      public var filenameHash:String = "";
      
      public var type:uint = 0;
      
      public var value:String = "";
      
      public function CheckFileMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2644;
      }
      
      public function initCheckFileMessage(filenameHash:String = "", type:uint = 0, value:String = "") : CheckFileMessage
      {
         this.filenameHash = filenameHash;
         this.type = type;
         this.value = value;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.filenameHash = "";
         this.type = 0;
         this.value = "";
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
         this.serializeAs_CheckFileMessage(output);
      }
      
      public function serializeAs_CheckFileMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.filenameHash);
         output.writeByte(this.type);
         output.writeUTF(this.value);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CheckFileMessage(input);
      }
      
      public function deserializeAs_CheckFileMessage(input:ICustomDataInput) : void
      {
         this._filenameHashFunc(input);
         this._typeFunc(input);
         this._valueFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CheckFileMessage(tree);
      }
      
      public function deserializeAsyncAs_CheckFileMessage(tree:FuncTree) : void
      {
         tree.addChild(this._filenameHashFunc);
         tree.addChild(this._typeFunc);
         tree.addChild(this._valueFunc);
      }
      
      private function _filenameHashFunc(input:ICustomDataInput) : void
      {
         this.filenameHash = input.readUTF();
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of CheckFileMessage.type.");
         }
      }
      
      private function _valueFunc(input:ICustomDataInput) : void
      {
         this.value = input.readUTF();
      }
   }
}
