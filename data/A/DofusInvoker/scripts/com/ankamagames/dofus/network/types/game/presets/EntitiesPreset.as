package com.ankamagames.dofus.network.types.game.presets
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class EntitiesPreset extends Preset implements INetworkType
   {
      
      public static const protocolId:uint = 6250;
       
      
      public var iconId:uint = 0;
      
      public var entityIds:Vector.<uint>;
      
      private var _entityIdstree:FuncTree;
      
      public function EntitiesPreset()
      {
         this.entityIds = new Vector.<uint>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6250;
      }
      
      public function initEntitiesPreset(id:int = 0, iconId:uint = 0, entityIds:Vector.<uint> = null) : EntitiesPreset
      {
         super.initPreset(id);
         this.iconId = iconId;
         this.entityIds = entityIds;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.iconId = 0;
         this.entityIds = new Vector.<uint>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_EntitiesPreset(output);
      }
      
      public function serializeAs_EntitiesPreset(output:ICustomDataOutput) : void
      {
         super.serializeAs_Preset(output);
         if(this.iconId < 0)
         {
            throw new Error("Forbidden value (" + this.iconId + ") on element iconId.");
         }
         output.writeShort(this.iconId);
         output.writeShort(this.entityIds.length);
         for(var _i2:uint = 0; _i2 < this.entityIds.length; _i2++)
         {
            if(this.entityIds[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.entityIds[_i2] + ") on element 2 (starting at 1) of entityIds.");
            }
            output.writeVarShort(this.entityIds[_i2]);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_EntitiesPreset(input);
      }
      
      public function deserializeAs_EntitiesPreset(input:ICustomDataInput) : void
      {
         var _val2:uint = 0;
         super.deserialize(input);
         this._iconIdFunc(input);
         var _entityIdsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _entityIdsLen; _i2++)
         {
            _val2 = input.readVarUhShort();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of entityIds.");
            }
            this.entityIds.push(_val2);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_EntitiesPreset(tree);
      }
      
      public function deserializeAsyncAs_EntitiesPreset(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._iconIdFunc);
         this._entityIdstree = tree.addChild(this._entityIdstreeFunc);
      }
      
      private function _iconIdFunc(input:ICustomDataInput) : void
      {
         this.iconId = input.readShort();
         if(this.iconId < 0)
         {
            throw new Error("Forbidden value (" + this.iconId + ") on element of EntitiesPreset.iconId.");
         }
      }
      
      private function _entityIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._entityIdstree.addChild(this._entityIdsFunc);
         }
      }
      
      private function _entityIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of entityIds.");
         }
         this.entityIds.push(_val);
      }
   }
}
