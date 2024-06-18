package com.ankamagames.dofus.network.types.game.mount
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class UpdateMountBooleanCharacteristic extends UpdateMountCharacteristic implements INetworkType
   {
      
      public static const protocolId:uint = 2137;
       
      
      public var value:Boolean = false;
      
      public function UpdateMountBooleanCharacteristic()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2137;
      }
      
      public function initUpdateMountBooleanCharacteristic(type:uint = 0, value:Boolean = false) : UpdateMountBooleanCharacteristic
      {
         super.initUpdateMountCharacteristic(type);
         this.value = value;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.value = false;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_UpdateMountBooleanCharacteristic(output);
      }
      
      public function serializeAs_UpdateMountBooleanCharacteristic(output:ICustomDataOutput) : void
      {
         super.serializeAs_UpdateMountCharacteristic(output);
         output.writeBoolean(this.value);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_UpdateMountBooleanCharacteristic(input);
      }
      
      public function deserializeAs_UpdateMountBooleanCharacteristic(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._valueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_UpdateMountBooleanCharacteristic(tree);
      }
      
      public function deserializeAsyncAs_UpdateMountBooleanCharacteristic(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._valueFunc);
      }
      
      private function _valueFunc(input:ICustomDataInput) : void
      {
         this.value = input.readBoolean();
      }
   }
}
