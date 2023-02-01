package com.ankamagames.dofus.network.messages.game.idol
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.idol.PartyIdol;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IdolListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5456;
       
      
      private var _isInitialized:Boolean = false;
      
      public var chosenIdols:Vector.<uint>;
      
      public var partyChosenIdols:Vector.<uint>;
      
      public var partyIdols:Vector.<PartyIdol>;
      
      private var _chosenIdolstree:FuncTree;
      
      private var _partyChosenIdolstree:FuncTree;
      
      private var _partyIdolstree:FuncTree;
      
      public function IdolListMessage()
      {
         this.chosenIdols = new Vector.<uint>();
         this.partyChosenIdols = new Vector.<uint>();
         this.partyIdols = new Vector.<PartyIdol>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5456;
      }
      
      public function initIdolListMessage(chosenIdols:Vector.<uint> = null, partyChosenIdols:Vector.<uint> = null, partyIdols:Vector.<PartyIdol> = null) : IdolListMessage
      {
         this.chosenIdols = chosenIdols;
         this.partyChosenIdols = partyChosenIdols;
         this.partyIdols = partyIdols;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.chosenIdols = new Vector.<uint>();
         this.partyChosenIdols = new Vector.<uint>();
         this.partyIdols = new Vector.<PartyIdol>();
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
         this.serializeAs_IdolListMessage(output);
      }
      
      public function serializeAs_IdolListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.chosenIdols.length);
         for(var _i1:uint = 0; _i1 < this.chosenIdols.length; _i1++)
         {
            if(this.chosenIdols[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.chosenIdols[_i1] + ") on element 1 (starting at 1) of chosenIdols.");
            }
            output.writeVarShort(this.chosenIdols[_i1]);
         }
         output.writeShort(this.partyChosenIdols.length);
         for(var _i2:uint = 0; _i2 < this.partyChosenIdols.length; _i2++)
         {
            if(this.partyChosenIdols[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.partyChosenIdols[_i2] + ") on element 2 (starting at 1) of partyChosenIdols.");
            }
            output.writeVarShort(this.partyChosenIdols[_i2]);
         }
         output.writeShort(this.partyIdols.length);
         for(var _i3:uint = 0; _i3 < this.partyIdols.length; _i3++)
         {
            output.writeShort((this.partyIdols[_i3] as PartyIdol).getTypeId());
            (this.partyIdols[_i3] as PartyIdol).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IdolListMessage(input);
      }
      
      public function deserializeAs_IdolListMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _val2:uint = 0;
         var _id3:uint = 0;
         var _item3:PartyIdol = null;
         var _chosenIdolsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _chosenIdolsLen; _i1++)
         {
            _val1 = input.readVarUhShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of chosenIdols.");
            }
            this.chosenIdols.push(_val1);
         }
         var _partyChosenIdolsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _partyChosenIdolsLen; _i2++)
         {
            _val2 = input.readVarUhShort();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of partyChosenIdols.");
            }
            this.partyChosenIdols.push(_val2);
         }
         var _partyIdolsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _partyIdolsLen; _i3++)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(PartyIdol,_id3);
            _item3.deserialize(input);
            this.partyIdols.push(_item3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IdolListMessage(tree);
      }
      
      public function deserializeAsyncAs_IdolListMessage(tree:FuncTree) : void
      {
         this._chosenIdolstree = tree.addChild(this._chosenIdolstreeFunc);
         this._partyChosenIdolstree = tree.addChild(this._partyChosenIdolstreeFunc);
         this._partyIdolstree = tree.addChild(this._partyIdolstreeFunc);
      }
      
      private function _chosenIdolstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._chosenIdolstree.addChild(this._chosenIdolsFunc);
         }
      }
      
      private function _chosenIdolsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of chosenIdols.");
         }
         this.chosenIdols.push(_val);
      }
      
      private function _partyChosenIdolstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._partyChosenIdolstree.addChild(this._partyChosenIdolsFunc);
         }
      }
      
      private function _partyChosenIdolsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of partyChosenIdols.");
         }
         this.partyChosenIdols.push(_val);
      }
      
      private function _partyIdolstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._partyIdolstree.addChild(this._partyIdolsFunc);
         }
      }
      
      private function _partyIdolsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:PartyIdol = ProtocolTypeManager.getInstance(PartyIdol,_id);
         _item.deserialize(input);
         this.partyIdols.push(_item);
      }
   }
}
