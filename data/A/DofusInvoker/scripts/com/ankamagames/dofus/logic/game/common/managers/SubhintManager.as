package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.dofus.datacenter.misc.Subhint;
   import com.ankamagames.dofus.internalDatacenter.tutorial.SubhintWrapper;
   import com.ankamagames.dofus.logic.common.managers.UiHintManager;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class SubhintManager
   {
      
      private static var _self:SubhintManager;
      
      public static var subhintDictionary:Dictionary = new Dictionary();
      
      public static var maxSubhintDate:Number = 0;
       
      
      private var _log:Logger;
      
      public function SubhintManager()
      {
         this._log = Log.getLogger(getQualifiedClassName(SubhintManager));
         super();
         if(_self)
         {
            throw new SingletonError();
         }
      }
      
      public static function getInstance() : SubhintManager
      {
         if(!_self)
         {
            _self = new SubhintManager();
         }
         return _self;
      }
      
      public function init() : void
      {
         this.createSubhintDictionary(Subhint.getSubhints());
      }
      
      private function createSubhintDictionary(result:Object) : void
      {
         var subhintWrapper:SubhintWrapper = null;
         var subhint:Subhint = null;
         subhintDictionary = new Dictionary();
         for each(subhint in result)
         {
            if(subhint.hint_creation_date > maxSubhintDate)
            {
               maxSubhintDate = subhint.hint_creation_date;
            }
            subhintWrapper = SubhintWrapper.create(subhint);
            if(!subhintDictionary[subhint.hint_parent_uid])
            {
               subhintDictionary[subhint.hint_parent_uid] = [];
            }
            subhintDictionary[subhint.hint_parent_uid][subhint.hint_order - 1] = subhintWrapper;
         }
         UiHintManager.reloadHintState();
      }
      
      public function closeSubhint() : void
      {
         UiTutoApi.getInstance().closeSubHints();
      }
   }
}
