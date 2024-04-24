package com.ankamagames.dofus.datacenter.seasons
{
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Season
   {
       
      
      public var uid:int;
      
      public var beginning:Number;
      
      public var closure:Number;
      
      public var resetDate:Number;
      
      public var flagObjectId:uint;
      
      public var nameId:uint;
      
      private var _name:String;
      
      public function Season()
      {
         super();
      }
      
      protected static function currentSeason(allSeasons:Array) : Season
      {
         var season:Season = null;
         var timeManager:TimeManager = TimeManager.getInstance();
         if(allSeasons === null || timeManager === null)
         {
            return null;
         }
         var currentDate:Number = timeManager.getTimestamp();
         for each(season in allSeasons)
         {
            if(season.resetDate <= season.closure)
            {
               if(currentDate >= season.beginning && currentDate <= season.closure)
               {
                  return season;
               }
            }
            else if(currentDate >= season.beginning && currentDate <= season.resetDate)
            {
               return season;
            }
         }
         return null;
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function isFinished() : Boolean
      {
         var timeManager:TimeManager = TimeManager.getInstance();
         var currentDate:Number = timeManager.getTimestamp();
         return currentDate > this.closure;
      }
   }
}
