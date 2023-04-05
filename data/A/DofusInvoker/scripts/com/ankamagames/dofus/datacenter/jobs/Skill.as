package com.ankamagames.dofus.datacenter.jobs
{
   import com.ankamagames.dofus.datacenter.interactives.Interactive;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Skill implements IDataCenter
   {
      
      public static const MODULE:String = "Skills";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSkillById,getSkills);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var parentJobId:int;
      
      public var isForgemagus:Boolean;
      
      public var modifiableItemTypeIds:Vector.<int>;
      
      public var gatheredRessourceItem:int;
      
      public var craftableItemIds:Vector.<int>;
      
      public var interactiveId:int;
      
      public var range:int;
      
      public var useRangeInClient:Boolean;
      
      public var useAnimation:String;
      
      public var cursor:int;
      
      public var elementActionId:int;
      
      public var availableInHouse:Boolean;
      
      public var levelMin:uint;
      
      public var clientDisplay:Boolean;
      
      private var _name:String;
      
      private var _parentJob:Job;
      
      private var _interactive:Interactive;
      
      private var _gatheredRessource:ItemWrapper;
      
      public function Skill()
      {
         super();
      }
      
      public static function getSkillById(id:int) : Skill
      {
         return GameData.getObject(MODULE,id) as Skill;
      }
      
      public static function getSkills() : Array
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
      
      public function get parentJob() : Job
      {
         if(!this._parentJob)
         {
            this._parentJob = Job.getJobById(this.parentJobId);
         }
         return this._parentJob;
      }
      
      public function get interactive() : Interactive
      {
         if(!this._interactive)
         {
            this._interactive = Interactive.getInteractiveById(this.interactiveId);
         }
         return this._interactive;
      }
      
      public function get gatheredRessource() : ItemWrapper
      {
         if(!this._gatheredRessource && this.gatheredRessourceItem != -1)
         {
            this._gatheredRessource = ItemWrapper.create(0,0,this.gatheredRessourceItem,1,null,false);
         }
         return this._gatheredRessource;
      }
   }
}
