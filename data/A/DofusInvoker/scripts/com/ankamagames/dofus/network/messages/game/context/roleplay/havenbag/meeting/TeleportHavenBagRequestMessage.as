package com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TeleportHavenBagRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5171;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guestId:Number = 0;
      
      public function TeleportHavenBagRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5171;
      }
      
      public function initTeleportHavenBagRequestMessage(guestId:Number = 0) : TeleportHavenBagRequestMessage
      {
         this.guestId = guestId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.guestId = 0;
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
         this.serializeAs_TeleportHavenBagRequestMessage(output);
      }
      
      public function serializeAs_TeleportHavenBagRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.guestId < 0 || this.guestId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element guestId.");
         }
         output.writeVarLong(this.guestId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportHavenBagRequestMessage(input);
      }
      
      public function deserializeAs_TeleportHavenBagRequestMessage(input:ICustomDataInput) : void
      {
         this._guestIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TeleportHavenBagRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_TeleportHavenBagRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._guestIdFunc);
      }
      
      private function _guestIdFunc(input:ICustomDataInput) : void
      {
         this.guestId = input.readVarUhLong();
         if(this.guestId < 0 || this.guestId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element of TeleportHavenBagRequestMessage.guestId.");
         }
      }
   }
}
