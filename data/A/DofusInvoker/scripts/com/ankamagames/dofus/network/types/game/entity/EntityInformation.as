package com.ankamagames.dofus.network.types.game.entity
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class EntityInformation implements INetworkType
   {
      
      public static const protocolId:uint = 9779;
       
      
      public var id:uint = 0;
      
      public var experience:uint = 0;
      
      public var status:Boolean = false;
      
      public function EntityInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9779;
      }
      
      public function initEntityInformation(id:uint = 0, experience:uint = 0, status:Boolean = false) : EntityInformation
      {
         this.id = id;
         this.experience = experience;
         this.status = status;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.experience = 0;
         this.status = false;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_EntityInformation(output);
      }
      
      public function serializeAs_EntityInformation(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarShort(this.id);
         if(this.experience < 0)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element experience.");
         }
         output.writeVarInt(this.experience);
         output.writeBoolean(this.status);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_EntityInformation(input);
      }
      
      public function deserializeAs_EntityInformation(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._experienceFunc(input);
         this._statusFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_EntityInformation(tree);
      }
      
      public function deserializeAsyncAs_EntityInformation(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._experienceFunc);
         tree.addChild(this._statusFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhShort();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of EntityInformation.id.");
         }
      }
      
      private function _experienceFunc(input:ICustomDataInput) : void
      {
         this.experience = input.readVarUhInt();
         if(this.experience < 0)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element of EntityInformation.experience.");
         }
      }
      
      private function _statusFunc(input:ICustomDataInput) : void
      {
         this.status = input.readBoolean();
      }
   }
}
