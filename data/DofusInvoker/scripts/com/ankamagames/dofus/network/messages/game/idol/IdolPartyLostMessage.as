package com.ankamagames.dofus.network.messages.game.idol
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IdolPartyLostMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6894;
       
      
      private var _isInitialized:Boolean = false;
      
      public var idolId:uint = 0;
      
      public function IdolPartyLostMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6894;
      }
      
      public function initIdolPartyLostMessage(idolId:uint = 0) : IdolPartyLostMessage
      {
         this.idolId = idolId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.idolId = 0;
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
         this.serializeAs_IdolPartyLostMessage(output);
      }
      
      public function serializeAs_IdolPartyLostMessage(output:ICustomDataOutput) : void
      {
         if(this.idolId < 0)
         {
            throw new Error("Forbidden value (" + this.idolId + ") on element idolId.");
         }
         output.writeVarShort(this.idolId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IdolPartyLostMessage(input);
      }
      
      public function deserializeAs_IdolPartyLostMessage(input:ICustomDataInput) : void
      {
         this._idolIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IdolPartyLostMessage(tree);
      }
      
      public function deserializeAsyncAs_IdolPartyLostMessage(tree:FuncTree) : void
      {
         tree.addChild(this._idolIdFunc);
      }
      
      private function _idolIdFunc(input:ICustomDataInput) : void
      {
         this.idolId = input.readVarUhShort();
         if(this.idolId < 0)
         {
            throw new Error("Forbidden value (" + this.idolId + ") on element of IdolPartyLostMessage.idolId.");
         }
      }
   }
}
