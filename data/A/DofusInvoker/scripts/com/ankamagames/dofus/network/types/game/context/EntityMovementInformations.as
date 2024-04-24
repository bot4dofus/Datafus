package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class EntityMovementInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7529;
       
      
      public var id:int = 0;
      
      public var steps:Vector.<int>;
      
      private var _stepstree:FuncTree;
      
      public function EntityMovementInformations()
      {
         this.steps = new Vector.<int>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7529;
      }
      
      public function initEntityMovementInformations(id:int = 0, steps:Vector.<int> = null) : EntityMovementInformations
      {
         this.id = id;
         this.steps = steps;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.steps = new Vector.<int>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_EntityMovementInformations(output);
      }
      
      public function serializeAs_EntityMovementInformations(output:ICustomDataOutput) : void
      {
         output.writeInt(this.id);
         output.writeShort(this.steps.length);
         for(var _i2:uint = 0; _i2 < this.steps.length; _i2++)
         {
            output.writeByte(this.steps[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_EntityMovementInformations(input);
      }
      
      public function deserializeAs_EntityMovementInformations(input:ICustomDataInput) : void
      {
         var _val2:int = 0;
         this._idFunc(input);
         var _stepsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _stepsLen; _i2++)
         {
            _val2 = input.readByte();
            this.steps.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_EntityMovementInformations(tree);
      }
      
      public function deserializeAsyncAs_EntityMovementInformations(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         this._stepstree = tree.addChild(this._stepstreeFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readInt();
      }
      
      private function _stepstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._stepstree.addChild(this._stepsFunc);
         }
      }
      
      private function _stepsFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readByte();
         this.steps.push(_val);
      }
   }
}
