package com.ankamagames.dofus.network.messages.security
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ClientKeyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7975;
       
      
      private var _isInitialized:Boolean = false;
      
      public var key:String = "";
      
      public function ClientKeyMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7975;
      }
      
      public function initClientKeyMessage(key:String = "") : ClientKeyMessage
      {
         this.key = key;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.key = "";
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
         this.serializeAs_ClientKeyMessage(output);
      }
      
      public function serializeAs_ClientKeyMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.key);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ClientKeyMessage(input);
      }
      
      public function deserializeAs_ClientKeyMessage(input:ICustomDataInput) : void
      {
         this._keyFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ClientKeyMessage(tree);
      }
      
      public function deserializeAsyncAs_ClientKeyMessage(tree:FuncTree) : void
      {
         tree.addChild(this._keyFunc);
      }
      
      private function _keyFunc(input:ICustomDataInput) : void
      {
         this.key = input.readUTF();
      }
   }
}
