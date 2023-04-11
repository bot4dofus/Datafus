package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.dofus.network.types.game.friend.IgnoredInformations;
   import com.ankamagames.dofus.network.types.game.friend.IgnoredOnlineInformations;
   import com.ankamagames.jerakine.enum.SocialCharacterCategoryEnum;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EnemyWrapper extends SocialCharacterWrapper implements IDataCenter
   {
       
      
      private var _item:IgnoredInformations;
      
      public function EnemyWrapper(o:IgnoredInformations)
      {
         super(o.accountTag.nickname,o.accountTag.tagNumber,o.accountId);
         e_category = SocialCharacterCategoryEnum.CATEGORY_ENEMY;
         this._item = o;
         if(o is IgnoredOnlineInformations)
         {
            playerName = IgnoredOnlineInformations(o).playerName;
            playerId = IgnoredOnlineInformations(o).playerId;
            breed = IgnoredOnlineInformations(o).breed;
            sex = !!IgnoredOnlineInformations(o).sex ? uint(1) : uint(0);
            online = true;
         }
      }
   }
}
