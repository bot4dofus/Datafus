package com.ankamagames.dofus.network.messages.game.context.roleplay.document
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class OpenGuideBookMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3314;
       
      
      private var _isInitialized:Boolean = false;
      
      public var articleId:uint = 0;
      
      public function OpenGuideBookMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3314;
      }
      
      public function initOpenGuideBookMessage(articleId:uint = 0) : OpenGuideBookMessage
      {
         this.articleId = articleId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.articleId = 0;
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
         this.serializeAs_OpenGuideBookMessage(output);
      }
      
      public function serializeAs_OpenGuideBookMessage(output:ICustomDataOutput) : void
      {
         if(this.articleId < 0)
         {
            throw new Error("Forbidden value (" + this.articleId + ") on element articleId.");
         }
         output.writeVarShort(this.articleId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_OpenGuideBookMessage(input);
      }
      
      public function deserializeAs_OpenGuideBookMessage(input:ICustomDataInput) : void
      {
         this._articleIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_OpenGuideBookMessage(tree);
      }
      
      public function deserializeAsyncAs_OpenGuideBookMessage(tree:FuncTree) : void
      {
         tree.addChild(this._articleIdFunc);
      }
      
      private function _articleIdFunc(input:ICustomDataInput) : void
      {
         this.articleId = input.readVarUhShort();
         if(this.articleId < 0)
         {
            throw new Error("Forbidden value (" + this.articleId + ") on element of OpenGuideBookMessage.articleId.");
         }
      }
   }
}
