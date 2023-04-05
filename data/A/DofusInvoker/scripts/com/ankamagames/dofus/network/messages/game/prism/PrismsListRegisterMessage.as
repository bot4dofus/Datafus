package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PrismsListRegisterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2829;
       
      
      private var _isInitialized:Boolean = false;
      
      public var listen:uint = 0;
      
      public function PrismsListRegisterMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2829;
      }
      
      public function initPrismsListRegisterMessage(listen:uint = 0) : PrismsListRegisterMessage
      {
         this.listen = listen;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.listen = 0;
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
         this.serializeAs_PrismsListRegisterMessage(output);
      }
      
      public function serializeAs_PrismsListRegisterMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.listen);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismsListRegisterMessage(input);
      }
      
      public function deserializeAs_PrismsListRegisterMessage(input:ICustomDataInput) : void
      {
         this._listenFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismsListRegisterMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismsListRegisterMessage(tree:FuncTree) : void
      {
         tree.addChild(this._listenFunc);
      }
      
      private function _listenFunc(input:ICustomDataInput) : void
      {
         this.listen = input.readByte();
         if(this.listen < 0)
         {
            throw new Error("Forbidden value (" + this.listen + ") on element of PrismsListRegisterMessage.listen.");
         }
      }
   }
}
