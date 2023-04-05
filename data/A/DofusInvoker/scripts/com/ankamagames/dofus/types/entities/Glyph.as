package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.dofus.types.enums.PortalAnimationEnum;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IObstacle;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import tools.enumeration.GameActionMarkTypeEnum;
   
   public class Glyph extends Projectile implements IObstacle
   {
      
      private static var GLOW_FILTER:GlowFilter;
      
      private static var CSS_URI:Uri;
       
      
      public var glyphType:uint;
      
      public var lbl_number:Label;
      
      public function Glyph(nId:int, look:TiphonEntityLook, postInit:Boolean = false, startPlayingOnlyWhenDisplayed:Boolean = true, glyphType:uint = 0)
      {
         super(nId,look,postInit,startPlayingOnlyWhenDisplayed);
         this.glyphType = glyphType;
      }
      
      public function canSeeThrough() : Boolean
      {
         return true;
      }
      
      public function canWalkThrough() : Boolean
      {
         var v:Boolean = true;
         if(this.glyphType == GameActionMarkTypeEnum.TRAP || this.glyphType == GameActionMarkTypeEnum.PORTAL && getAnimation() != PortalAnimationEnum.STATE_DISABLED)
         {
            v = false;
         }
         return v;
      }
      
      public function canWalkTo() : Boolean
      {
         return true;
      }
      
      public function addNumber(num:int, color:Color = null) : void
      {
         var number:Sprite = null;
         if(!this.lbl_number || this.lbl_number == null)
         {
            if(!CSS_URI)
            {
               CSS_URI = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal.css");
            }
            if(!GLOW_FILTER || GLOW_FILTER.color != color.color && color != null)
            {
               if(color == null)
               {
                  GLOW_FILTER = new GlowFilter(42986,0.9,3,3,6,3);
               }
               else
               {
                  GLOW_FILTER = new GlowFilter(color.color,0.9,3,3,6,3);
               }
            }
            number = new Sprite();
            this.lbl_number = new Label();
            this.lbl_number.width = 30;
            this.lbl_number.height = 20;
            this.lbl_number.x = -20;
            this.lbl_number.y = 14;
            this.lbl_number.cssClass = "light";
            this.lbl_number.css = CSS_URI;
            this.lbl_number.text = num.toString();
            this.lbl_number.visible = false;
            number.addChild(this.lbl_number);
            number.filters = [GLOW_FILTER];
            this.addBackground("labelNumber",number);
         }
         else
         {
            this.lbl_number.text = num.toString();
         }
      }
      
      override public function getIsTransparencyAllowed() : Boolean
      {
         return true;
      }
   }
}
