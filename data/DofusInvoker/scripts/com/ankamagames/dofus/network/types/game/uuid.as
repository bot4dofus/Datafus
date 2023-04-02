package com.ankamagames.dofus.network.types.game
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class uuid implements INetworkType
   {
      
      public static const protocolId:uint = 8514;
       
      
      public var uuidString:String = "";
      
      public function uuid()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 8514;
      }
      
      public function inituuid(uuidString:String = "") : uuid
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
         this.serializeAs_uuid(output);
      }
      
      public function serializeAs_uuid(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.uuidString);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_uuid(input);
      }
      
      public function deserializeAs_uuid(input:ICustomDataInput) : void
      {
         this._uuidStringFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_uuid(tree);
      }
      
      public function deserializeAsyncAs_uuid(tree:FuncTree) : void
      {
         tree.addChild(this._uuidStringFunc);
      }
      
      private function _uuidStringFunc(input:ICustomDataInput) : void
      {
         this.uuidString = input.readUTF();
      }
   }
}
