package com.ankamagames.dofus.internalDatacenter.jobs
{
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryListEntry;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class CraftsmanWrapper implements IDataCenter
   {
       
      
      public var playerId:Number;
      
      public var playerName:String;
      
      public var alignmentSide:int;
      
      public var breed:int;
      
      public var sex:Boolean;
      
      public var isInWorkshop:Boolean = false;
      
      public var mapId:Number;
      
      public var subAreaId:int;
      
      public var worldPos:String;
      
      public var statusId:int;
      
      public var awayMessage:String;
      
      public var jobId:int;
      
      public var jobLevel:int;
      
      public var minLevelCraft:int;
      
      public var freeCraft:Boolean;
      
      public var canCraftlegendary:Boolean;
      
      public function CraftsmanWrapper()
      {
         super();
      }
      
      public static function create(informations:JobCrafterDirectoryListEntry) : CraftsmanWrapper
      {
         var obj:CraftsmanWrapper = new CraftsmanWrapper();
         obj.playerId = informations.playerInfo.playerId;
         obj.playerName = informations.playerInfo.playerName;
         obj.alignmentSide = informations.playerInfo.alignmentSide;
         obj.breed = informations.playerInfo.breed;
         obj.sex = informations.playerInfo.sex;
         obj.isInWorkshop = informations.playerInfo.isInWorkshop;
         obj.mapId = informations.playerInfo.mapId;
         obj.subAreaId = informations.playerInfo.subAreaId;
         obj.worldPos = "(" + informations.playerInfo.worldX + ", " + informations.playerInfo.worldY + ")";
         obj.statusId = informations.playerInfo.status.statusId;
         obj.canCraftlegendary = informations.playerInfo.canCraftLegendary;
         if(informations.playerInfo.status is PlayerStatusExtended)
         {
            obj.awayMessage = PlayerStatusExtended(informations.playerInfo.status).message;
         }
         obj.jobId = informations.jobInfo.jobId;
         obj.jobLevel = informations.jobInfo.jobLevel;
         obj.minLevelCraft = informations.jobInfo.minLevel;
         obj.freeCraft = informations.jobInfo.free;
         return obj;
      }
   }
}
