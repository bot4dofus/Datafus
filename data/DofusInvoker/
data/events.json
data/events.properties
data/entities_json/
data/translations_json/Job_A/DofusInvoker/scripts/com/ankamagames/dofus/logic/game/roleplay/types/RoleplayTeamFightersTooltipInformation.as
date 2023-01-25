package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberEntityInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberWithAllianceCharacterInformations;
   import com.ankamagames.jerakine.data.I18n;
   import flash.utils.Dictionary;
   
   public class RoleplayTeamFightersTooltipInformation
   {
       
      
      private var _waitingCompanions:Dictionary;
      
      public var fighters:Vector.<Fighter>;
      
      public var nbWaves:uint;
      
      public function RoleplayTeamFightersTooltipInformation(pFightTeam:FightTeam)
      {
         var fightMemberInfo:FightTeamMemberInformations = null;
         var i:int = 0;
         var fighter:Fighter = null;
         var allianceTag:String = null;
         var monster:Monster = null;
         var monsterLevel:uint = 0;
         var monsterName:String = null;
         var taxCollectorLevel:uint = 0;
         var firstName:String = null;
         var lastName:String = null;
         var taxCollectorName:String = null;
         var companionInfo:FightTeamMemberEntityInformation = null;
         super();
         this.nbWaves = pFightTeam.teamInfos.nbWaves;
         this.fighters = new Vector.<Fighter>();
         var len:int = pFightTeam.teamInfos.teamMembers.length;
         for(i = 0; i < len; i++)
         {
            fightMemberInfo = pFightTeam.teamInfos.teamMembers[i];
            fighter = null;
            switch(true)
            {
               case fightMemberInfo is FightTeamMemberCharacterInformations:
                  allianceTag = "";
                  if(fightMemberInfo is FightTeamMemberWithAllianceCharacterInformations)
                  {
                     allianceTag = (fightMemberInfo as FightTeamMemberWithAllianceCharacterInformations).allianceInfos.allianceTag;
                  }
                  fighter = new Fighter(fightMemberInfo.id,(fightMemberInfo as FightTeamMemberCharacterInformations).name,(fightMemberInfo as FightTeamMemberCharacterInformations).level,allianceTag);
                  break;
               case fightMemberInfo is FightTeamMemberMonsterInformations:
                  monster = Monster.getMonsterById((fightMemberInfo as FightTeamMemberMonsterInformations).monsterId);
                  monsterLevel = monster.getMonsterGrade((fightMemberInfo as FightTeamMemberMonsterInformations).grade).level;
                  monsterName = monster.name;
                  fighter = new Fighter(fightMemberInfo.id,monsterName,monsterLevel);
                  break;
               case fightMemberInfo is FightTeamMemberTaxCollectorInformations:
                  taxCollectorLevel = (fightMemberInfo as FightTeamMemberTaxCollectorInformations).level;
                  firstName = TaxCollectorFirstname.getTaxCollectorFirstnameById((fightMemberInfo as FightTeamMemberTaxCollectorInformations).firstNameId).firstname;
                  lastName = TaxCollectorName.getTaxCollectorNameById((fightMemberInfo as FightTeamMemberTaxCollectorInformations).lastNameId).name;
                  taxCollectorName = firstName + " " + lastName;
                  fighter = new Fighter(fightMemberInfo.id,taxCollectorName,taxCollectorLevel);
                  break;
               case fightMemberInfo is FightTeamMemberEntityInformation:
                  companionInfo = fightMemberInfo as FightTeamMemberEntityInformation;
                  if(this.fighters.length > 0 && i > 0 && this.fighters.length >= i && this.fighters[i - 1].id == companionInfo.masterId)
                  {
                     fighter = this.getCompanionFighter(this.fighters[i - 1],companionInfo.id,companionInfo.entityModelId);
                  }
                  else
                  {
                     if(!this._waitingCompanions)
                     {
                        this._waitingCompanions = new Dictionary();
                     }
                     this._waitingCompanions[companionInfo.masterId] = {
                        "id":companionInfo.id,
                        "genericId":companionInfo.entityModelId
                     };
                  }
                  break;
            }
            if(fighter)
            {
               this.fighters.push(fighter);
               if(this._waitingCompanions && this._waitingCompanions[fighter.id])
               {
                  this.fighters.push(this.getCompanionFighter(fighter,this._waitingCompanions[fighter.id].id,this._waitingCompanions[fighter.id].genericId));
                  delete this._waitingCompanions[fighter.id];
               }
            }
         }
      }
      
      private function getCompanionFighter(pFighter:Fighter, pCompanionId:int, pCompanionGenericId:int) : Fighter
      {
         return new Fighter(pCompanionId,I18n.getUiText("ui.common.belonging",[Companion.getCompanionById(pCompanionGenericId).name,pFighter.name]),pFighter.level,pFighter.allianceTagName);
      }
   }
}

class Fighter
{
    
   
   private var _id:Number;
   
   public var allianceTagName:String;
   
   public var name:String;
   
   public var level:uint;
   
   function Fighter(pId:Number, pName:String, pLevel:uint, pAllianceTagName:String = null)
   {
      super();
      this._id = pId;
      this.name = pName;
      this.level = pLevel;
      this.allianceTagName = pAllianceTagName;
   }
   
   public function get allianceTag() : String
   {
      return !!this.allianceTagName ? "[" + this.allianceTagName + "]" : null;
   }
   
   public function get id() : Number
   {
      return this._id;
   }
}
