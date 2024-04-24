package com.ankamagames.dofus.network.types.game.inventory
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class UpdatedStorageTabInformation implements INetworkType
   {
      
      public static const protocolId:uint = 265;
       
      
      public var name:String = "";
      
      public var tabNumber:uint = 0;
      
      public var picto:uint = 0;
      
      public var dropTypeLimitation:Vector.<uint>;
      
      private var _dropTypeLimitationtree:FuncTree;
      
      public function UpdatedStorageTabInformation()
      {
         this.dropTypeLimitation = new Vector.<uint>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 265;
      }
      
      public function initUpdatedStorageTabInformation(name:String = "", tabNumber:uint = 0, picto:uint = 0, dropTypeLimitation:Vector.<uint> = null) : UpdatedStorageTabInformation
      {
         this.name = name;
         this.tabNumber = tabNumber;
         this.picto = picto;
         this.dropTypeLimitation = dropTypeLimitation;
         return this;
      }
      
      public function reset() : void
      {
         this.name = "";
         this.tabNumber = 0;
         this.picto = 0;
         this.dropTypeLimitation = new Vector.<uint>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_UpdatedStorageTabInformation(output);
      }
      
      public function serializeAs_UpdatedStorageTabInformation(output:ICustomDataOutput) : void
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
         output.writeShort(this.dropTypeLimitation.length);
         for(var _i4:uint = 0; _i4 < this.dropTypeLimitation.length; _i4++)
         {
            if(this.dropTypeLimitation[_i4] < 0)
            {
               throw new Error("Forbidden value (" + this.dropTypeLimitation[_i4] + ") on element 4 (starting at 1) of dropTypeLimitation.");
            }
            output.writeVarInt(this.dropTypeLimitation[_i4]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_UpdatedStorageTabInformation(input);
      }
      
      public function deserializeAs_UpdatedStorageTabInformation(input:ICustomDataInput) : void
      {
         var _val4:uint = 0;
         this._nameFunc(input);
         this._tabNumberFunc(input);
         this._pictoFunc(input);
         var _dropTypeLimitationLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _dropTypeLimitationLen; _i4++)
         {
            _val4 = input.readVarUhInt();
            if(_val4 < 0)
            {
               throw new Error("Forbidden value (" + _val4 + ") on elements of dropTypeLimitation.");
            }
            this.dropTypeLimitation.push(_val4);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_UpdatedStorageTabInformation(tree);
      }
      
      public function deserializeAsyncAs_UpdatedStorageTabInformation(tree:FuncTree) : void
      {
         tree.addChild(this._nameFunc);
         tree.addChild(this._tabNumberFunc);
         tree.addChild(this._pictoFunc);
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
            throw new Error("Forbidden value (" + this.tabNumber + ") on element of UpdatedStorageTabInformation.tabNumber.");
         }
      }
      
      private function _pictoFunc(input:ICustomDataInput) : void
      {
         this.picto = input.readVarUhInt();
         if(this.picto < 0)
         {
            throw new Error("Forbidden value (" + this.picto + ") on element of UpdatedStorageTabInformation.picto.");
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
