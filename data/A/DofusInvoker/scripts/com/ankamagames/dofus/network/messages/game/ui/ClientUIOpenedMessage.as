package com.ankamagames.dofus.network.messages.game.ui
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ClientUIOpenedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2590;
       
      
      private var _isInitialized:Boolean = false;
      
      public var type:uint = 0;
      
      public function ClientUIOpenedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2590;
      }
      
      public function initClientUIOpenedMessage(type:uint = 0) : ClientUIOpenedMessage
      {
         this.type = type;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
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
         this.serializeAs_ClientUIOpenedMessage(output);
      }
      
      public function serializeAs_ClientUIOpenedMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.type);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ClientUIOpenedMessage(input);
      }
      
      public function deserializeAs_ClientUIOpenedMessage(input:ICustomDataInput) : void
      {
         this._typeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ClientUIOpenedMessage(tree);
      }
      
      public function deserializeAsyncAs_ClientUIOpenedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._typeFunc);
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of ClientUIOpenedMessage.type.");
         }
      }
   }
}
