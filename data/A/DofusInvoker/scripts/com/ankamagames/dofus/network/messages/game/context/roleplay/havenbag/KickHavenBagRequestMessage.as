package com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class KickHavenBagRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3366;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guestId:Number = 0;
      
      public function KickHavenBagRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3366;
      }
      
      public function initKickHavenBagRequestMessage(guestId:Number = 0) : KickHavenBagRequestMessage
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
         this.serializeAs_KickHavenBagRequestMessage(output);
      }
      
      public function serializeAs_KickHavenBagRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.guestId < 0 || this.guestId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element guestId.");
         }
         output.writeVarLong(this.guestId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_KickHavenBagRequestMessage(input);
      }
      
      public function deserializeAs_KickHavenBagRequestMessage(input:ICustomDataInput) : void
      {
         this._guestIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_KickHavenBagRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_KickHavenBagRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._guestIdFunc);
      }
      
      private function _guestIdFunc(input:ICustomDataInput) : void
      {
         this.guestId = input.readVarUhLong();
         if(this.guestId < 0 || this.guestId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element of KickHavenBagRequestMessage.guestId.");
         }
      }
   }
}
