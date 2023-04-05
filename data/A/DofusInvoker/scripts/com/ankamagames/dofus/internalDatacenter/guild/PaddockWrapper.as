package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockBuyableInformations;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockInstancesInformations;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class PaddockWrapper implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PaddockWrapper));
       
      
      public var maxOutdoorMount:uint;
      
      public var maxItems:uint;
      
      public var paddockInstances:Array;
      
      public function PaddockWrapper()
      {
         super();
      }
      
      public static function create(paddockInformations:PaddockInstancesInformations) : PaddockWrapper
      {
         var paddockInstanceInfo:PaddockBuyableInformations = null;
         var myGuildId:int = 0;
         var myInstances:Array = null;
         var instancesLength:int = 0;
         var i:int = 0;
         var instanceWrapper:PaddockInstanceWrapper = null;
         var piw:Array = null;
         var paddock:PaddockWrapper = new PaddockWrapper();
         paddock.maxOutdoorMount = paddockInformations.maxOutdoorMount;
         paddock.maxItems = paddockInformations.maxItems;
         paddock.paddockInstances = new Array();
         for each(paddockInstanceInfo in paddockInformations.paddocks)
         {
            paddock.paddockInstances.push(PaddockInstanceWrapper.create(paddockInstanceInfo));
         }
         paddock.paddockInstances.sortOn("guildNameForSorting",Array.CASEINSENSITIVE);
         if(SocialFrame.getInstance().guild)
         {
            myGuildId = SocialFrame.getInstance().guild.guildId;
            myInstances = new Array();
            instancesLength = paddock.paddockInstances.length;
            for(i = instancesLength - 1; i >= 0; i--)
            {
               if(paddock.paddockInstances[i].guildIdentity && paddock.paddockInstances[i].guildIdentity.guildId == myGuildId)
               {
                  myInstances.push(paddock.paddockInstances[i]);
                  piw = paddock.paddockInstances.splice(i,1);
               }
            }
            for each(instanceWrapper in myInstances)
            {
               paddock.paddockInstances.unshift(instanceWrapper);
            }
         }
         return paddock;
      }
   }
}
