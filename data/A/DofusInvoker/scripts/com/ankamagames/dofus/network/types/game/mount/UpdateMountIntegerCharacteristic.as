package com.ankamagames.dofus.network.types.game.mount
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class UpdateMountIntegerCharacteristic extends UpdateMountCharacteristic implements INetworkType
   {
      
      public static const protocolId:uint = 5600;
       
      
      public var value:int = 0;
      
      public function UpdateMountIntegerCharacteristic()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5600;
      }
      
      public function initUpdateMountIntegerCharacteristic(type:uint = 0, value:int = 0) : UpdateMountIntegerCharacteristic
      {
         super.initUpdateMountCharacteristic(type);
         this.value = value;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.value = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_UpdateMountIntegerCharacteristic(output);
      }
      
      public function serializeAs_UpdateMountIntegerCharacteristic(output:ICustomDataOutput) : void
      {
         super.serializeAs_UpdateMountCharacteristic(output);
         output.writeInt(this.value);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_UpdateMountIntegerCharacteristic(input);
      }
      
      public function deserializeAs_UpdateMountIntegerCharacteristic(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._valueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_UpdateMountIntegerCharacteristic(tree);
      }
      
      public function deserializeAsyncAs_UpdateMountIntegerCharacteristic(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._valueFunc);
      }
      
      private function _valueFunc(input:ICustomDataInput) : void
      {
         this.value = input.readInt();
      }
   }
}
