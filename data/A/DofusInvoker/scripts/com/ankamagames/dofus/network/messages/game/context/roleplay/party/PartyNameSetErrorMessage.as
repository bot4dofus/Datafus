package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyNameSetErrorMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7989;
       
      
      private var _isInitialized:Boolean = false;
      
      public var result:uint = 0;
      
      public function PartyNameSetErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7989;
      }
      
      public function initPartyNameSetErrorMessage(partyId:uint = 0, result:uint = 0) : PartyNameSetErrorMessage
      {
         super.initAbstractPartyMessage(partyId);
         this.result = result;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.result = 0;
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
         this.serializeAs_PartyNameSetErrorMessage(output);
      }
      
      public function serializeAs_PartyNameSetErrorMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeByte(this.result);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyNameSetErrorMessage(input);
      }
      
      public function deserializeAs_PartyNameSetErrorMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._resultFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyNameSetErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyNameSetErrorMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._resultFunc);
      }
      
      private function _resultFunc(input:ICustomDataInput) : void
      {
         this.result = input.readByte();
         if(this.result < 0)
         {
            throw new Error("Forbidden value (" + this.result + ") on element of PartyNameSetErrorMessage.result.");
         }
      }
   }
}
