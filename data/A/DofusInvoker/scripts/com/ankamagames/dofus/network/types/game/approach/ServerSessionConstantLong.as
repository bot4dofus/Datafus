package com.ankamagames.dofus.network.types.game.approach
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ServerSessionConstantLong extends ServerSessionConstant implements INetworkType
   {
      
      public static const protocolId:uint = 4175;
       
      
      public var value:Number = 0;
      
      public function ServerSessionConstantLong()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4175;
      }
      
      public function initServerSessionConstantLong(id:uint = 0, value:Number = 0) : ServerSessionConstantLong
      {
         super.initServerSessionConstant(id);
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
         this.serializeAs_ServerSessionConstantLong(output);
      }
      
      public function serializeAs_ServerSessionConstantLong(output:ICustomDataOutput) : void
      {
         super.serializeAs_ServerSessionConstant(output);
         if(this.value < -9007199254740992 || this.value > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.value + ") on element value.");
         }
         output.writeDouble(this.value);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ServerSessionConstantLong(input);
      }
      
      public function deserializeAs_ServerSessionConstantLong(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._valueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ServerSessionConstantLong(tree);
      }
      
      public function deserializeAsyncAs_ServerSessionConstantLong(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._valueFunc);
      }
      
      private function _valueFunc(input:ICustomDataInput) : void
      {
         this.value = input.readDouble();
         if(this.value < -9007199254740992 || this.value > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.value + ") on element of ServerSessionConstantLong.value.");
         }
      }
   }
}
