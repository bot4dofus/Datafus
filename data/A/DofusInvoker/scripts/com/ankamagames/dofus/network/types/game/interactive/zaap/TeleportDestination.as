package com.ankamagames.dofus.network.types.game.interactive.zaap
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TeleportDestination implements INetworkType
   {
      
      public static const protocolId:uint = 4498;
       
      
      public var type:uint = 0;
      
      public var mapId:Number = 0;
      
      public var subAreaId:uint = 0;
      
      public var level:uint = 0;
      
      public var cost:uint = 0;
      
      public function TeleportDestination()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4498;
      }
      
      public function initTeleportDestination(type:uint = 0, mapId:Number = 0, subAreaId:uint = 0, level:uint = 0, cost:uint = 0) : TeleportDestination
      {
         this.type = type;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.level = level;
         this.cost = cost;
         return this;
      }
      
      public function reset() : void
      {
         this.type = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.level = 0;
         this.cost = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TeleportDestination(output);
      }
      
      public function serializeAs_TeleportDestination(output:ICustomDataOutput) : void
      {
         output.writeByte(this.type);
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
         if(this.cost < 0)
         {
            throw new Error("Forbidden value (" + this.cost + ") on element cost.");
         }
         output.writeVarShort(this.cost);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportDestination(input);
      }
      
      public function deserializeAs_TeleportDestination(input:ICustomDataInput) : void
      {
         this._typeFunc(input);
         this._mapIdFunc(input);
         this._subAreaIdFunc(input);
         this._levelFunc(input);
         this._costFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TeleportDestination(tree);
      }
      
      public function deserializeAsyncAs_TeleportDestination(tree:FuncTree) : void
      {
         tree.addChild(this._typeFunc);
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._levelFunc);
         tree.addChild(this._costFunc);
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of TeleportDestination.type.");
         }
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of TeleportDestination.mapId.");
         }
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of TeleportDestination.subAreaId.");
         }
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of TeleportDestination.level.");
         }
      }
      
      private function _costFunc(input:ICustomDataInput) : void
      {
         this.cost = input.readVarUhShort();
         if(this.cost < 0)
         {
            throw new Error("Forbidden value (" + this.cost + ") on element of TeleportDestination.cost.");
         }
      }
   }
}
