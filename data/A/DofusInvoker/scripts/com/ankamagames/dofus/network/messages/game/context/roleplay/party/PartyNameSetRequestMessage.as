package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyNameSetRequestMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9125;
       
      
      private var _isInitialized:Boolean = false;
      
      public var partyName:String = "";
      
      public function PartyNameSetRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9125;
      }
      
      public function initPartyNameSetRequestMessage(partyId:uint = 0, partyName:String = "") : PartyNameSetRequestMessage
      {
         super.initAbstractPartyMessage(partyId);
         this.partyName = partyName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.partyName = "";
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
         this.serializeAs_PartyNameSetRequestMessage(output);
      }
      
      public function serializeAs_PartyNameSetRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeUTF(this.partyName);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyNameSetRequestMessage(input);
      }
      
      public function deserializeAs_PartyNameSetRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._partyNameFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyNameSetRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyNameSetRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._partyNameFunc);
      }
      
      private function _partyNameFunc(input:ICustomDataInput) : void
      {
         this.partyName = input.readUTF();
      }
   }
}
