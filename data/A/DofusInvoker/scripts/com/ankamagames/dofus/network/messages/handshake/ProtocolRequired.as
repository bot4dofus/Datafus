package com.ankamagames.dofus.network.messages.handshake
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ProtocolRequired extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1939;
       
      
      private var _isInitialized:Boolean = false;
      
      public var version:String = "";
      
      public function ProtocolRequired()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1939;
      }
      
      public function initProtocolRequired(version:String = "") : ProtocolRequired
      {
         this.version = version;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.version = "";
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
         this.serializeAs_ProtocolRequired(output);
      }
      
      public function serializeAs_ProtocolRequired(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.version);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ProtocolRequired(input);
      }
      
      public function deserializeAs_ProtocolRequired(input:ICustomDataInput) : void
      {
         this._versionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ProtocolRequired(tree);
      }
      
      public function deserializeAsyncAs_ProtocolRequired(tree:FuncTree) : void
      {
         tree.addChild(this._versionFunc);
      }
      
      private function _versionFunc(input:ICustomDataInput) : void
      {
         this.version = input.readUTF();
      }
   }
}
