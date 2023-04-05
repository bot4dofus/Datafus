package com.ankamagames.dofus.datacenter.jobs
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Job implements IDataCenter
   {
      
      public static const MODULE:String = "Jobs";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getJobById,getJobs);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var iconId:int;
      
      public var hasLegendaryCraft:Boolean;
      
      private var _name:String;
      
      public function Job()
      {
         super();
      }
      
      public static function getJobById(id:int) : Job
      {
         return GameData.getObject(MODULE,id) as Job;
      }
      
      public static function getJobs() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
