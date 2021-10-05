package Ankama_Common.options
{
   public class OptionItem
   {
       
      
      public var id:String;
      
      public var name:String;
      
      public var description:String;
      
      public var ui:String;
      
      public var childItems:Array;
      
      public function OptionItem(id:String, name:String, description:String, ui:String = null, childItems:Array = null)
      {
         super();
         this.id = id;
         this.name = name;
         this.description = description;
         this.ui = ui;
         this.childItems = childItems;
      }
      
      public function get label() : String
      {
         return this.name;
      }
   }
}
