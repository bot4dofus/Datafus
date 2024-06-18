package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.types.game.alliance.KohAllianceInfo;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class KohUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1036;
       
      
      private var _isInitialized:Boolean = false;
      
      public var kohAllianceInfo:Vector.<KohAllianceInfo>;
      
      public var startingAvaTimestamp:uint = 0;
      
      public var nextTickTime:Number = 0;
      
      private var _kohAllianceInfotree:FuncTree;
      
      public function KohUpdateMessage()
      {
         this.kohAllianceInfo = new Vector.<KohAllianceInfo>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1036;
      }
      
      public function initKohUpdateMessage(kohAllianceInfo:Vector.<KohAllianceInfo> = null, startingAvaTimestamp:uint = 0, nextTickTime:Number = 0) : KohUpdateMessage
      {
         this.kohAllianceInfo = kohAllianceInfo;
         this.startingAvaTimestamp = startingAvaTimestamp;
         this.nextTickTime = nextTickTime;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.kohAllianceInfo = new Vector.<KohAllianceInfo>();
         this.startingAvaTimestamp = 0;
         this.nextTickTime = 0;
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
         this.serializeAs_KohUpdateMessage(output);
      }
      
      public function serializeAs_KohUpdateMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.kohAllianceInfo.length);
         for(var _i1:uint = 0; _i1 < this.kohAllianceInfo.length; _i1++)
         {
            (this.kohAllianceInfo[_i1] as KohAllianceInfo).serializeAs_KohAllianceInfo(output);
         }
         if(this.startingAvaTimestamp < 0)
         {
            throw new Error("Forbidden value (" + this.startingAvaTimestamp + ") on element startingAvaTimestamp.");
         }
         output.writeInt(this.startingAvaTimestamp);
         if(this.nextTickTime < 0 || this.nextTickTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.nextTickTime + ") on element nextTickTime.");
         }
         output.writeDouble(this.nextTickTime);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_KohUpdateMessage(input);
      }
      
      public function deserializeAs_KohUpdateMessage(input:ICustomDataInput) : void
      {
         var _item1:KohAllianceInfo = null;
         var _kohAllianceInfoLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _kohAllianceInfoLen; _i1++)
         {
            _item1 = new KohAllianceInfo();
            _item1.deserialize(input);
            this.kohAllianceInfo.push(_item1);
         }
         this._startingAvaTimestampFunc(input);
         this._nextTickTimeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_KohUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_KohUpdateMessage(tree:FuncTree) : void
      {
         this._kohAllianceInfotree = tree.addChild(this._kohAllianceInfotreeFunc);
         tree.addChild(this._startingAvaTimestampFunc);
         tree.addChild(this._nextTickTimeFunc);
      }
      
      private function _kohAllianceInfotreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._kohAllianceInfotree.addChild(this._kohAllianceInfoFunc);
         }
      }
      
      private function _kohAllianceInfoFunc(input:ICustomDataInput) : void
      {
         var _item:KohAllianceInfo = new KohAllianceInfo();
         _item.deserialize(input);
         this.kohAllianceInfo.push(_item);
      }
      
      private function _startingAvaTimestampFunc(input:ICustomDataInput) : void
      {
         this.startingAvaTimestamp = input.readInt();
         if(this.startingAvaTimestamp < 0)
         {
            throw new Error("Forbidden value (" + this.startingAvaTimestamp + ") on element of KohUpdateMessage.startingAvaTimestamp.");
         }
      }
      
      private function _nextTickTimeFunc(input:ICustomDataInput) : void
      {
         this.nextTickTime = input.readDouble();
         if(this.nextTickTime < 0 || this.nextTickTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.nextTickTime + ") on element of KohUpdateMessage.nextTickTime.");
         }
      }
   }
}
