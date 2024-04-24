package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HouseOnMapInformations extends HouseInformations implements INetworkType
   {
      
      public static const protocolId:uint = 6443;
       
      
      public var doorsOnMap:Vector.<uint>;
      
      public var houseInstances:Vector.<HouseInstanceInformations>;
      
      private var _doorsOnMaptree:FuncTree;
      
      private var _houseInstancestree:FuncTree;
      
      public function HouseOnMapInformations()
      {
         this.doorsOnMap = new Vector.<uint>();
         this.houseInstances = new Vector.<HouseInstanceInformations>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6443;
      }
      
      public function initHouseOnMapInformations(houseId:uint = 0, modelId:uint = 0, doorsOnMap:Vector.<uint> = null, houseInstances:Vector.<HouseInstanceInformations> = null) : HouseOnMapInformations
      {
         super.initHouseInformations(houseId,modelId);
         this.doorsOnMap = doorsOnMap;
         this.houseInstances = houseInstances;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.doorsOnMap = new Vector.<uint>();
         this.houseInstances = new Vector.<HouseInstanceInformations>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HouseOnMapInformations(output);
      }
      
      public function serializeAs_HouseOnMapInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_HouseInformations(output);
         output.writeShort(this.doorsOnMap.length);
         for(var _i1:uint = 0; _i1 < this.doorsOnMap.length; _i1++)
         {
            if(this.doorsOnMap[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.doorsOnMap[_i1] + ") on element 1 (starting at 1) of doorsOnMap.");
            }
            output.writeInt(this.doorsOnMap[_i1]);
         }
         output.writeShort(this.houseInstances.length);
         for(var _i2:uint = 0; _i2 < this.houseInstances.length; _i2++)
         {
            (this.houseInstances[_i2] as HouseInstanceInformations).serializeAs_HouseInstanceInformations(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseOnMapInformations(input);
      }
      
      public function deserializeAs_HouseOnMapInformations(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _item2:HouseInstanceInformations = null;
         super.deserialize(input);
         var _doorsOnMapLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _doorsOnMapLen; _i1++)
         {
            _val1 = input.readInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of doorsOnMap.");
            }
            this.doorsOnMap.push(_val1);
         }
         var _houseInstancesLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _houseInstancesLen; _i2++)
         {
            _item2 = new HouseInstanceInformations();
            _item2.deserialize(input);
            this.houseInstances.push(_item2);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseOnMapInformations(tree);
      }
      
      public function deserializeAsyncAs_HouseOnMapInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._doorsOnMaptree = tree.addChild(this._doorsOnMaptreeFunc);
         this._houseInstancestree = tree.addChild(this._houseInstancestreeFunc);
      }
      
      private function _doorsOnMaptreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._doorsOnMaptree.addChild(this._doorsOnMapFunc);
         }
      }
      
      private function _doorsOnMapFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of doorsOnMap.");
         }
         this.doorsOnMap.push(_val);
      }
      
      private function _houseInstancestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._houseInstancestree.addChild(this._houseInstancesFunc);
         }
      }
      
      private function _houseInstancesFunc(input:ICustomDataInput) : void
      {
         var _item:HouseInstanceInformations = new HouseInstanceInformations();
         _item.deserialize(input);
         this.houseInstances.push(_item);
      }
   }
}
