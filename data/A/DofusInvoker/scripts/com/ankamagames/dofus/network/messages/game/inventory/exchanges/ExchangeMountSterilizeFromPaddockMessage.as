package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeMountSterilizeFromPaddockMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7996;
       
      
      private var _isInitialized:Boolean = false;
      
      public var name:String = "";
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var sterilizator:String = "";
      
      public function ExchangeMountSterilizeFromPaddockMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7996;
      }
      
      public function initExchangeMountSterilizeFromPaddockMessage(name:String = "", worldX:int = 0, worldY:int = 0, sterilizator:String = "") : ExchangeMountSterilizeFromPaddockMessage
      {
         this.name = name;
         this.worldX = worldX;
         this.worldY = worldY;
         this.sterilizator = sterilizator;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.name = "";
         this.worldX = 0;
         this.worldY = 0;
         this.sterilizator = "";
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
         this.serializeAs_ExchangeMountSterilizeFromPaddockMessage(output);
      }
      
      public function serializeAs_ExchangeMountSterilizeFromPaddockMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.name);
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         output.writeShort(this.worldX);
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
         }
         output.writeShort(this.worldY);
         output.writeUTF(this.sterilizator);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeMountSterilizeFromPaddockMessage(input);
      }
      
      public function deserializeAs_ExchangeMountSterilizeFromPaddockMessage(input:ICustomDataInput) : void
      {
         this._nameFunc(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._sterilizatorFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeMountSterilizeFromPaddockMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeMountSterilizeFromPaddockMessage(tree:FuncTree) : void
      {
         tree.addChild(this._nameFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._sterilizatorFunc);
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of ExchangeMountSterilizeFromPaddockMessage.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of ExchangeMountSterilizeFromPaddockMessage.worldY.");
         }
      }
      
      private function _sterilizatorFunc(input:ICustomDataInput) : void
      {
         this.sterilizator = input.readUTF();
      }
   }
}
