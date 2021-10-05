package Ankama_Document.tools
{
   public final class HtmlParser
   {
       
      
      public function HtmlParser()
      {
         super();
      }
      
      public static function parseText(text:String) : String
      {
         var recherche:RegExp = null;
         text = text.split("<strong>").join("<b>");
         text = text.split("</strong>").join("</b>");
         text = text.split("<br />").join("");
         text = text.split("<br/>").join("");
         text = text.split("<BR />").join("");
         text = text.split("<BR/>").join("");
         text = text.split("&OElig;").join("Œ");
         recherche = /<span style="color: #([0-9a-fA-F]{1,6})">(.*)</span>/g;
         text = text.replace(recherche,"<font color=\'#$1\'>$2</font>");
         recherche = /<span style="font-size: xx-small">(.*)</span>/g;
         text = text.replace(recherche,"<font size=\'14\'>$1</font>");
         recherche = /<span style="font-size: xx-large">(.*)</span>/g;
         return text.replace(recherche,"<font size=\'22\'>$1</font>");
      }
   }
}
