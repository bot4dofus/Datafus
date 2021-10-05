package Ankama_Tooltips
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.dofus.uiApi.AlignmentApi;
   import com.ankamagames.dofus.uiApi.AveragePricesApi;
   import com.ankamagames.dofus.uiApi.BreachApi;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class Api
   {
      
      public static var ui:UiApi;
      
      public static var system:SystemApi;
      
      public static var tooltip:TooltipApi;
      
      public static var data:DataApi;
      
      public static var alignment:AlignmentApi;
      
      public static var fight:FightApi;
      
      public static var player:PlayedCharacterApi;
      
      public static var chat:ChatApi;
      
      public static var averagePrices:AveragePricesApi;
      
      public static var util:UtilApi;
      
      public static var social:SocialApi;
      
      public static var time:TimeApi;
      
      public static var breach:BreachApi;
       
      
      public function Api()
      {
         super();
      }
   }
}
