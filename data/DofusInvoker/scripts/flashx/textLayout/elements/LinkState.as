package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public final class LinkState
   {
      
      public static const LINK:String = "link";
      
      public static const HOVER:String = "hover";
      
      public static const ACTIVE:String = "active";
      
      tlf_internal static const SUPPRESSED:String = "supressed";
       
      
      public function LinkState()
      {
         super();
      }
   }
}
