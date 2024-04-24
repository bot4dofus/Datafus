package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TeleportBuddiesRequestedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3508;
       
      
      private var _isInitialized:Boolean = false;
      
      public var dungeonId:uint = 0;
      
      public var inviterId:Number = 0;
      
      public var invalidBuddiesIds:Vector.<Number>;
      
      private var _invalidBuddiesIdstree:FuncTree;
      
      public function TeleportBuddiesRequestedMessage()
      {
         this.invalidBuddiesIds = new Vector.<Number>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3508;
      }
      
      public function initTeleportBuddiesRequestedMessage(dungeonId:uint = 0, inviterId:Number = 0, invalidBuddiesIds:Vector.<Number> = null) : TeleportBuddiesRequestedMessage
      {
         this.dungeonId = dungeonId;
         this.inviterId = inviterId;
         this.invalidBuddiesIds = invalidBuddiesIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.dungeonId = 0;
         this.inviterId = 0;
         this.invalidBuddiesIds = new Vector.<Number>();
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
         this.serializeAs_TeleportBuddiesRequestedMessage(output);
      }
      
      public function serializeAs_TeleportBuddiesRequestedMessage(output:ICustomDataOutput) : void
      {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         output.writeVarShort(this.dungeonId);
         if(this.inviterId < 0 || this.inviterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.inviterId + ") on element inviterId.");
         }
         output.writeVarLong(this.inviterId);
         output.writeShort(this.invalidBuddiesIds.length);
         for(var _i3:uint = 0; _i3 < this.invalidBuddiesIds.length; _i3++)
         {
            if(this.invalidBuddiesIds[_i3] < 0 || this.invalidBuddiesIds[_i3] > 9007199254740992)
            {
               throw new Error("Forbidden value (" + this.invalidBuddiesIds[_i3] + ") on element 3 (starting at 1) of invalidBuddiesIds.");
            }
            output.writeVarLong(this.invalidBuddiesIds[_i3]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportBuddiesRequestedMessage(input);
      }
      
      public function deserializeAs_TeleportBuddiesRequestedMessage(input:ICustomDataInput) : void
      {
         var _val3:Number = NaN;
         this._dungeonIdFunc(input);
         this._inviterIdFunc(input);
         var _invalidBuddiesIdsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _invalidBuddiesIdsLen; _i3++)
         {
            _val3 = input.readVarUhLong();
            if(_val3 < 0 || _val3 > 9007199254740992)
            {
               throw new Error("Forbidden value (" + _val3 + ") on elements of invalidBuddiesIds.");
            }
            this.invalidBuddiesIds.push(_val3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TeleportBuddiesRequestedMessage(tree);
      }
      
      public function deserializeAsyncAs_TeleportBuddiesRequestedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._dungeonIdFunc);
         tree.addChild(this._inviterIdFunc);
         this._invalidBuddiesIdstree = tree.addChild(this._invalidBuddiesIdstreeFunc);
      }
      
      private function _dungeonIdFunc(input:ICustomDataInput) : void
      {
         this.dungeonId = input.readVarUhShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of TeleportBuddiesRequestedMessage.dungeonId.");
         }
      }
      
      private function _inviterIdFunc(input:ICustomDataInput) : void
      {
         this.inviterId = input.readVarUhLong();
         if(this.inviterId < 0 || this.inviterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.inviterId + ") on element of TeleportBuddiesRequestedMessage.inviterId.");
         }
      }
      
      private function _invalidBuddiesIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._invalidBuddiesIdstree.addChild(this._invalidBuddiesIdsFunc);
         }
      }
      
      private function _invalidBuddiesIdsFunc(input:ICustomDataInput) : void
      {
         var _val:Number = input.readVarUhLong();
         if(_val < 0 || _val > 9007199254740992)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of invalidBuddiesIds.");
         }
         this.invalidBuddiesIds.push(_val);
      }
   }
}
