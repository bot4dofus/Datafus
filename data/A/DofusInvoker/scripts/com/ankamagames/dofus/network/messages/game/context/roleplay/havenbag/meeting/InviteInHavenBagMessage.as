package com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.meeting
{
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class InviteInHavenBagMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 949;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guestInformations:CharacterMinimalInformations;
      
      public var accept:Boolean = false;
      
      private var _guestInformationstree:FuncTree;
      
      public function InviteInHavenBagMessage()
      {
         this.guestInformations = new CharacterMinimalInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 949;
      }
      
      public function initInviteInHavenBagMessage(guestInformations:CharacterMinimalInformations = null, accept:Boolean = false) : InviteInHavenBagMessage
      {
         this.guestInformations = guestInformations;
         this.accept = accept;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.guestInformations = new CharacterMinimalInformations();
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
         this.serializeAs_InviteInHavenBagMessage(output);
      }
      
      public function serializeAs_InviteInHavenBagMessage(output:ICustomDataOutput) : void
      {
         this.guestInformations.serializeAs_CharacterMinimalInformations(output);
         output.writeBoolean(this.accept);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InviteInHavenBagMessage(input);
      }
      
      public function deserializeAs_InviteInHavenBagMessage(input:ICustomDataInput) : void
      {
         this.guestInformations = new CharacterMinimalInformations();
         this.guestInformations.deserialize(input);
         this._acceptFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InviteInHavenBagMessage(tree);
      }
      
      public function deserializeAsyncAs_InviteInHavenBagMessage(tree:FuncTree) : void
      {
         this._guestInformationstree = tree.addChild(this._guestInformationstreeFunc);
         tree.addChild(this._acceptFunc);
      }
      
      private function _guestInformationstreeFunc(input:ICustomDataInput) : void
      {
         this.guestInformations = new CharacterMinimalInformations();
         this.guestInformations.deserializeAsync(this._guestInformationstree);
      }
      
      private function _acceptFunc(input:ICustomDataInput) : void
      {
         this.accept = input.readBoolean();
      }
   }
}
