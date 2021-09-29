package Ankama_Cartography.ui.type
{
   import com.ankamagames.dofus.datacenter.world.SubArea;
   
   public class AreaInfo
   {
       
      
      public var label:String;
      
      public var type:String;
      
      public var uri:String;
      
      public var parent:AreaGroup;
      
      public var data:SubArea;
      
      public var percent:int;
      
      public var hasAnomaly:Boolean;
      
      public var css:String;
      
      public var cssClass:String;
      
      public var vulnerabilityDate:uint;
      
      public var sortLabel:String;
      
      public function AreaInfo(label:String, infoType:String, uri:String, parent:AreaGroup, data:SubArea, css:String = "", cssClass:String = "", percent:int = 0, hasAnomaly:Boolean = false)
      {
         super();
         this.label = label;
         this.type = infoType;
         this.uri = uri;
         this.parent = parent;
         this.data = data;
         this.percent = percent;
         this.hasAnomaly = hasAnomaly;
         this.css = css;
         this.cssClass = cssClass;
      }
   }
}
