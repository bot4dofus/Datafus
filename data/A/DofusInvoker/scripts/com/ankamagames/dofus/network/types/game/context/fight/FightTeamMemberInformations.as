package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightTeamMemberInformations implements INetworkType
   {
      
      public static const protocolId:uint = 6092;
       
      
      public var id:Number = 0;
      
      public function FightTeamMemberInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 6092;
      }
      
      public function initFightTeamMemberInformations(id:Number = 0) : FightTeamMemberInformations
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
         this.serializeAs_FightTeamMemberInformations(output);
      }
      
      public function serializeAs_FightTeamMemberInformations(output:ICustomDataOutput) : void
      {
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeDouble(this.id);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightTeamMemberInformations(input);
      }
      
      public function deserializeAs_FightTeamMemberInformations(input:ICustomDataInput) : void
      {
         this._idFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightTeamMemberInformations(tree);
      }
      
      public function deserializeAsyncAs_FightTeamMemberInformations(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readDouble();
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of FightTeamMemberInformations.id.");
         }
      }
   }
}
