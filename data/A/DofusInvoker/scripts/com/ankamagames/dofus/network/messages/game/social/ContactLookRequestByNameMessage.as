package com.ankamagames.dofus.network.messages.game.social
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ContactLookRequestByNameMessage extends ContactLookRequestMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2776;
       
      
      private var _isInitialized:Boolean = false;
      
      public var playerName:String = "";
      
      public function ContactLookRequestByNameMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2776;
      }
      
      public function initContactLookRequestByNameMessage(requestId:uint = 0, contactType:uint = 0, playerName:String = "") : ContactLookRequestByNameMessage
      {
         super.initContactLookRequestMessage(requestId,contactType);
         this.playerName = playerName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.playerName = "";
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ContactLookRequestByNameMessage(output);
      }
      
      public function serializeAs_ContactLookRequestByNameMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ContactLookRequestMessage(output);
         output.writeUTF(this.playerName);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ContactLookRequestByNameMessage(input);
      }
      
      public function deserializeAs_ContactLookRequestByNameMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._playerNameFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ContactLookRequestByNameMessage(tree);
      }
      
      public function deserializeAsyncAs_ContactLookRequestByNameMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._playerNameFunc);
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
   }
}
