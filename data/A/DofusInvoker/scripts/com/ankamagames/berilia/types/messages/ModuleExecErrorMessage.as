package com.ankamagames.berilia.types.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class ModuleExecErrorMessage implements Message
   {
       
      
      private var _moduleName:String;
      
      private var _stackTrace:String;
      
      public function ModuleExecErrorMessage(moduleName:String, stackTrace:String)
      {
         super();
         this._moduleName = moduleName;
         this._stackTrace = stackTrace;
      }
      
      public function get moduleName() : String
      {
         return this._moduleName;
      }
      
      public function get stackTrace() : String
      {
         return this._stackTrace;
      }
   }
}
