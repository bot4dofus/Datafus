package com.ankamagames.dofus.network.messages.game.context.roleplay.document
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class DocumentReadingBeginMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6514;
       
      
      private var _isInitialized:Boolean = false;
      
      public var documentId:uint = 0;
      
      public function DocumentReadingBeginMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6514;
      }
      
      public function initDocumentReadingBeginMessage(documentId:uint = 0) : DocumentReadingBeginMessage
      {
         this.documentId = documentId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.documentId = 0;
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
         this.serializeAs_DocumentReadingBeginMessage(output);
      }
      
      public function serializeAs_DocumentReadingBeginMessage(output:ICustomDataOutput) : void
      {
         if(this.documentId < 0)
         {
            throw new Error("Forbidden value (" + this.documentId + ") on element documentId.");
         }
         output.writeVarShort(this.documentId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DocumentReadingBeginMessage(input);
      }
      
      public function deserializeAs_DocumentReadingBeginMessage(input:ICustomDataInput) : void
      {
         this._documentIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DocumentReadingBeginMessage(tree);
      }
      
      public function deserializeAsyncAs_DocumentReadingBeginMessage(tree:FuncTree) : void
      {
         tree.addChild(this._documentIdFunc);
      }
      
      private function _documentIdFunc(input:ICustomDataInput) : void
      {
         this.documentId = input.readVarUhShort();
         if(this.documentId < 0)
         {
            throw new Error("Forbidden value (" + this.documentId + ") on element of DocumentReadingBeginMessage.documentId.");
         }
      }
   }
}
