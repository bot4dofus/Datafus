package com.ankamagames.dofus.network.messages.game.inventory
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class KamasUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6455;
       
      
      private var _isInitialized:Boolean = false;
      
      public var kamasTotal:Number = 0;
      
      public function KamasUpdateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6455;
      }
      
      public function initKamasUpdateMessage(kamasTotal:Number = 0) : KamasUpdateMessage
      {
         this.kamasTotal = kamasTotal;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.kamasTotal = 0;
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
         this.serializeAs_KamasUpdateMessage(output);
      }
      
      public function serializeAs_KamasUpdateMessage(output:ICustomDataOutput) : void
      {
         if(this.kamasTotal < 0 || this.kamasTotal > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kamasTotal + ") on element kamasTotal.");
         }
         output.writeVarLong(this.kamasTotal);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_KamasUpdateMessage(input);
      }
      
      public function deserializeAs_KamasUpdateMessage(input:ICustomDataInput) : void
      {
         this._kamasTotalFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_KamasUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_KamasUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._kamasTotalFunc);
      }
      
      private function _kamasTotalFunc(input:ICustomDataInput) : void
      {
         this.kamasTotal = input.readVarUhLong();
         if(this.kamasTotal < 0 || this.kamasTotal > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kamasTotal + ") on element of KamasUpdateMessage.kamasTotal.");
         }
      }
   }
}
