package com.ankamagames.dofus.network.messages.game.idol
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IdolPartyRegisterRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7229;
       
      
      private var _isInitialized:Boolean = false;
      
      public var register:Boolean = false;
      
      public function IdolPartyRegisterRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7229;
      }
      
      public function initIdolPartyRegisterRequestMessage(register:Boolean = false) : IdolPartyRegisterRequestMessage
      {
         this.register = register;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.register = false;
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
         this.serializeAs_IdolPartyRegisterRequestMessage(output);
      }
      
      public function serializeAs_IdolPartyRegisterRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.register);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IdolPartyRegisterRequestMessage(input);
      }
      
      public function deserializeAs_IdolPartyRegisterRequestMessage(input:ICustomDataInput) : void
      {
         this._registerFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IdolPartyRegisterRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_IdolPartyRegisterRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._registerFunc);
      }
      
      private function _registerFunc(input:ICustomDataInput) : void
      {
         this.register = input.readBoolean();
      }
   }
}
