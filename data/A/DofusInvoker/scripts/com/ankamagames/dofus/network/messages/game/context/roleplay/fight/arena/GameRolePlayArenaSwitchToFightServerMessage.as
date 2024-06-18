package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayArenaSwitchToFightServerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4751;
       
      
      private var _isInitialized:Boolean = false;
      
      public var address:String = "";
      
      public var ports:Vector.<uint>;
      
      [Transient]
      public var token:String = "";
      
      private var _portstree:FuncTree;
      
      public function GameRolePlayArenaSwitchToFightServerMessage()
      {
         this.ports = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4751;
      }
      
      public function initGameRolePlayArenaSwitchToFightServerMessage(address:String = "", ports:Vector.<uint> = null, token:String = "") : GameRolePlayArenaSwitchToFightServerMessage
      {
         this.address = address;
         this.ports = ports;
         this.token = token;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.address = "";
         this.ports = new Vector.<uint>();
         this.token = "";
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
         this.serializeAs_GameRolePlayArenaSwitchToFightServerMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaSwitchToFightServerMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.address);
         output.writeShort(this.ports.length);
         for(var _i2:uint = 0; _i2 < this.ports.length; _i2++)
         {
            if(this.ports[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.ports[_i2] + ") on element 2 (starting at 1) of ports.");
            }
            output.writeVarShort(this.ports[_i2]);
         }
         output.writeUTF(this.token);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayArenaSwitchToFightServerMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaSwitchToFightServerMessage(input:ICustomDataInput) : void
      {
         var _val2:uint = 0;
         this._addressFunc(input);
         var _portsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _portsLen; _i2++)
         {
            _val2 = input.readVarUhShort();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of ports.");
            }
            this.ports.push(_val2);
         }
         this._tokenFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayArenaSwitchToFightServerMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayArenaSwitchToFightServerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._addressFunc);
         this._portstree = tree.addChild(this._portstreeFunc);
         tree.addChild(this._tokenFunc);
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
      
      private function _tokenFunc(input:ICustomDataInput) : void
      {
         this.token = input.readUTF();
      }
   }
}
