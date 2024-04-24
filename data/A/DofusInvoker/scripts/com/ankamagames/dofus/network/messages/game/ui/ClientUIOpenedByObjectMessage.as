package com.ankamagames.dofus.network.messages.game.ui
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ClientUIOpenedByObjectMessage extends ClientUIOpenedMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5533;
       
      
      private var _isInitialized:Boolean = false;
      
      public var uid:uint = 0;
      
      public function ClientUIOpenedByObjectMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5533;
      }
      
      public function initClientUIOpenedByObjectMessage(type:uint = 0, uid:uint = 0) : ClientUIOpenedByObjectMessage
      {
         super.initClientUIOpenedMessage(type);
         this.uid = uid;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.uid = 0;
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
         this.serializeAs_ClientUIOpenedByObjectMessage(output);
      }
      
      public function serializeAs_ClientUIOpenedByObjectMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ClientUIOpenedMessage(output);
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element uid.");
         }
         output.writeVarInt(this.uid);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ClientUIOpenedByObjectMessage(input);
      }
      
      public function deserializeAs_ClientUIOpenedByObjectMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._uidFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ClientUIOpenedByObjectMessage(tree);
      }
      
      public function deserializeAsyncAs_ClientUIOpenedByObjectMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._uidFunc);
      }
      
      private function _uidFunc(input:ICustomDataInput) : void
      {
         this.uid = input.readVarUhInt();
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element of ClientUIOpenedByObjectMessage.uid.");
         }
      }
   }
}
