package com.ankamagames.dofus.internalDatacenter.alterations
{
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.network.enums.AlterationExpirationTypeEnum;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.types.Uri;
   
   public class AlterationUtils
   {
       
      
      public function AlterationUtils()
      {
         super();
      }
      
      public static function sortAlterationsByIds(w1:AlterationWrapper, w2:AlterationWrapper) : Number
      {
         if(w1 === null || w2 === null)
         {
            return sortWithNullAlterations(w1,w2);
         }
         if(w1.id > w2.id)
         {
            return -1;
         }
         if(w1.id < w2.id)
         {
            return 1;
         }
         return 0;
      }
      
      public static function sortAlterationsByCreationTimes(w1:AlterationWrapper, w2:AlterationWrapper) : Number
      {
         if(w1 === null || w2 === null)
         {
            return sortWithNullAlterations(w1,w2);
         }
         if(w1.creationTime > w2.creationTime)
         {
            return -1;
         }
         if(w1.creationTime < w2.creationTime)
         {
            return 1;
         }
         return 0;
      }
      
      public static function sortAlterationsByNames(w1:AlterationWrapper, w2:AlterationWrapper) : Number
      {
         if(w1 === null || w2 === null)
         {
            return sortWithNullAlterations(w1,w2);
         }
         if(w1.nameWithoutAccents === w2.nameWithoutAccents)
         {
            return 0;
         }
         if(w1.nameWithoutAccents > w2.nameWithoutAccents)
         {
            return 1;
         }
         return -1;
      }
      
      public static function sortAlterationsByCategories(w1:AlterationWrapper, w2:AlterationWrapper) : Number
      {
         if(w1 === null || w2 === null)
         {
            return sortWithNullAlterations(w1,w2);
         }
         if(w1.categoryWithoutAccents === w2.categoryWithoutAccents)
         {
            return 0;
         }
         if(w1.categoryWithoutAccents > w2.categoryWithoutAccents)
         {
            return 1;
         }
         return -1;
      }
      
      public static function sortAlterationsByDescriptions(w1:AlterationWrapper, w2:AlterationWrapper) : Number
      {
         if(w1 === null || w2 === null)
         {
            return sortWithNullAlterations(w1,w2);
         }
         if(w1.descriptionWithoutAccents === w2.descriptionWithoutAccents)
         {
            return 0;
         }
         if(w1.descriptionWithoutAccents > w2.descriptionWithoutAccents)
         {
            return 1;
         }
         return -1;
      }
      
      public static function sortAlterationsByExpirations(w1:AlterationWrapper, w2:AlterationWrapper) : Number
      {
         if(w1 === null || w2 === null)
         {
            return sortWithNullAlterations(w1,w2);
         }
         if(!w1.isExpiration && !w2.isExpiration)
         {
            return 0;
         }
         if(w1.expirationType === w2.expirationType)
         {
            if(w1.expiration === w2.expiration)
            {
               return 0;
            }
            if(w1.expiration > w2.expiration)
            {
               return 1;
            }
            return -1;
         }
         if(w1.expirationType < w2.expirationType)
         {
            return -1;
         }
         return 1;
      }
      
      public static function sortAlterationsByFavorites(w1:AlterationWrapper, w2:AlterationWrapper) : Number
      {
         if(w1 === null || w2 === null)
         {
            return sortWithNullAlterations(w1,w2);
         }
         if(w1.isFavorite === w2.isFavorite)
         {
            return 0;
         }
         if(w2.isFavorite)
         {
            return 1;
         }
         return -1;
      }
      
      public static function sortPreviewedAlterations(w1:AlterationWrapper, w2:AlterationWrapper) : Number
      {
         var result:Number = sortAlterationsByFavorites(w1,w2);
         if(result !== 0)
         {
            return result * -1;
         }
         result = sortAlterationsByCreationTimes(w1,w2);
         if(result !== 0)
         {
            return result;
         }
         result = sortAlterationsByIds(w1,w2);
         if(result !== 0)
         {
            return result;
         }
         result = sortAlterationsByNames(w1,w2);
         if(result !== 0)
         {
            return result;
         }
         result = sortAlterationsByCategories(w1,w2);
         if(result !== 0)
         {
            return result;
         }
         result = sortAlterationsByDescriptions(w1,w2);
         if(result !== 0)
         {
            return result;
         }
         return sortAlterationsByExpirations(w1,w2);
      }
      
      public static function getAlterationExpirationText(alteration:AlterationWrapper, isReallyShortDuration:Boolean = false) : String
      {
         if(!alteration.isExpiration)
         {
            return null;
         }
         if(alteration.expirationType === AlterationExpirationTypeEnum.ALTERATION_DATE)
         {
            return TimeManager.getInstance().getShortDuration(alteration.expiration,isReallyShortDuration);
         }
         if(alteration.expiration === 0)
         {
            return null;
         }
         return alteration.expiration.toString();
      }
      
      public static function getAlterationExpirationIconUri(alteration:AlterationWrapper) : Uri
      {
         if(alteration.sourceType === AlterationSourceTypeEnum.ITEM && alteration.parentCategoryId === DataEnum.ITEM_TYPE_ROLEPLAY_BUFF)
         {
            return new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/").concat("icon_costume_grey.png"));
         }
         if(!alteration.isExpiration || alteration.expirationType === AlterationExpirationTypeEnum.ALTERATION_DATE)
         {
            return null;
         }
         switch(alteration.expirationType)
         {
            case AlterationExpirationTypeEnum.ALTERATION_FIGHT_COUNT:
               return new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/").concat("icon_crossed_swords_grey.png"));
            case AlterationExpirationTypeEnum.ALTERATION_FIGHTS_WON_COUNT:
               return new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/").concat("icon_crown_grey.png"));
            case AlterationExpirationTypeEnum.ALTERATION_FIGHTS_LOST_COUNT:
               return new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/").concat("icon_skull_grey.png"));
            default:
               return null;
         }
      }
      
      private static function sortWithNullAlterations(w1:AlterationWrapper, w2:AlterationWrapper) : Number
      {
         if(w1 !== null && w2 !== null)
         {
            throw new Error("At least one alteration must be null");
         }
         if(w2 !== null)
         {
            return 1;
         }
         if(w1 !== null)
         {
            return -1;
         }
         return 0;
      }
   }
}
