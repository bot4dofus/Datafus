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
   
   public class InviteInHavenBagOfferMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4318;
       
      
      private var _isInitialized:Boolean = false;
      
      public var hostInformations:CharacterMinimalInformations;
      
      public var timeLeftBeforeCancel:int = 0;
      
      private var _hostInformationstree:FuncTree;
      
      public function InviteInHavenBagOfferMessage()
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
         return 4318;
      }
      
      public function initInviteInHavenBagOfferMessage(hostInformations:CharacterMinimalInformations = null, timeLeftBeforeCancel:int = 0) : InviteInHavenBagOfferMessage
      {
         this.hostInformations = hostInformations;
         this.timeLeftBeforeCancel = timeLeftBeforeCancel;
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
         this.serializeAs_InviteInHavenBagOfferMessage(output);
      }
      
      public function serializeAs_InviteInHavenBagOfferMessage(output:ICustomDataOutput) : void
      {
         this.hostInformations.serializeAs_CharacterMinimalInformations(output);
         output.writeVarInt(this.timeLeftBeforeCancel);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InviteInHavenBagOfferMessage(input);
      }
      
      public function deserializeAs_InviteInHavenBagOfferMessage(input:ICustomDataInput) : void
      {
         this.hostInformations = new CharacterMinimalInformations();
         this.hostInformations.deserialize(input);
         this._timeLeftBeforeCancelFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InviteInHavenBagOfferMessage(tree);
      }
      
      public function deserializeAsyncAs_InviteInHavenBagOfferMessage(tree:FuncTree) : void
      {
         this._hostInformationstree = tree.addChild(this._hostInformationstreeFunc);
         tree.addChild(this._timeLeftBeforeCancelFunc);
      }
      
      private function _hostInformationstreeFunc(input:ICustomDataInput) : void
      {
         this.hostInformations = new CharacterMinimalInformations();
         this.hostInformations.deserializeAsync(this._hostInformationstree);
      }
      
      private function _timeLeftBeforeCancelFunc(input:ICustomDataInput) : void
      {
         this.timeLeftBeforeCancel = input.readVarInt();
      }
   }
}
