package com.ankamagames.dofus.network.types.game.approach
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ServerSessionConstant implements INetworkType
   {
      
      public static const protocolId:uint = 9924;
       
      
      public var id:uint = 0;
      
      public function ServerSessionConstant()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9924;
      }
      
      public function initServerSessionConstant(id:uint = 0) : ServerSessionConstant
      {
         this.id = id;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ServerSessionConstant(output);
      }
      
      public function serializeAs_ServerSessionConstant(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarShort(this.id);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ServerSessionConstant(input);
      }
      
      public function deserializeAs_ServerSessionConstant(input:ICustomDataInput) : void
      {
         this._idFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ServerSessionConstant(tree);
      }
      
      public function deserializeAsyncAs_ServerSessionConstant(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhShort();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of ServerSessionConstant.id.");
         }
      }
   }
}
