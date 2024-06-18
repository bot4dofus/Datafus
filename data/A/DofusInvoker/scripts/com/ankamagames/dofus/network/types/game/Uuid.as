package com.ankamagames.dofus.network.types.game
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class Uuid implements INetworkType
   {
      
      public static const protocolId:uint = 8662;
       
      
      public var uuidString:String = "";
      
      public function Uuid()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 8662;
      }
      
      public function initUuid(uuidString:String = "") : Uuid
      {
         this.uuidString = uuidString;
         return this;
      }
      
      public function reset() : void
      {
         this.uuidString = "";
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_Uuid(output);
      }
      
      public function serializeAs_Uuid(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.uuidString);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_Uuid(input);
      }
      
      public function deserializeAs_Uuid(input:ICustomDataInput) : void
      {
         this._uuidStringFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_Uuid(tree);
      }
      
      public function deserializeAsyncAs_Uuid(tree:FuncTree) : void
      {
         tree.addChild(this._uuidStringFunc);
      }
      
      private function _uuidStringFunc(input:ICustomDataInput) : void
      {
         this.uuidString = input.readUTF();
      }
   }
}
