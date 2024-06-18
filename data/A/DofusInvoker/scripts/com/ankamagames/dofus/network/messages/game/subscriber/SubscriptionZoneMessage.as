package com.ankamagames.dofus.network.messages.game.subscriber
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SubscriptionZoneMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8183;
       
      
      private var _isInitialized:Boolean = false;
      
      public var active:Boolean = false;
      
      public function SubscriptionZoneMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8183;
      }
      
      public function initSubscriptionZoneMessage(active:Boolean = false) : SubscriptionZoneMessage
      {
         this.active = active;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.active = false;
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
         this.serializeAs_SubscriptionZoneMessage(output);
      }
      
      public function serializeAs_SubscriptionZoneMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.active);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SubscriptionZoneMessage(input);
      }
      
      public function deserializeAs_SubscriptionZoneMessage(input:ICustomDataInput) : void
      {
         this._activeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SubscriptionZoneMessage(tree);
      }
      
      public function deserializeAsyncAs_SubscriptionZoneMessage(tree:FuncTree) : void
      {
         tree.addChild(this._activeFunc);
      }
      
      private function _activeFunc(input:ICustomDataInput) : void
      {
         this.active = input.readBoolean();
      }
   }
}
