package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class MountInformationsForPaddock implements INetworkType
   {
      
      public static const protocolId:uint = 4252;
       
      
      public var modelId:uint = 0;
      
      public var name:String = "";
      
      public var ownerName:String = "";
      
      public function MountInformationsForPaddock()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4252;
      }
      
      public function initMountInformationsForPaddock(modelId:uint = 0, name:String = "", ownerName:String = "") : MountInformationsForPaddock
      {
         this.modelId = modelId;
         this.name = name;
         this.ownerName = ownerName;
         return this;
      }
      
      public function reset() : void
      {
         this.modelId = 0;
         this.name = "";
         this.ownerName = "";
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_MountInformationsForPaddock(output);
      }
      
      public function serializeAs_MountInformationsForPaddock(output:ICustomDataOutput) : void
      {
         if(this.modelId < 0)
         {
            throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
         }
         output.writeVarShort(this.modelId);
         output.writeUTF(this.name);
         output.writeUTF(this.ownerName);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MountInformationsForPaddock(input);
      }
      
      public function deserializeAs_MountInformationsForPaddock(input:ICustomDataInput) : void
      {
         this._modelIdFunc(input);
         this._nameFunc(input);
         this._ownerNameFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MountInformationsForPaddock(tree);
      }
      
      public function deserializeAsyncAs_MountInformationsForPaddock(tree:FuncTree) : void
      {
         tree.addChild(this._modelIdFunc);
         tree.addChild(this._nameFunc);
         tree.addChild(this._ownerNameFunc);
      }
      
      private function _modelIdFunc(input:ICustomDataInput) : void
      {
         this.modelId = input.readVarUhShort();
         if(this.modelId < 0)
         {
            throw new Error("Forbidden value (" + this.modelId + ") on element of MountInformationsForPaddock.modelId.");
         }
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
      
      private function _ownerNameFunc(input:ICustomDataInput) : void
      {
         this.ownerName = input.readUTF();
      }
   }
}
