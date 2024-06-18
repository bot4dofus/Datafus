package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TeleportBuddiesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9554;
       
      
      private var _isInitialized:Boolean = false;
      
      public var dungeonId:uint = 0;
      
      public function TeleportBuddiesMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9554;
      }
      
      public function initTeleportBuddiesMessage(dungeonId:uint = 0) : TeleportBuddiesMessage
      {
         this.dungeonId = dungeonId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.dungeonId = 0;
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
         this.serializeAs_TeleportBuddiesMessage(output);
      }
      
      public function serializeAs_TeleportBuddiesMessage(output:ICustomDataOutput) : void
      {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         output.writeVarShort(this.dungeonId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportBuddiesMessage(input);
      }
      
      public function deserializeAs_TeleportBuddiesMessage(input:ICustomDataInput) : void
      {
         this._dungeonIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TeleportBuddiesMessage(tree);
      }
      
      public function deserializeAsyncAs_TeleportBuddiesMessage(tree:FuncTree) : void
      {
         tree.addChild(this._dungeonIdFunc);
      }
      
      private function _dungeonIdFunc(input:ICustomDataInput) : void
      {
         this.dungeonId = input.readVarUhShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of TeleportBuddiesMessage.dungeonId.");
         }
      }
   }
}
