package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeCrafterJobLevelupMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2584;
       
      
      private var _isInitialized:Boolean = false;
      
      public var crafterJobLevel:uint = 0;
      
      public function ExchangeCrafterJobLevelupMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2584;
      }
      
      public function initExchangeCrafterJobLevelupMessage(crafterJobLevel:uint = 0) : ExchangeCrafterJobLevelupMessage
      {
         this.crafterJobLevel = crafterJobLevel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.crafterJobLevel = 0;
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
         this.serializeAs_ExchangeCrafterJobLevelupMessage(output);
      }
      
      public function serializeAs_ExchangeCrafterJobLevelupMessage(output:ICustomDataOutput) : void
      {
         if(this.crafterJobLevel < 0 || this.crafterJobLevel > 255)
         {
            throw new Error("Forbidden value (" + this.crafterJobLevel + ") on element crafterJobLevel.");
         }
         output.writeByte(this.crafterJobLevel);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeCrafterJobLevelupMessage(input);
      }
      
      public function deserializeAs_ExchangeCrafterJobLevelupMessage(input:ICustomDataInput) : void
      {
         this._crafterJobLevelFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeCrafterJobLevelupMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeCrafterJobLevelupMessage(tree:FuncTree) : void
      {
         tree.addChild(this._crafterJobLevelFunc);
      }
      
      private function _crafterJobLevelFunc(input:ICustomDataInput) : void
      {
         this.crafterJobLevel = input.readUnsignedByte();
         if(this.crafterJobLevel < 0 || this.crafterJobLevel > 255)
         {
            throw new Error("Forbidden value (" + this.crafterJobLevel + ") on element of ExchangeCrafterJobLevelupMessage.crafterJobLevel.");
         }
      }
   }
}
