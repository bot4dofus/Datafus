package com.ankamagames.dofus.network.types.game.inventory
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class StorageTabInformation implements INetworkType
   {
      
      public static const protocolId:uint = 3410;
       
      
      public var name:String = "";
      
      public var tabNumber:uint = 0;
      
      public var picto:uint = 0;
      
      public var openRight:uint = 0;
      
      public var dropRight:uint = 0;
      
      public var takeRight:uint = 0;
      
      public var dropTypeLimitation:Vector.<uint>;
      
      private var _dropTypeLimitationtree:FuncTree;
      
      public function StorageTabInformation()
      {
         this.dropTypeLimitation = new Vector.<uint>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3410;
      }
      
      public function initStorageTabInformation(name:String = "", tabNumber:uint = 0, picto:uint = 0, openRight:uint = 0, dropRight:uint = 0, takeRight:uint = 0, dropTypeLimitation:Vector.<uint> = null) : StorageTabInformation
      {
         this.name = name;
         this.tabNumber = tabNumber;
         this.picto = picto;
         this.openRight = openRight;
         this.dropRight = dropRight;
         this.takeRight = takeRight;
         this.dropTypeLimitation = dropTypeLimitation;
         return this;
      }
      
      public function reset() : void
      {
         this.name = "";
         this.tabNumber = 0;
         this.picto = 0;
         this.openRight = 0;
         this.dropRight = 0;
         this.takeRight = 0;
         this.dropTypeLimitation = new Vector.<uint>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_StorageTabInformation(output);
      }
      
      public function serializeAs_StorageTabInformation(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.name);
         if(this.tabNumber < 0)
         {
            throw new Error("Forbidden value (" + this.tabNumber + ") on element tabNumber.");
         }
         output.writeVarInt(this.tabNumber);
         if(this.picto < 0)
         {
            throw new Error("Forbidden value (" + this.picto + ") on element picto.");
         }
         output.writeVarInt(this.picto);
         if(this.openRight < 0)
         {
            throw new Error("Forbidden value (" + this.openRight + ") on element openRight.");
         }
         output.writeVarInt(this.openRight);
         if(this.dropRight < 0)
         {
            throw new Error("Forbidden value (" + this.dropRight + ") on element dropRight.");
         }
         output.writeVarInt(this.dropRight);
         if(this.takeRight < 0)
         {
            throw new Error("Forbidden value (" + this.takeRight + ") on element takeRight.");
         }
         output.writeVarInt(this.takeRight);
         output.writeShort(this.dropTypeLimitation.length);
         for(var _i7:uint = 0; _i7 < this.dropTypeLimitation.length; _i7++)
         {
            if(this.dropTypeLimitation[_i7] < 0)
            {
               throw new Error("Forbidden value (" + this.dropTypeLimitation[_i7] + ") on element 7 (starting at 1) of dropTypeLimitation.");
            }
            output.writeVarInt(this.dropTypeLimitation[_i7]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StorageTabInformation(input);
      }
      
      public function deserializeAs_StorageTabInformation(input:ICustomDataInput) : void
      {
         var _val7:uint = 0;
         this._nameFunc(input);
         this._tabNumberFunc(input);
         this._pictoFunc(input);
         this._openRightFunc(input);
         this._dropRightFunc(input);
         this._takeRightFunc(input);
         var _dropTypeLimitationLen:uint = input.readUnsignedShort();
         for(var _i7:uint = 0; _i7 < _dropTypeLimitationLen; _i7++)
         {
            _val7 = input.readVarUhInt();
            if(_val7 < 0)
            {
               throw new Error("Forbidden value (" + _val7 + ") on elements of dropTypeLimitation.");
            }
            this.dropTypeLimitation.push(_val7);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StorageTabInformation(tree);
      }
      
      public function deserializeAsyncAs_StorageTabInformation(tree:FuncTree) : void
      {
         tree.addChild(this._nameFunc);
         tree.addChild(this._tabNumberFunc);
         tree.addChild(this._pictoFunc);
         tree.addChild(this._openRightFunc);
         tree.addChild(this._dropRightFunc);
         tree.addChild(this._takeRightFunc);
         this._dropTypeLimitationtree = tree.addChild(this._dropTypeLimitationtreeFunc);
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
      
      private function _tabNumberFunc(input:ICustomDataInput) : void
      {
         this.tabNumber = input.readVarUhInt();
         if(this.tabNumber < 0)
         {
            throw new Error("Forbidden value (" + this.tabNumber + ") on element of StorageTabInformation.tabNumber.");
         }
      }
      
      private function _pictoFunc(input:ICustomDataInput) : void
      {
         this.picto = input.readVarUhInt();
         if(this.picto < 0)
         {
            throw new Error("Forbidden value (" + this.picto + ") on element of StorageTabInformation.picto.");
         }
      }
      
      private function _openRightFunc(input:ICustomDataInput) : void
      {
         this.openRight = input.readVarUhInt();
         if(this.openRight < 0)
         {
            throw new Error("Forbidden value (" + this.openRight + ") on element of StorageTabInformation.openRight.");
         }
      }
      
      private function _dropRightFunc(input:ICustomDataInput) : void
      {
         this.dropRight = input.readVarUhInt();
         if(this.dropRight < 0)
         {
            throw new Error("Forbidden value (" + this.dropRight + ") on element of StorageTabInformation.dropRight.");
         }
      }
      
      private function _takeRightFunc(input:ICustomDataInput) : void
      {
         this.takeRight = input.readVarUhInt();
         if(this.takeRight < 0)
         {
            throw new Error("Forbidden value (" + this.takeRight + ") on element of StorageTabInformation.takeRight.");
         }
      }
      
      private function _dropTypeLimitationtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._dropTypeLimitationtree.addChild(this._dropTypeLimitationFunc);
         }
      }
      
      private function _dropTypeLimitationFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of dropTypeLimitation.");
         }
         this.dropTypeLimitation.push(_val);
      }
   }
}
