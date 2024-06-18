package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class InteractiveElementNamedSkill extends InteractiveElementSkill implements INetworkType
   {
      
      public static const protocolId:uint = 7880;
       
      
      public var nameId:uint = 0;
      
      public function InteractiveElementNamedSkill()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7880;
      }
      
      public function initInteractiveElementNamedSkill(skillId:uint = 0, skillInstanceUid:uint = 0, nameId:uint = 0) : InteractiveElementNamedSkill
      {
         super.initInteractiveElementSkill(skillId,skillInstanceUid);
         this.nameId = nameId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.nameId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_InteractiveElementNamedSkill(output);
      }
      
      public function serializeAs_InteractiveElementNamedSkill(output:ICustomDataOutput) : void
      {
         super.serializeAs_InteractiveElementSkill(output);
         if(this.nameId < 0)
         {
            throw new Error("Forbidden value (" + this.nameId + ") on element nameId.");
         }
         output.writeVarInt(this.nameId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InteractiveElementNamedSkill(input);
      }
      
      public function deserializeAs_InteractiveElementNamedSkill(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._nameIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InteractiveElementNamedSkill(tree);
      }
      
      public function deserializeAsyncAs_InteractiveElementNamedSkill(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nameIdFunc);
      }
      
      private function _nameIdFunc(input:ICustomDataInput) : void
      {
         this.nameId = input.readVarUhInt();
         if(this.nameId < 0)
         {
            throw new Error("Forbidden value (" + this.nameId + ") on element of InteractiveElementNamedSkill.nameId.");
         }
      }
   }
}
