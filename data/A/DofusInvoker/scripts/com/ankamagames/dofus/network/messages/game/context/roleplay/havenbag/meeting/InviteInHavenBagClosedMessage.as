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
   
   public class InviteInHavenBagClosedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8001;
       
      
      private var _isInitialized:Boolean = false;
      
      public var hostInformations:CharacterMinimalInformations;
      
      private var _hostInformationstree:FuncTree;
      
      public function InviteInHavenBagClosedMessage()
      {
         this.hostInformations = new CharacterMinimalInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8001;
      }
      
      public function initInviteInHavenBagClosedMessage(hostInformations:CharacterMinimalInformations = null) : InviteInHavenBagClosedMessage
      {
         this.hostInformations = hostInformations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.hostInformations = new CharacterMinimalInformations();
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
         this.serializeAs_InviteInHavenBagClosedMessage(output);
      }
      
      public function serializeAs_InviteInHavenBagClosedMessage(output:ICustomDataOutput) : void
      {
         this.hostInformations.serializeAs_CharacterMinimalInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InviteInHavenBagClosedMessage(input);
      }
      
      public function deserializeAs_InviteInHavenBagClosedMessage(input:ICustomDataInput) : void
      {
         this.hostInformations = new CharacterMinimalInformations();
         this.hostInformations.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InviteInHavenBagClosedMessage(tree);
      }
      
      public function deserializeAsyncAs_InviteInHavenBagClosedMessage(tree:FuncTree) : void
      {
         this._hostInformationstree = tree.addChild(this._hostInformationstreeFunc);
      }
      
      private function _hostInformationstreeFunc(input:ICustomDataInput) : void
      {
         this.hostInformations = new CharacterMinimalInformations();
         this.hostInformations.deserializeAsync(this._hostInformationstree);
      }
   }
}
