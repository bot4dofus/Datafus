package com.ankamagames.dofus.misc.utils
{
   import com.ankama.haapi.client.model.CmsPollInGame;
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   
   public class Survey
   {
       
      
      private var _data:CmsPollInGame;
      
      private var _criterions:GroupItemCriterion;
      
      public function Survey(webData:CmsPollInGame)
      {
         super();
         this._data = webData;
         this._criterions = new GroupItemCriterion(this._data.criterion);
      }
      
      public function get id() : Number
      {
         return this._data.item_id;
      }
      
      public function get title() : String
      {
         return this._data.title;
      }
      
      public function get description() : String
      {
         return this._data.description;
      }
      
      public function get url() : String
      {
         return this._data.url;
      }
      
      public function get readyForPlayer() : Boolean
      {
         if(this._criterions.isRespected)
         {
            return true;
         }
         return false;
      }
   }
}
