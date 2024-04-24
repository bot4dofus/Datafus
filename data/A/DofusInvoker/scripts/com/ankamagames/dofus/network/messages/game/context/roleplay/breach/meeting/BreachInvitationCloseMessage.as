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
   
   public class BreachInvitationCloseMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3291;
       
      
      private var _isInitialized:Boolean = false;
      
      public var host:CharacterMinimalInformations;
      
      private var _hosttree:FuncTree;
      
      public function BreachInvitationCloseMessage()
      {
         this.host = new CharacterMinimalInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3291;
      }
      
      public function initBreachInvitationCloseMessage(host:CharacterMinimalInformations = null) : BreachInvitationCloseMessage
      {
         this.host = host;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.host = new CharacterMinimalInformations();
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
         this.serializeAs_BreachInvitationCloseMessage(output);
      }
      
      public function serializeAs_BreachInvitationCloseMessage(output:ICustomDataOutput) : void
      {
         this.host.serializeAs_CharacterMinimalInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachInvitationCloseMessage(input);
      }
      
      public function deserializeAs_BreachInvitationCloseMessage(input:ICustomDataInput) : void
      {
         this.host = new CharacterMinimalInformations();
         this.host.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachInvitationCloseMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachInvitationCloseMessage(tree:FuncTree) : void
      {
         this._hosttree = tree.addChild(this._hosttreeFunc);
      }
      
      private function _hosttreeFunc(input:ICustomDataInput) : void
      {
         this.host = new CharacterMinimalInformations();
         this.host.deserializeAsync(this._hosttree);
      }
   }
}
