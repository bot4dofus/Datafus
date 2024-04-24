package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SelectedServerDataMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9359;
       
      
      private var _isInitialized:Boolean = false;
      
      public var serverId:uint = 0;
      
      public var address:String = "";
      
      public var ports:Vector.<uint>;
      
      public var canCreateNewCharacter:Boolean = false;
      
      public var ticket:Vector.<int>;
      
      private var _portstree:FuncTree;
      
      private var _tickettree:FuncTree;
      
      public function SelectedServerDataMessage()
      {
         this.ports = new Vector.<uint>();
         this.ticket = new Vector.<int>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9359;
      }
      
      public function initSelectedServerDataMessage(serverId:uint = 0, address:String = "", ports:Vector.<uint> = null, canCreateNewCharacter:Boolean = false, ticket:Vector.<int> = null) : SelectedServerDataMessage
      {
         this.serverId = serverId;
         this.address = address;
         this.ports = ports;
         this.canCreateNewCharacter = canCreateNewCharacter;
         this.ticket = ticket;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.serverId = 0;
         this.address = "";
         this.ports = new Vector.<uint>();
         this.canCreateNewCharacter = false;
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
         this.serializeAs_SelectedServerDataMessage(output);
      }
      
      public function serializeAs_SelectedServerDataMessage(output:ICustomDataOutput) : void
      {
         if(this.serverId < 0)
         {
            throw new Error("Forbidden value (" + this.serverId + ") on element serverId.");
         }
         output.writeVarShort(this.serverId);
         output.writeUTF(this.address);
         output.writeShort(this.ports.length);
         for(var _i3:uint = 0; _i3 < this.ports.length; _i3++)
         {
            if(this.ports[_i3] < 0)
            {
               throw new Error("Forbidden value (" + this.ports[_i3] + ") on element 3 (starting at 1) of ports.");
            }
            output.writeVarShort(this.ports[_i3]);
         }
         output.writeBoolean(this.canCreateNewCharacter);
         output.writeVarInt(this.ticket.length);
         for(var _i5:uint = 0; _i5 < this.ticket.length; _i5++)
         {
            output.writeByte(this.ticket[_i5]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SelectedServerDataMessage(input);
      }
      
      public function deserializeAs_SelectedServerDataMessage(input:ICustomDataInput) : void
      {
         var _val3:uint = 0;
         var _val5:int = 0;
         this._serverIdFunc(input);
         this._addressFunc(input);
         var _portsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _portsLen; _i3++)
         {
            _val3 = input.readVarUhShort();
            if(_val3 < 0)
            {
               throw new Error("Forbidden value (" + _val3 + ") on elements of ports.");
            }
            this.ports.push(_val3);
         }
         this._canCreateNewCharacterFunc(input);
         var _ticketLen:uint = input.readVarInt();
         for(var _i5:uint = 0; _i5 < _ticketLen; _i5++)
         {
            _val5 = input.readByte();
            this.ticket.push(_val5);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SelectedServerDataMessage(tree);
      }
      
      public function deserializeAsyncAs_SelectedServerDataMessage(tree:FuncTree) : void
      {
         tree.addChild(this._serverIdFunc);
         tree.addChild(this._addressFunc);
         this._portstree = tree.addChild(this._portstreeFunc);
         tree.addChild(this._canCreateNewCharacterFunc);
         this._tickettree = tree.addChild(this._tickettreeFunc);
      }
      
      private function _serverIdFunc(input:ICustomDataInput) : void
      {
         this.serverId = input.readVarUhShort();
         if(this.serverId < 0)
         {
            throw new Error("Forbidden value (" + this.serverId + ") on element of SelectedServerDataMessage.serverId.");
         }
      }
      
      private function _addressFunc(input:ICustomDataInput) : void
      {
         this.address = input.readUTF();
      }
      
      private function _portstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._portstree.addChild(this._portsFunc);
         }
      }
      
      private function _portsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of ports.");
         }
         this.ports.push(_val);
      }
      
      private function _canCreateNewCharacterFunc(input:ICustomDataInput) : void
      {
         this.canCreateNewCharacter = input.readBoolean();
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
