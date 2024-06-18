package com.ankamagames.dofus.network.messages.authorized
{
   import com.ankamagames.dofus.network.types.game.Uuid;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AdminCommandMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9773;
       
      
      private var _isInitialized:Boolean = false;
      
      public var messageUuid:Uuid;
      
      public var content:String = "";
      
      private var _messageUuidtree:FuncTree;
      
      public function AdminCommandMessage()
      {
         this.messageUuid = new Uuid();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9773;
      }
      
      public function initAdminCommandMessage(messageUuid:Uuid = null, content:String = "") : AdminCommandMessage
      {
         this.messageUuid = messageUuid;
         this.content = content;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.messageUuid = new Uuid();
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
         this.messageUuid.serializeAs_Uuid(output);
         output.writeUTF(this.content);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AdminCommandMessage(input);
      }
      
      public function deserializeAs_AdminCommandMessage(input:ICustomDataInput) : void
      {
         this.messageUuid = new Uuid();
         this.messageUuid.deserialize(input);
         this._contentFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AdminCommandMessage(tree);
      }
      
      public function deserializeAsyncAs_AdminCommandMessage(tree:FuncTree) : void
      {
         this._messageUuidtree = tree.addChild(this._messageUuidtreeFunc);
         tree.addChild(this._contentFunc);
      }
      
      private function _messageUuidtreeFunc(input:ICustomDataInput) : void
      {
         this.messageUuid = new Uuid();
         this.messageUuid.deserializeAsync(this._messageUuidtree);
      }
      
      private function _contentFunc(input:ICustomDataInput) : void
      {
         this.content = input.readUTF();
      }
   }
}
