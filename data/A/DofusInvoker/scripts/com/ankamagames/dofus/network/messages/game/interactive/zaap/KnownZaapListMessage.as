package com.ankamagames.dofus.network.messages.game.interactive.zaap
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class KnownZaapListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3175;
       
      
      private var _isInitialized:Boolean = false;
      
      public var destinations:Vector.<Number>;
      
      private var _destinationstree:FuncTree;
      
      public function KnownZaapListMessage()
      {
         this.destinations = new Vector.<Number>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3175;
      }
      
      public function initKnownZaapListMessage(destinations:Vector.<Number> = null) : KnownZaapListMessage
      {
         this.destinations = destinations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.destinations = new Vector.<Number>();
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
         this.serializeAs_KnownZaapListMessage(output);
      }
      
      public function serializeAs_KnownZaapListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.destinations.length);
         for(var _i1:uint = 0; _i1 < this.destinations.length; _i1++)
         {
            if(this.destinations[_i1] < 0 || this.destinations[_i1] > 9007199254740992)
            {
               throw new Error("Forbidden value (" + this.destinations[_i1] + ") on element 1 (starting at 1) of destinations.");
            }
            output.writeDouble(this.destinations[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_KnownZaapListMessage(input);
      }
      
      public function deserializeAs_KnownZaapListMessage(input:ICustomDataInput) : void
      {
         var _val1:Number = NaN;
         var _destinationsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _destinationsLen; _i1++)
         {
            _val1 = input.readDouble();
            if(_val1 < 0 || _val1 > 9007199254740992)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of destinations.");
            }
            this.destinations.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_KnownZaapListMessage(tree);
      }
      
      public function deserializeAsyncAs_KnownZaapListMessage(tree:FuncTree) : void
      {
         this._destinationstree = tree.addChild(this._destinationstreeFunc);
      }
      
      private function _destinationstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._destinationstree.addChild(this._destinationsFunc);
         }
      }
      
      private function _destinationsFunc(input:ICustomDataInput) : void
      {
         var _val:Number = input.readDouble();
         if(_val < 0 || _val > 9007199254740992)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of destinations.");
         }
         this.destinations.push(_val);
      }
   }
}
