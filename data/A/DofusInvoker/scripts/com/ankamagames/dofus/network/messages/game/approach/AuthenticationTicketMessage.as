package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AuthenticationTicketMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2950;
       
      
      private var _isInitialized:Boolean = false;
      
      public var lang:String = "";
      
      public var ticket:String = "";
      
      public function AuthenticationTicketMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2950;
      }
      
      public function initAuthenticationTicketMessage(lang:String = "", ticket:String = "") : AuthenticationTicketMessage
      {
         this.lang = lang;
         this.ticket = ticket;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.lang = "";
         this.ticket = "";
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
         this.serializeAs_AuthenticationTicketMessage(output);
      }
      
      public function serializeAs_AuthenticationTicketMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.lang);
         output.writeUTF(this.ticket);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AuthenticationTicketMessage(input);
      }
      
      public function deserializeAs_AuthenticationTicketMessage(input:ICustomDataInput) : void
      {
         this._langFunc(input);
         this._ticketFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AuthenticationTicketMessage(tree);
      }
      
      public function deserializeAsyncAs_AuthenticationTicketMessage(tree:FuncTree) : void
      {
         tree.addChild(this._langFunc);
         tree.addChild(this._ticketFunc);
      }
      
      private function _langFunc(input:ICustomDataInput) : void
      {
         this.lang = input.readUTF();
      }
      
      private function _ticketFunc(input:ICustomDataInput) : void
      {
         this.ticket = input.readUTF();
      }
   }
}
