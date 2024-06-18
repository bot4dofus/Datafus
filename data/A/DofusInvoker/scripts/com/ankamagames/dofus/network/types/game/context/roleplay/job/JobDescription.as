package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.interactive.skill.SkillActionDescription;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class JobDescription implements INetworkType
   {
      
      public static const protocolId:uint = 4698;
       
      
      public var jobId:uint = 0;
      
      public var skills:Vector.<SkillActionDescription>;
      
      private var _skillstree:FuncTree;
      
      public function JobDescription()
      {
         this.skills = new Vector.<SkillActionDescription>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4698;
      }
      
      public function initJobDescription(jobId:uint = 0, skills:Vector.<SkillActionDescription> = null) : JobDescription
      {
         this.jobId = jobId;
         this.skills = skills;
         return this;
      }
      
      public function reset() : void
      {
         this.jobId = 0;
         this.skills = new Vector.<SkillActionDescription>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_JobDescription(output);
      }
      
      public function serializeAs_JobDescription(output:ICustomDataOutput) : void
      {
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
         }
         output.writeByte(this.jobId);
         output.writeShort(this.skills.length);
         for(var _i2:uint = 0; _i2 < this.skills.length; _i2++)
         {
            output.writeShort((this.skills[_i2] as SkillActionDescription).getTypeId());
            (this.skills[_i2] as SkillActionDescription).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobDescription(input);
      }
      
      public function deserializeAs_JobDescription(input:ICustomDataInput) : void
      {
         var _id2:uint = 0;
         var _item2:SkillActionDescription = null;
         this._jobIdFunc(input);
         var _skillsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _skillsLen; _i2++)
         {
            _id2 = input.readUnsignedShort();
            _item2 = ProtocolTypeManager.getInstance(SkillActionDescription,_id2);
            _item2.deserialize(input);
            this.skills.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobDescription(tree);
      }
      
      public function deserializeAsyncAs_JobDescription(tree:FuncTree) : void
      {
         tree.addChild(this._jobIdFunc);
         this._skillstree = tree.addChild(this._skillstreeFunc);
      }
      
      private function _jobIdFunc(input:ICustomDataInput) : void
      {
         this.jobId = input.readByte();
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element of JobDescription.jobId.");
         }
      }
      
      private function _skillstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._skillstree.addChild(this._skillsFunc);
         }
      }
      
      private function _skillsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:SkillActionDescription = ProtocolTypeManager.getInstance(SkillActionDescription,_id);
         _item.deserialize(input);
         this.skills.push(_item);
      }
   }
}
