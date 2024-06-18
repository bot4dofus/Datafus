package com.ankamagames.dofus.network.types.game.approach
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ServerSessionConstantInteger extends ServerSessionConstant implements INetworkType
   {
      
      public static const protocolId:uint = 2867;
       
      
      public var value:int = 0;
      
      public function ServerSessionConstantInteger()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2867;
      }
      
      public function initServerSessionConstantInteger(id:uint = 0, value:int = 0) : ServerSessionConstantInteger
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
         this.serializeAs_ServerSessionConstantInteger(output);
      }
      
      public function serializeAs_ServerSessionConstantInteger(output:ICustomDataOutput) : void
      {
         super.serializeAs_ServerSessionConstant(output);
         output.writeInt(this.value);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ServerSessionConstantInteger(input);
      }
      
      public function deserializeAs_ServerSessionConstantInteger(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._valueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ServerSessionConstantInteger(tree);
      }
      
      public function deserializeAsyncAs_ServerSessionConstantInteger(tree:FuncTree) : void
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
