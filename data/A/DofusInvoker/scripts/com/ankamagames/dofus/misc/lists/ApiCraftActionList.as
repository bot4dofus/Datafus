package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeSetCraftRecipeAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.JobBookSubscribeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterContactLookRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryDefineSettingsAction;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryListRequestAction;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   
   public class ApiCraftActionList
   {
      
      public static const JobBookSubscribeRequest:DofusApiAction = new DofusApiAction("JobBookSubscribeRequestAction",JobBookSubscribeRequestAction);
      
      public static const JobCrafterDirectoryDefineSettings:DofusApiAction = new DofusApiAction("JobCrafterDirectoryDefineSettingsAction",JobCrafterDirectoryDefineSettingsAction);
      
      public static const JobCrafterDirectoryListRequest:DofusApiAction = new DofusApiAction("JobCrafterDirectoryListRequestAction",JobCrafterDirectoryListRequestAction);
      
      public static const JobCrafterContactLookRequest:DofusApiAction = new DofusApiAction("JobCrafterContactLookRequestAction",JobCrafterContactLookRequestAction);
      
      public static const ExchangeSetCraftRecipe:DofusApiAction = new DofusApiAction("ExchangeSetCraftRecipeAction",ExchangeSetCraftRecipeAction);
       
      
      public function ApiCraftActionList()
      {
         super();
      }
   }
}
