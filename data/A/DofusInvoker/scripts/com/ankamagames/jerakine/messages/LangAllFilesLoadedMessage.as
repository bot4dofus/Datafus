package com.ankamagames.jerakine.messages
{
   public class LangAllFilesLoadedMessage implements Message
   {
       
      
      private var _sFile:String;
      
      private var _bSuccess:Boolean;
      
      public function LangAllFilesLoadedMessage(sFile:String, bSucces:Boolean)
      {
         super();
         this._sFile = sFile;
         this._bSuccess = bSucces;
      }
      
      public function get file() : String
      {
         return this._sFile;
      }
      
      public function get success() : Boolean
      {
         return this._bSuccess;
      }
   }
}
