package com.ankamagames.berilia.types.template
{
   public class TemplateVar
   {
       
      
      public var name:String;
      
      public var value;
      
      public function TemplateVar(varName:String, value:* = null)
      {
         super();
         this.name = varName;
         this.value = value;
      }
      
      public function clone() : TemplateVar
      {
         var tmp:TemplateVar = new TemplateVar(this.name);
         tmp.value = this.value;
         return tmp;
      }
   }
}
