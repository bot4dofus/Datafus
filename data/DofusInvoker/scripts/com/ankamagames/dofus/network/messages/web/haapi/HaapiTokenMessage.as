package com.ankamagames.dofus.network.messages.web.haapi
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HaapiTokenMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3474;
       
      
      private var _isInitialized:Boolean = false;
      
      public var token:String = "";
      
      public function HaapiTokenMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3474;
      }
      
      public function initHaapiTokenMessage(token:String = "") : HaapiTokenMessage
      {
         this.token = token;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.token = "";
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
         this.serializeAs_HaapiTokenMessage(output);
      }
      
      public function serializeAs_HaapiTokenMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.token);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HaapiTokenMessage(input);
      }
      
      public function deserializeAs_HaapiTokenMessage(input:ICustomDataInput) : void
      {
         this._tokenFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HaapiTokenMessage(tree);
      }
      
      public function deserializeAsyncAs_HaapiTokenMessage(tree:FuncTree) : void
      {
         tree.addChild(this._tokenFunc);
      }
      
      private function _tokenFunc(input:ICustomDataInput) : void
      {
         this.token = input.readUTF();
      }
   }
}
