package com.ankamagames.dofus.network.types.game.context.roleplay.party.entity
{
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PartyEntityBaseInformation implements INetworkType
   {
      
      public static const protocolId:uint = 5790;
       
      
      public var indexId:uint = 0;
      
      public var entityModelId:uint = 0;
      
      public var entityLook:EntityLook;
      
      private var _entityLooktree:FuncTree;
      
      public function PartyEntityBaseInformation()
      {
         this.entityLook = new EntityLook();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 5790;
      }
      
      public function initPartyEntityBaseInformation(indexId:uint = 0, entityModelId:uint = 0, entityLook:EntityLook = null) : PartyEntityBaseInformation
      {
         this.indexId = indexId;
         this.entityModelId = entityModelId;
         this.entityLook = entityLook;
         return this;
      }
      
      public function reset() : void
      {
         this.indexId = 0;
         this.entityModelId = 0;
         this.entityLook = new EntityLook();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PartyEntityBaseInformation(output);
      }
      
      public function serializeAs_PartyEntityBaseInformation(output:ICustomDataOutput) : void
      {
         if(this.indexId < 0)
         {
            throw new Error("Forbidden value (" + this.indexId + ") on element indexId.");
         }
         output.writeByte(this.indexId);
         if(this.entityModelId < 0)
         {
            throw new Error("Forbidden value (" + this.entityModelId + ") on element entityModelId.");
         }
         output.writeByte(this.entityModelId);
         this.entityLook.serializeAs_EntityLook(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyEntityBaseInformation(input);
      }
      
      public function deserializeAs_PartyEntityBaseInformation(input:ICustomDataInput) : void
      {
         this._indexIdFunc(input);
         this._entityModelIdFunc(input);
         this.entityLook = new EntityLook();
         this.entityLook.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyEntityBaseInformation(tree);
      }
      
      public function deserializeAsyncAs_PartyEntityBaseInformation(tree:FuncTree) : void
      {
         tree.addChild(this._indexIdFunc);
         tree.addChild(this._entityModelIdFunc);
         this._entityLooktree = tree.addChild(this._entityLooktreeFunc);
      }
      
      private function _indexIdFunc(input:ICustomDataInput) : void
      {
         this.indexId = input.readByte();
         if(this.indexId < 0)
         {
            throw new Error("Forbidden value (" + this.indexId + ") on element of PartyEntityBaseInformation.indexId.");
         }
      }
      
      private function _entityModelIdFunc(input:ICustomDataInput) : void
      {
         this.entityModelId = input.readByte();
         if(this.entityModelId < 0)
         {
            throw new Error("Forbidden value (" + this.entityModelId + ") on element of PartyEntityBaseInformation.entityModelId.");
         }
      }
      
      private function _entityLooktreeFunc(input:ICustomDataInput) : void
      {
         this.entityLook = new EntityLook();
         this.entityLook.deserializeAsync(this._entityLooktree);
      }
   }
}
