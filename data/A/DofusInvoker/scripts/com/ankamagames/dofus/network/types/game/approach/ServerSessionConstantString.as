package com.ankamagames.dofus.network.types.game.approach
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ServerSessionConstantString extends ServerSessionConstant implements INetworkType
   {
      
      public static const protocolId:uint = 8828;
       
      
      public var value:String = "";
      
      public function ServerSessionConstantString()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8828;
      }
      
      public function initServerSessionConstantString(id:uint = 0, value:String = "") : ServerSessionConstantString
      {
         super.initServerSessionConstant(id);
         this.value = value;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.value = "";
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ServerSessionConstantString(output);
      }
      
      public function serializeAs_ServerSessionConstantString(output:ICustomDataOutput) : void
      {
         super.serializeAs_ServerSessionConstant(output);
         output.writeUTF(this.value);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ServerSessionConstantString(input);
      }
      
      public function deserializeAs_ServerSessionConstantString(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._valueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ServerSessionConstantString(tree);
      }
      
      public function deserializeAsyncAs_ServerSessionConstantString(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._valueFunc);
      }
      
      private function _valueFunc(input:ICustomDataInput) : void
      {
         this.value = input.readUTF();
      }
   }
}
