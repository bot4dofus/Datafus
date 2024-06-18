package com.ankamagames.dofus.network.messages.game.context.roleplay.breach.meeting
{
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachInvitationResponseMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9260;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guest:CharacterMinimalInformations;
      
      public var accept:Boolean = false;
      
      private var _guesttree:FuncTree;
      
      public function BreachInvitationResponseMessage()
      {
         this.guest = new CharacterMinimalInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9260;
      }
      
      public function initBreachInvitationResponseMessage(guest:CharacterMinimalInformations = null, accept:Boolean = false) : BreachInvitationResponseMessage
      {
         this.guest = guest;
         this.accept = accept;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.guest = new CharacterMinimalInformations();
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
         this.serializeAs_BreachInvitationResponseMessage(output);
      }
      
      public function serializeAs_BreachInvitationResponseMessage(output:ICustomDataOutput) : void
      {
         this.guest.serializeAs_CharacterMinimalInformations(output);
         output.writeBoolean(this.accept);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachInvitationResponseMessage(input);
      }
      
      public function deserializeAs_BreachInvitationResponseMessage(input:ICustomDataInput) : void
      {
         this.guest = new CharacterMinimalInformations();
         this.guest.deserialize(input);
         this._acceptFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachInvitationResponseMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachInvitationResponseMessage(tree:FuncTree) : void
      {
         this._guesttree = tree.addChild(this._guesttreeFunc);
         tree.addChild(this._acceptFunc);
      }
      
      private function _guesttreeFunc(input:ICustomDataInput) : void
      {
         this.guest = new CharacterMinimalInformations();
         this.guest.deserializeAsync(this._guesttree);
      }
      
      private function _acceptFunc(input:ICustomDataInput) : void
      {
         this.accept = input.readBoolean();
      }
   }
}
