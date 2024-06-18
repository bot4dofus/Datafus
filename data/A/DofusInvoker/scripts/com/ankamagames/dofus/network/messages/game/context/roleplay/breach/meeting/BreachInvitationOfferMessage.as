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
   
   public class BreachInvitationOfferMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5842;
       
      
      private var _isInitialized:Boolean = false;
      
      public var host:CharacterMinimalInformations;
      
      public var timeLeftBeforeCancel:uint = 0;
      
      private var _hosttree:FuncTree;
      
      public function BreachInvitationOfferMessage()
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
         return 5842;
      }
      
      public function initBreachInvitationOfferMessage(host:CharacterMinimalInformations = null, timeLeftBeforeCancel:uint = 0) : BreachInvitationOfferMessage
      {
         this.host = host;
         this.timeLeftBeforeCancel = timeLeftBeforeCancel;
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
         this.serializeAs_BreachInvitationOfferMessage(output);
      }
      
      public function serializeAs_BreachInvitationOfferMessage(output:ICustomDataOutput) : void
      {
         this.host.serializeAs_CharacterMinimalInformations(output);
         if(this.timeLeftBeforeCancel < 0)
         {
            throw new Error("Forbidden value (" + this.timeLeftBeforeCancel + ") on element timeLeftBeforeCancel.");
         }
         output.writeVarInt(this.timeLeftBeforeCancel);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachInvitationOfferMessage(input);
      }
      
      public function deserializeAs_BreachInvitationOfferMessage(input:ICustomDataInput) : void
      {
         this.host = new CharacterMinimalInformations();
         this.host.deserialize(input);
         this._timeLeftBeforeCancelFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachInvitationOfferMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachInvitationOfferMessage(tree:FuncTree) : void
      {
         this._hosttree = tree.addChild(this._hosttreeFunc);
         tree.addChild(this._timeLeftBeforeCancelFunc);
      }
      
      private function _hosttreeFunc(input:ICustomDataInput) : void
      {
         this.host = new CharacterMinimalInformations();
         this.host.deserializeAsync(this._hosttree);
      }
      
      private function _timeLeftBeforeCancelFunc(input:ICustomDataInput) : void
      {
         this.timeLeftBeforeCancel = input.readVarUhInt();
         if(this.timeLeftBeforeCancel < 0)
         {
            throw new Error("Forbidden value (" + this.timeLeftBeforeCancel + ") on element of BreachInvitationOfferMessage.timeLeftBeforeCancel.");
         }
      }
   }
}
