package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MoveTaxCollectorOrderedSpellMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8918;
       
      
      private var _isInitialized:Boolean = false;
      
      public var taxCollectorId:Number = 0;
      
      public var movedFrom:uint = 0;
      
      public var movedTo:uint = 0;
      
      public function MoveTaxCollectorOrderedSpellMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8918;
      }
      
      public function initMoveTaxCollectorOrderedSpellMessage(taxCollectorId:Number = 0, movedFrom:uint = 0, movedTo:uint = 0) : MoveTaxCollectorOrderedSpellMessage
      {
         this.taxCollectorId = taxCollectorId;
         this.movedFrom = movedFrom;
         this.movedTo = movedTo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.taxCollectorId = 0;
         this.movedFrom = 0;
         this.movedTo = 0;
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
         this.serializeAs_MoveTaxCollectorOrderedSpellMessage(output);
      }
      
      public function serializeAs_MoveTaxCollectorOrderedSpellMessage(output:ICustomDataOutput) : void
      {
         if(this.taxCollectorId < 0 || this.taxCollectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element taxCollectorId.");
         }
         output.writeDouble(this.taxCollectorId);
         if(this.movedFrom < 0)
         {
            throw new Error("Forbidden value (" + this.movedFrom + ") on element movedFrom.");
         }
         output.writeByte(this.movedFrom);
         if(this.movedTo < 0)
         {
            throw new Error("Forbidden value (" + this.movedTo + ") on element movedTo.");
         }
         output.writeByte(this.movedTo);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MoveTaxCollectorOrderedSpellMessage(input);
      }
      
      public function deserializeAs_MoveTaxCollectorOrderedSpellMessage(input:ICustomDataInput) : void
      {
         this._taxCollectorIdFunc(input);
         this._movedFromFunc(input);
         this._movedToFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MoveTaxCollectorOrderedSpellMessage(tree);
      }
      
      public function deserializeAsyncAs_MoveTaxCollectorOrderedSpellMessage(tree:FuncTree) : void
      {
         tree.addChild(this._taxCollectorIdFunc);
         tree.addChild(this._movedFromFunc);
         tree.addChild(this._movedToFunc);
      }
      
      private function _taxCollectorIdFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorId = input.readDouble();
         if(this.taxCollectorId < 0 || this.taxCollectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element of MoveTaxCollectorOrderedSpellMessage.taxCollectorId.");
         }
      }
      
      private function _movedFromFunc(input:ICustomDataInput) : void
      {
         this.movedFrom = input.readByte();
         if(this.movedFrom < 0)
         {
            throw new Error("Forbidden value (" + this.movedFrom + ") on element of MoveTaxCollectorOrderedSpellMessage.movedFrom.");
         }
      }
      
      private function _movedToFunc(input:ICustomDataInput) : void
      {
         this.movedTo = input.readByte();
         if(this.movedTo < 0)
         {
            throw new Error("Forbidden value (" + this.movedTo + ") on element of MoveTaxCollectorOrderedSpellMessage.movedTo.");
         }
      }
   }
}
