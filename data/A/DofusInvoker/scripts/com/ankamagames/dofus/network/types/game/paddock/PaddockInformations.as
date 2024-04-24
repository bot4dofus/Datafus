package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PaddockInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3212;
       
      
      public var maxOutdoorMount:uint = 0;
      
      public var maxItems:uint = 0;
      
      public function PaddockInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3212;
      }
      
      public function initPaddockInformations(maxOutdoorMount:uint = 0, maxItems:uint = 0) : PaddockInformations
      {
         this.maxOutdoorMount = maxOutdoorMount;
         this.maxItems = maxItems;
         return this;
      }
      
      public function reset() : void
      {
         this.maxOutdoorMount = 0;
         this.maxItems = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PaddockInformations(output);
      }
      
      public function serializeAs_PaddockInformations(output:ICustomDataOutput) : void
      {
         if(this.maxOutdoorMount < 0)
         {
            throw new Error("Forbidden value (" + this.maxOutdoorMount + ") on element maxOutdoorMount.");
         }
         output.writeVarShort(this.maxOutdoorMount);
         if(this.maxItems < 0)
         {
            throw new Error("Forbidden value (" + this.maxItems + ") on element maxItems.");
         }
         output.writeVarShort(this.maxItems);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockInformations(input);
      }
      
      public function deserializeAs_PaddockInformations(input:ICustomDataInput) : void
      {
         this._maxOutdoorMountFunc(input);
         this._maxItemsFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaddockInformations(tree);
      }
      
      public function deserializeAsyncAs_PaddockInformations(tree:FuncTree) : void
      {
         tree.addChild(this._maxOutdoorMountFunc);
         tree.addChild(this._maxItemsFunc);
      }
      
      private function _maxOutdoorMountFunc(input:ICustomDataInput) : void
      {
         this.maxOutdoorMount = input.readVarUhShort();
         if(this.maxOutdoorMount < 0)
         {
            throw new Error("Forbidden value (" + this.maxOutdoorMount + ") on element of PaddockInformations.maxOutdoorMount.");
         }
      }
      
      private function _maxItemsFunc(input:ICustomDataInput) : void
      {
         this.maxItems = input.readVarUhShort();
         if(this.maxItems < 0)
         {
            throw new Error("Forbidden value (" + this.maxItems + ") on element of PaddockInformations.maxItems.");
         }
      }
   }
}
