package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class InteractiveElementSkill implements INetworkType
   {
      
      public static const protocolId:uint = 2087;
       
      
      public var skillId:uint = 0;
      
      public var skillInstanceUid:uint = 0;
      
      public function InteractiveElementSkill()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2087;
      }
      
      public function initInteractiveElementSkill(skillId:uint = 0, skillInstanceUid:uint = 0) : InteractiveElementSkill
      {
         this.skillId = skillId;
         this.skillInstanceUid = skillInstanceUid;
         return this;
      }
      
      public function reset() : void
      {
         this.skillId = 0;
         this.skillInstanceUid = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_InteractiveElementSkill(output);
      }
      
      public function serializeAs_InteractiveElementSkill(output:ICustomDataOutput) : void
      {
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
         }
         output.writeVarInt(this.skillId);
         if(this.skillInstanceUid < 0)
         {
            throw new Error("Forbidden value (" + this.skillInstanceUid + ") on element skillInstanceUid.");
         }
         output.writeInt(this.skillInstanceUid);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InteractiveElementSkill(input);
      }
      
      public function deserializeAs_InteractiveElementSkill(input:ICustomDataInput) : void
      {
         this._skillIdFunc(input);
         this._skillInstanceUidFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InteractiveElementSkill(tree);
      }
      
      public function deserializeAsyncAs_InteractiveElementSkill(tree:FuncTree) : void
      {
         tree.addChild(this._skillIdFunc);
         tree.addChild(this._skillInstanceUidFunc);
      }
      
      private function _skillIdFunc(input:ICustomDataInput) : void
      {
         this.skillId = input.readVarUhInt();
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element of InteractiveElementSkill.skillId.");
         }
      }
      
      private function _skillInstanceUidFunc(input:ICustomDataInput) : void
      {
         this.skillInstanceUid = input.readInt();
         if(this.skillInstanceUid < 0)
         {
            throw new Error("Forbidden value (" + this.skillInstanceUid + ") on element of InteractiveElementSkill.skillInstanceUid.");
         }
      }
   }
}
