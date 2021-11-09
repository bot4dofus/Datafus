package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ReloginTokenStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7776;
       
      
      private var _isInitialized:Boolean = false;
      
      public var validToken:Boolean = false;
      
      public var ticket:Vector.<int>;
      
      private var _tickettree:FuncTree;
      
      public function ReloginTokenStatusMessage()
      {
         this.ticket = new Vector.<int>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7776;
      }
      
      public function initReloginTokenStatusMessage(validToken:Boolean = false, ticket:Vector.<int> = null) : ReloginTokenStatusMessage
      {
         this.validToken = validToken;
         this.ticket = ticket;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.validToken = false;
         this.ticket = new Vector.<int>();
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
         this.serializeAs_ReloginTokenStatusMessage(output);
      }
      
      public function serializeAs_ReloginTokenStatusMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.validToken);
         output.writeVarInt(this.ticket.length);
         for(var _i2:uint = 0; _i2 < this.ticket.length; _i2++)
         {
            output.writeByte(this.ticket[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ReloginTokenStatusMessage(input);
      }
      
      public function deserializeAs_ReloginTokenStatusMessage(input:ICustomDataInput) : void
      {
         var _val2:int = 0;
         this._validTokenFunc(input);
         var _ticketLen:uint = input.readVarInt();
         for(var _i2:uint = 0; _i2 < _ticketLen; _i2++)
         {
            _val2 = input.readByte();
            this.ticket.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ReloginTokenStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_ReloginTokenStatusMessage(tree:FuncTree) : void
      {
         tree.addChild(this._validTokenFunc);
         this._tickettree = tree.addChild(this._tickettreeFunc);
      }
      
      private function _validTokenFunc(input:ICustomDataInput) : void
      {
         this.validToken = input.readBoolean();
      }
      
      private function _tickettreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readVarInt();
         for(var i:uint = 0; i < length; i++)
         {
            this._tickettree.addChild(this._ticketFunc);
         }
      }
      
      private function _ticketFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readByte();
         this.ticket.push(_val);
      }
   }
}
