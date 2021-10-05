package
{
   import mx.resources.ResourceBundle;
   
   [ExcludeClass]
   public class en_US$SharedResources_properties extends ResourceBundle
   {
       
      
      public function en_US$SharedResources_properties()
      {
         super("en_US","SharedResources");
      }
      
      override protected function getContent() : Object
      {
         return {
            "dateFormat":"MM/DD/YYYY",
            "dayNames":"Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday",
            "thousandsSeparatorFrom":",",
            "monthNames":"January,February,March,April,May,June,July,August,September,October,November,December",
            "decimalSeparatorFrom":".",
            "currencySymbol":"$",
            "decimalSeparatorTo":".",
            "thousandsSeparatorTo":",",
            "monthSymbol":"",
            "alignSymbol":"left"
         };
      }
   }
}
