package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   
   public class UiGroup implements IModuleUtil
   {
       
      
      private var _name:String;
      
      private var _exclusive:Boolean;
      
      private var _permanent:Boolean;
      
      private var _uisName:Array;
      
      public function UiGroup(name:String, exclusive:Boolean, permanent:Boolean, uisName:Array = null)
      {
         super();
         this._name = name;
         this._permanent = permanent;
         this._exclusive = exclusive;
         if(uisName != null)
         {
            this._uisName = uisName;
         }
         else
         {
            this._uisName = new Array();
         }
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get exclusive() : Boolean
      {
         return this._exclusive;
      }
      
      public function get permanent() : Boolean
      {
         return this._permanent;
      }
      
      public function get uis() : Array
      {
         return this._uisName;
      }
   }
}
