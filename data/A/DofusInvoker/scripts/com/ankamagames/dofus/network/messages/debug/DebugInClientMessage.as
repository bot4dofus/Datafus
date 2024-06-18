package com.ankamagames.dofus.network.messages.debug
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class DebugInClientMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6256;
       
      
      private var _isInitialized:Boolean = false;
      
      public var level:uint = 0;
      
      public var message:String = "";
      
      public function DebugInClientMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6256;
      }
      
      public function initDebugInClientMessage(level:uint = 0, message:String = "") : DebugInClientMessage
      {
         this.level = level;
         this.message = message;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.level = 0;
         this.message = "";
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
         this.serializeAs_DebugInClientMessage(output);
      }
      
      public function serializeAs_DebugInClientMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.level);
         output.writeUTF(this.message);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DebugInClientMessage(input);
      }
      
      public function deserializeAs_DebugInClientMessage(input:ICustomDataInput) : void
      {
         this._levelFunc(input);
         this._messageFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DebugInClientMessage(tree);
      }
      
      public function deserializeAsyncAs_DebugInClientMessage(tree:FuncTree) : void
      {
         tree.addChild(this._levelFunc);
         tree.addChild(this._messageFunc);
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readByte();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of DebugInClientMessage.level.");
         }
      }
      
      private function _messageFunc(input:ICustomDataInput) : void
      {
         this.message = input.readUTF();
      }
   }
}
