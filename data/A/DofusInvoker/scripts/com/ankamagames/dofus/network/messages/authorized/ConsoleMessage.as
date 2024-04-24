package com.ankamagames.dofus.network.messages.authorized
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ConsoleMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4821;
       
      
      private var _isInitialized:Boolean = false;
      
      public var type:uint = 0;
      
      public var content:String = "";
      
      public function ConsoleMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4821;
      }
      
      public function initConsoleMessage(type:uint = 0, content:String = "") : ConsoleMessage
      {
         this.type = type;
         this.content = content;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.type = 0;
         this.content = "";
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
         this.serializeAs_ConsoleMessage(output);
      }
      
      public function serializeAs_ConsoleMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.type);
         output.writeUTF(this.content);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ConsoleMessage(input);
      }
      
      public function deserializeAs_ConsoleMessage(input:ICustomDataInput) : void
      {
         this._typeFunc(input);
         this._contentFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ConsoleMessage(tree);
      }
      
      public function deserializeAsyncAs_ConsoleMessage(tree:FuncTree) : void
      {
         tree.addChild(this._typeFunc);
         tree.addChild(this._contentFunc);
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of ConsoleMessage.type.");
         }
      }
      
      private function _contentFunc(input:ICustomDataInput) : void
      {
         this.content = input.readUTF();
      }
   }
}
