package Ankama_Web.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class CodeResultPopup
   {
      
      public static const OBJECTS:int = 0;
      
      public static const ABO:int = 1;
      
      public static const OGRINES:int = 3;
      
      public static const PACK:int = 4;
      
      private static const TYPE_ABO:String = "VIRTUALSUBSCRIPTION";
      
      private static const TYPE_OGRINE:String = "OGRINE";
      
      private static const TYPE_OBJECT:String = "VIRTUALGIFT";
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      public var btn_close_ctr_popupWindow:ButtonContainer;
      
      public var btn_ok:ButtonContainer;
      
      public var lbl_credited:Label;
      
      public var tx_picture:Texture;
      
      public var lbl_name:Label;
      
      public var lbl_ammount:Label;
      
      public var ctr_ogrine:GraphicContainer;
      
      public var ctr_itemOrAbo:GraphicContainer;
      
      public function CodeResultPopup()
      {
         super();
      }
      
      public function main(params:Object = null) : void
      {
         var iconUri:String = null;
         var giftName:String = null;
         var i:int = 0;
         var references:Array = null;
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_close_ctr_popupWindow,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_ok,ComponentHookList.ON_RELEASE);
         var containsAbo:Boolean = false;
         var containsOgrines:Boolean = false;
         var nbOrder:int = 0;
         var data:Object = params.object;
         if(data.order_list.length > 0)
         {
            i = 0;
            references = data.order_list[0].articles[0].references;
            iconUri = this.getImageFromMedias(data.order_list[0].articles[0].media);
            for(giftName = data.order_list[0].articles[0].name; i < references.length; )
            {
               if(references[i].type == TYPE_OGRINE)
               {
                  containsOgrines = true;
               }
               else if(references[i].type == TYPE_ABO)
               {
                  containsAbo = true;
               }
               nbOrder++;
               i++;
            }
         }
         else if(data.kard_list.length > 0)
         {
            iconUri = data.kard_list[0].image;
            giftName = data.kard_list[0].name;
         }
         var type:int = CodeResultPopup.OBJECTS;
         if(containsAbo)
         {
            if(nbOrder < 2 && data.kard_list.length == 0)
            {
               type = CodeResultPopup.ABO;
            }
            else
            {
               type = CodeResultPopup.PACK;
            }
         }
         else if(containsOgrines)
         {
            if(nbOrder < 2 && data.kard_list.length == 0)
            {
               type = CodeResultPopup.OGRINES;
            }
            else
            {
               type = CodeResultPopup.PACK;
            }
         }
         switch(type)
         {
            case CodeResultPopup.OGRINES:
            case CodeResultPopup.ABO:
               this.lbl_credited.text = this.uiApi.getText("ui.codesAndGift.codes.creditedAbo");
               break;
            case CodeResultPopup.PACK:
               this.lbl_credited.text = this.uiApi.getText("ui.codesAndGift.codes.creditedPack");
               break;
            default:
               this.lbl_credited.text = this.uiApi.getText("ui.codesAndGift.codes.creditedReward");
         }
         this.ctr_ogrine.visible = type == CodeResultPopup.OGRINES && nbOrder < 2;
         this.ctr_itemOrAbo.visible = !this.ctr_ogrine.visible;
         if(this.ctr_itemOrAbo.visible)
         {
            this.tx_picture.uri = this.uiApi.createUri(iconUri);
            this.lbl_name.text = giftName;
         }
         else
         {
            this.lbl_ammount.text = this.utilApi.kamasToString(parseInt(data.order_list[0].articles[0].references[0].quantity),"");
            this.lbl_ammount.fullWidthAndHeight();
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         if(s == "validUi" || s == "closeUi")
         {
            this.closeMe();
            return true;
         }
         return false;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.btn_close_ctr_popupWindow || target == this.btn_ok)
         {
            this.closeMe();
         }
      }
      
      private function closeMe() : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      private function getImageFromMedias(medias:Array) : String
      {
         var media:Object = null;
         for each(media in medias)
         {
            if(media.param == "GALLERY" && media.type == "IMAGE")
            {
               return media.url;
            }
         }
         return this.sysApi.getConfigEntry("config.gfx.path.item.bitmap").concat("89042").concat(".png");
      }
   }
}
