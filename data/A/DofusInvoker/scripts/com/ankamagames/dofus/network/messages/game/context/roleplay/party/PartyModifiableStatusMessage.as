package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyModifiableStatusMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2363;
       
      
      private var _isInitialized:Boolean = false;
      
      public var enabled:Boolean = false;
      
      public function PartyModifiableStatusMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2363;
      }
      
      public function initPartyModifiableStatusMessage(partyId:uint = 0, enabled:Boolean = false) : PartyModifiableStatusMessage
      {
         super.initAbstractPartyMessage(partyId);
         this.enabled = enabled;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.enabled = false;
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
         this.serializeAs_PartyModifiableStatusMessage(output);
      }
      
      public function serializeAs_PartyModifiableStatusMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeBoolean(this.enabled);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyModifiableStatusMessage(input);
      }
      
      public function deserializeAs_PartyModifiableStatusMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._enabledFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyModifiableStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyModifiableStatusMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._enabledFunc);
      }
      
      private function _enabledFunc(input:ICustomDataInput) : void
      {
         this.enabled = input.readBoolean();
      }
   }
}
