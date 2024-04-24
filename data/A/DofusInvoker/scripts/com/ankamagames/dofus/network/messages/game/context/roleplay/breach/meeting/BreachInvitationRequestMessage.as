package com.ankamagames.dofus.network.messages.game.context.roleplay.breach.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachInvitationRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3577;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guests:Vector.<Number>;
      
      private var _gueststree:FuncTree;
      
      public function BreachInvitationRequestMessage()
      {
         this.guests = new Vector.<Number>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3577;
      }
      
      public function initBreachInvitationRequestMessage(guests:Vector.<Number> = null) : BreachInvitationRequestMessage
      {
         this.guests = guests;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.guests = new Vector.<Number>();
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
         this.serializeAs_BreachInvitationRequestMessage(output);
      }
      
      public function serializeAs_BreachInvitationRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.guests.length);
         for(var _i1:uint = 0; _i1 < this.guests.length; _i1++)
         {
            if(this.guests[_i1] < 0 || this.guests[_i1] > 9007199254740992)
            {
               throw new Error("Forbidden value (" + this.guests[_i1] + ") on element 1 (starting at 1) of guests.");
            }
            output.writeVarLong(this.guests[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachInvitationRequestMessage(input);
      }
      
      public function deserializeAs_BreachInvitationRequestMessage(input:ICustomDataInput) : void
      {
         var _val1:Number = NaN;
         var _guestsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _guestsLen; _i1++)
         {
            _val1 = input.readVarUhLong();
            if(_val1 < 0 || _val1 > 9007199254740992)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of guests.");
            }
            this.guests.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachInvitationRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachInvitationRequestMessage(tree:FuncTree) : void
      {
         this._gueststree = tree.addChild(this._gueststreeFunc);
      }
      
      private function _gueststreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._gueststree.addChild(this._guestsFunc);
         }
      }
      
      private function _guestsFunc(input:ICustomDataInput) : void
      {
         var _val:Number = input.readVarUhLong();
         if(_val < 0 || _val > 9007199254740992)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of guests.");
         }
         this.guests.push(_val);
      }
   }
}
