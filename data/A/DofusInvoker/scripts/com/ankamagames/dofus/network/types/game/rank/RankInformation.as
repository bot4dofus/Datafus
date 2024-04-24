package com.ankamagames.dofus.network.types.game.rank
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class RankInformation extends RankMinimalInformation implements INetworkType
   {
      
      public static const protocolId:uint = 4716;
       
      
      public var order:uint = 0;
      
      public var gfxId:uint = 0;
      
      public var modifiable:Boolean = false;
      
      public var rights:Vector.<uint>;
      
      private var _rightstree:FuncTree;
      
      public function RankInformation()
      {
         this.rights = new Vector.<uint>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4716;
      }
      
      public function initRankInformation(id:uint = 0, name:String = "", order:uint = 0, gfxId:uint = 0, modifiable:Boolean = false, rights:Vector.<uint> = null) : RankInformation
      {
         super.initRankMinimalInformation(id,name);
         this.order = order;
         this.gfxId = gfxId;
         this.modifiable = modifiable;
         this.rights = rights;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.order = 0;
         this.gfxId = 0;
         this.modifiable = false;
         this.rights = new Vector.<uint>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_RankInformation(output);
      }
      
      public function serializeAs_RankInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_RankMinimalInformation(output);
         if(this.order < 0)
         {
            throw new Error("Forbidden value (" + this.order + ") on element order.");
         }
         output.writeVarInt(this.order);
         if(this.gfxId < 0)
         {
            throw new Error("Forbidden value (" + this.gfxId + ") on element gfxId.");
         }
         output.writeVarInt(this.gfxId);
         output.writeBoolean(this.modifiable);
         output.writeShort(this.rights.length);
         for(var _i4:uint = 0; _i4 < this.rights.length; _i4++)
         {
            if(this.rights[_i4] < 0)
            {
               throw new Error("Forbidden value (" + this.rights[_i4] + ") on element 4 (starting at 1) of rights.");
            }
            output.writeVarInt(this.rights[_i4]);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_RankInformation(input);
      }
      
      public function deserializeAs_RankInformation(input:ICustomDataInput) : void
      {
         var _val4:uint = 0;
         super.deserialize(input);
         this._orderFunc(input);
         this._gfxIdFunc(input);
         this._modifiableFunc(input);
         var _rightsLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _rightsLen; _i4++)
         {
            _val4 = input.readVarUhInt();
            if(_val4 < 0)
            {
               throw new Error("Forbidden value (" + _val4 + ") on elements of rights.");
            }
            this.rights.push(_val4);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_RankInformation(tree);
      }
      
      public function deserializeAsyncAs_RankInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._orderFunc);
         tree.addChild(this._gfxIdFunc);
         tree.addChild(this._modifiableFunc);
         this._rightstree = tree.addChild(this._rightstreeFunc);
      }
      
      private function _orderFunc(input:ICustomDataInput) : void
      {
         this.order = input.readVarUhInt();
         if(this.order < 0)
         {
            throw new Error("Forbidden value (" + this.order + ") on element of RankInformation.order.");
         }
      }
      
      private function _gfxIdFunc(input:ICustomDataInput) : void
      {
         this.gfxId = input.readVarUhInt();
         if(this.gfxId < 0)
         {
            throw new Error("Forbidden value (" + this.gfxId + ") on element of RankInformation.gfxId.");
         }
      }
      
      private function _modifiableFunc(input:ICustomDataInput) : void
      {
         this.modifiable = input.readBoolean();
      }
      
      private function _rightstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._rightstree.addChild(this._rightsFunc);
         }
      }
      
      private function _rightsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of rights.");
         }
         this.rights.push(_val);
      }
   }
}
