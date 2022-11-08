package com.ankamagames.dofus.network.messages.authorized
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AdminCommandMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5319;
       
      
      private var _isInitialized:Boolean = false;
      
      public var content:String = "";
      
      public function AdminCommandMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5319;
      }
      
      public function initAdminCommandMessage(content:String = "") : AdminCommandMessage
      {
         this.content = content;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
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
         this.serializeAs_AdminCommandMessage(output);
      }
      
      public function serializeAs_AdminCommandMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.content);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AdminCommandMessage(input);
      }
      
      public function deserializeAs_AdminCommandMessage(input:ICustomDataInput) : void
      {
         this._contentFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AdminCommandMessage(tree);
      }
      
      public function deserializeAsyncAs_AdminCommandMessage(tree:FuncTree) : void
      {
         tree.addChild(this._contentFunc);
      }
      
      private function _contentFunc(input:ICustomDataInput) : void
      {
         this.content = input.readUTF();
      }
   }
}
