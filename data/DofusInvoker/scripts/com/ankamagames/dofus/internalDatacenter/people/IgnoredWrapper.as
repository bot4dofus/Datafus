package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.jerakine.enum.SocialCharacterCategoryEnum;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class IgnoredWrapper extends SocialCharacterWrapper implements IDataCenter
   {
       
      
      public function IgnoredWrapper(name:String, tag:String, accountId:uint)
      {
         super(name,tag,accountId);
         this.e_category = SocialCharacterCategoryEnum.CATEGORY_IGNORED;
      }
   }
}
