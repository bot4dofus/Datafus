package com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChangeHavenBagRoomRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5694;
       
      
      private var _isInitialized:Boolean = false;
      
      public var roomId:uint = 0;
      
      public function ChangeHavenBagRoomRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5694;
      }
      
      public function initChangeHavenBagRoomRequestMessage(roomId:uint = 0) : ChangeHavenBagRoomRequestMessage
      {
         this.roomId = roomId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.roomId = 0;
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
         this.serializeAs_ChangeHavenBagRoomRequestMessage(output);
      }
      
      public function serializeAs_ChangeHavenBagRoomRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.roomId < 0)
         {
            throw new Error("Forbidden value (" + this.roomId + ") on element roomId.");
         }
         output.writeByte(this.roomId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChangeHavenBagRoomRequestMessage(input);
      }
      
      public function deserializeAs_ChangeHavenBagRoomRequestMessage(input:ICustomDataInput) : void
      {
         this._roomIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChangeHavenBagRoomRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_ChangeHavenBagRoomRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._roomIdFunc);
      }
      
      private function _roomIdFunc(input:ICustomDataInput) : void
      {
         this.roomId = input.readByte();
         if(this.roomId < 0)
         {
            throw new Error("Forbidden value (" + this.roomId + ") on element of ChangeHavenBagRoomRequestMessage.roomId.");
         }
      }
   }
}
