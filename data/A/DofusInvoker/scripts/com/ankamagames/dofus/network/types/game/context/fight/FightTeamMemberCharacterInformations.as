package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightTeamMemberCharacterInformations extends FightTeamMemberInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3781;
       
      
      public var name:String = "";
      
      public var level:uint = 0;
      
      public function FightTeamMemberCharacterInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3781;
      }
      
      public function initFightTeamMemberCharacterInformations(id:Number = 0, name:String = "", level:uint = 0) : FightTeamMemberCharacterInformations
      {
         super.initFightTeamMemberInformations(id);
         this.name = name;
         this.level = level;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.name = "";
         this.level = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightTeamMemberCharacterInformations(output);
      }
      
      public function serializeAs_FightTeamMemberCharacterInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightTeamMemberInformations(output);
         output.writeUTF(this.name);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightTeamMemberCharacterInformations(input);
      }
      
      public function deserializeAs_FightTeamMemberCharacterInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._nameFunc(input);
         this._levelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightTeamMemberCharacterInformations(tree);
      }
      
      public function deserializeAsyncAs_FightTeamMemberCharacterInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nameFunc);
         tree.addChild(this._levelFunc);
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of FightTeamMemberCharacterInformations.level.");
         }
      }
   }
}
