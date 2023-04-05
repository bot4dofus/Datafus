package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class SocialFightersWrapper implements IDataCenter
   {
       
      
      public var ally:uint;
      
      public var playerCharactersInformations:CharacterMinimalPlusLookInformations;
      
      public var entityLook:TiphonEntityLook;
      
      public function SocialFightersWrapper()
      {
         super();
      }
      
      public static function create(pAlly:uint, pFightersInformations:CharacterMinimalPlusLookInformations) : SocialFightersWrapper
      {
         var item:SocialFightersWrapper = new SocialFightersWrapper();
         item.ally = pAlly;
         item.playerCharactersInformations = pFightersInformations;
         if(pFightersInformations.entityLook != null)
         {
            item.entityLook = EntityLookAdapter.getRiderLook(pFightersInformations.entityLook);
         }
         return item;
      }
      
      public function update(pAlly:uint, pFightersInformations:CharacterMinimalPlusLookInformations) : void
      {
         this.ally = pAlly;
         this.playerCharactersInformations = pFightersInformations;
         if(pFightersInformations.entityLook != null)
         {
            this.entityLook = EntityLookAdapter.getRiderLook(pFightersInformations.entityLook);
         }
      }
   }
}
