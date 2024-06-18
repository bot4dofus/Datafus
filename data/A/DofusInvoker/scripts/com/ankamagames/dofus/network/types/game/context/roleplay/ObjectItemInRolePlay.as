package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectItemInRolePlay implements INetworkType
   {
      
      public static const protocolId:uint = 1282;
       
      
      public var cellId:uint = 0;
      
      public var objectGID:uint = 0;
      
      public function ObjectItemInRolePlay()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1282;
      }
      
      public function initObjectItemInRolePlay(cellId:uint = 0, objectGID:uint = 0) : ObjectItemInRolePlay
      {
         this.cellId = cellId;
         this.objectGID = objectGID;
         return this;
      }
      
      public function reset() : void
      {
         this.cellId = 0;
         this.objectGID = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectItemInRolePlay(output);
      }
      
      public function serializeAs_ObjectItemInRolePlay(output:ICustomDataOutput) : void
      {
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         output.writeVarShort(this.cellId);
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         output.writeVarInt(this.objectGID);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectItemInRolePlay(input);
      }
      
      public function deserializeAs_ObjectItemInRolePlay(input:ICustomDataInput) : void
      {
         this._cellIdFunc(input);
         this._objectGIDFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectItemInRolePlay(tree);
      }
      
      public function deserializeAsyncAs_ObjectItemInRolePlay(tree:FuncTree) : void
      {
         tree.addChild(this._cellIdFunc);
         tree.addChild(this._objectGIDFunc);
      }
      
      private function _cellIdFunc(input:ICustomDataInput) : void
      {
         this.cellId = input.readVarUhShort();
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of ObjectItemInRolePlay.cellId.");
         }
      }
      
      private function _objectGIDFunc(input:ICustomDataInput) : void
      {
         this.objectGID = input.readVarUhInt();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectItemInRolePlay.objectGID.");
         }
      }
   }
}
