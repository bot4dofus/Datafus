package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectEffectString extends ObjectEffect implements INetworkType
   {
      
      public static const protocolId:uint = 8837;
       
      
      public var value:String = "";
      
      public function ObjectEffectString()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8837;
      }
      
      public function initObjectEffectString(actionId:uint = 0, value:String = "") : ObjectEffectString
      {
         super.initObjectEffect(actionId);
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
         this.serializeAs_ObjectEffectString(output);
      }
      
      public function serializeAs_ObjectEffectString(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectEffect(output);
         output.writeUTF(this.value);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectEffectString(input);
      }
      
      public function deserializeAs_ObjectEffectString(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._valueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectEffectString(tree);
      }
      
      public function deserializeAsyncAs_ObjectEffectString(tree:FuncTree) : void
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
