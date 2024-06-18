package com.ankamagames.dofus.network.types.game.mount
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class UpdateMountCharacteristic implements INetworkType
   {
      
      public static const protocolId:uint = 470;
       
      
      public var type:uint = 0;
      
      public function UpdateMountCharacteristic()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 470;
      }
      
      public function initUpdateMountCharacteristic(type:uint = 0) : UpdateMountCharacteristic
      {
         this.type = type;
         return this;
      }
      
      public function reset() : void
      {
         this.type = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_UpdateMountCharacteristic(output);
      }
      
      public function serializeAs_UpdateMountCharacteristic(output:ICustomDataOutput) : void
      {
         output.writeByte(this.type);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_UpdateMountCharacteristic(input);
      }
      
      public function deserializeAs_UpdateMountCharacteristic(input:ICustomDataInput) : void
      {
         this._typeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_UpdateMountCharacteristic(tree);
      }
      
      public function deserializeAsyncAs_UpdateMountCharacteristic(tree:FuncTree) : void
      {
         tree.addChild(this._typeFunc);
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of UpdateMountCharacteristic.type.");
         }
      }
   }
}
