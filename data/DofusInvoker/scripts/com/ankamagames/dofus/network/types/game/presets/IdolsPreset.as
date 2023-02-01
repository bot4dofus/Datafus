package com.ankamagames.dofus.network.types.game.presets
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class IdolsPreset extends Preset implements INetworkType
   {
      
      public static const protocolId:uint = 9110;
       
      
      public var iconId:uint = 0;
      
      public var idolIds:Vector.<uint>;
      
      private var _idolIdstree:FuncTree;
      
      public function IdolsPreset()
      {
         this.idolIds = new Vector.<uint>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9110;
      }
      
      public function initIdolsPreset(id:int = 0, iconId:uint = 0, idolIds:Vector.<uint> = null) : IdolsPreset
      {
         super.initPreset(id);
         this.iconId = iconId;
         this.idolIds = idolIds;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.iconId = 0;
         this.idolIds = new Vector.<uint>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_IdolsPreset(output);
      }
      
      public function serializeAs_IdolsPreset(output:ICustomDataOutput) : void
      {
         super.serializeAs_Preset(output);
         if(this.iconId < 0)
         {
            throw new Error("Forbidden value (" + this.iconId + ") on element iconId.");
         }
         output.writeShort(this.iconId);
         output.writeShort(this.idolIds.length);
         for(var _i2:uint = 0; _i2 < this.idolIds.length; _i2++)
         {
            if(this.idolIds[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.idolIds[_i2] + ") on element 2 (starting at 1) of idolIds.");
            }
            output.writeVarShort(this.idolIds[_i2]);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IdolsPreset(input);
      }
      
      public function deserializeAs_IdolsPreset(input:ICustomDataInput) : void
      {
         var _val2:uint = 0;
         super.deserialize(input);
         this._iconIdFunc(input);
         var _idolIdsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _idolIdsLen; _i2++)
         {
            _val2 = input.readVarUhShort();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of idolIds.");
            }
            this.idolIds.push(_val2);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IdolsPreset(tree);
      }
      
      public function deserializeAsyncAs_IdolsPreset(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._iconIdFunc);
         this._idolIdstree = tree.addChild(this._idolIdstreeFunc);
      }
      
      private function _iconIdFunc(input:ICustomDataInput) : void
      {
         this.iconId = input.readShort();
         if(this.iconId < 0)
         {
            throw new Error("Forbidden value (" + this.iconId + ") on element of IdolsPreset.iconId.");
         }
      }
      
      private function _idolIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._idolIdstree.addChild(this._idolIdsFunc);
         }
      }
      
      private function _idolIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of idolIds.");
         }
         this.idolIds.push(_val);
      }
   }
}
