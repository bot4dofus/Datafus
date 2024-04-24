package com.ankamagames.dofus.network.messages.game.chat.channel
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class EnabledChannelsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8311;
       
      
      private var _isInitialized:Boolean = false;
      
      public var channels:Vector.<uint>;
      
      public var disallowed:Vector.<uint>;
      
      private var _channelstree:FuncTree;
      
      private var _disallowedtree:FuncTree;
      
      public function EnabledChannelsMessage()
      {
         this.channels = new Vector.<uint>();
         this.disallowed = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8311;
      }
      
      public function initEnabledChannelsMessage(channels:Vector.<uint> = null, disallowed:Vector.<uint> = null) : EnabledChannelsMessage
      {
         this.channels = channels;
         this.disallowed = disallowed;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.channels = new Vector.<uint>();
         this.disallowed = new Vector.<uint>();
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
         this.serializeAs_EnabledChannelsMessage(output);
      }
      
      public function serializeAs_EnabledChannelsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.channels.length);
         for(var _i1:uint = 0; _i1 < this.channels.length; _i1++)
         {
            output.writeByte(this.channels[_i1]);
         }
         output.writeShort(this.disallowed.length);
         for(var _i2:uint = 0; _i2 < this.disallowed.length; _i2++)
         {
            output.writeByte(this.disallowed[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_EnabledChannelsMessage(input);
      }
      
      public function deserializeAs_EnabledChannelsMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _val2:uint = 0;
         var _channelsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _channelsLen; _i1++)
         {
            _val1 = input.readByte();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of channels.");
            }
            this.channels.push(_val1);
         }
         var _disallowedLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _disallowedLen; _i2++)
         {
            _val2 = input.readByte();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of disallowed.");
            }
            this.disallowed.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_EnabledChannelsMessage(tree);
      }
      
      public function deserializeAsyncAs_EnabledChannelsMessage(tree:FuncTree) : void
      {
         this._channelstree = tree.addChild(this._channelstreeFunc);
         this._disallowedtree = tree.addChild(this._disallowedtreeFunc);
      }
      
      private function _channelstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._channelstree.addChild(this._channelsFunc);
         }
      }
      
      private function _channelsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readByte();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of channels.");
         }
         this.channels.push(_val);
      }
      
      private function _disallowedtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._disallowedtree.addChild(this._disallowedFunc);
         }
      }
      
      private function _disallowedFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readByte();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of disallowed.");
         }
         this.disallowed.push(_val);
      }
   }
}
