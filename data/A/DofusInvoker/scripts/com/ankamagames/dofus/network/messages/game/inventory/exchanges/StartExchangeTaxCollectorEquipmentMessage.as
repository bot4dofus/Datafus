package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class StartExchangeTaxCollectorEquipmentMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 878;
       
      
      private var _isInitialized:Boolean = false;
      
      public var uid:Number = 0;
      
      public function StartExchangeTaxCollectorEquipmentMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 878;
      }
      
      public function initStartExchangeTaxCollectorEquipmentMessage(uid:Number = 0) : StartExchangeTaxCollectorEquipmentMessage
      {
         this.uid = uid;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
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
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_StartExchangeTaxCollectorEquipmentMessage(output);
      }
      
      public function serializeAs_StartExchangeTaxCollectorEquipmentMessage(output:ICustomDataOutput) : void
      {
         if(this.uid < 0 || this.uid > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element uid.");
         }
         output.writeDouble(this.uid);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StartExchangeTaxCollectorEquipmentMessage(input);
      }
      
      public function deserializeAs_StartExchangeTaxCollectorEquipmentMessage(input:ICustomDataInput) : void
      {
         this._uidFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StartExchangeTaxCollectorEquipmentMessage(tree);
      }
      
      public function deserializeAsyncAs_StartExchangeTaxCollectorEquipmentMessage(tree:FuncTree) : void
      {
         tree.addChild(this._uidFunc);
      }
      
      private function _uidFunc(input:ICustomDataInput) : void
      {
         this.uid = input.readDouble();
         if(this.uid < 0 || this.uid > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element of StartExchangeTaxCollectorEquipmentMessage.uid.");
         }
      }
   }
}
