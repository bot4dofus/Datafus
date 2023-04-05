package com.ankamagames.berilia.types.template
{
   public class TemplateParam
   {
       
      
      public var name:String;
      
      public var value:String;
      
      public var defaultValue:String;
      
      public function TemplateParam(sName:String, sValue:String = null)
      {
         super();
         this.name = sName;
         this.value = sValue;
      }
   }
}
