package com.ankamagames.dofus.misc.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.utils.Dictionary;
   
   public class EmbedAssets
   {
      
      private static var _cache:Dictionary = new Dictionary();
      
      public static const DefaultBeriliaSlotIcon:Class = EmbedAssets_DefaultBeriliaSlotIcon;
      
      public static const CHECKPOINT_CLIP_TOP:Class = EmbedAssets_CHECKPOINT_CLIP_TOP;
      
      public static const CHECKPOINT_CLIP_TOP_WALK:Class = EmbedAssets_CHECKPOINT_CLIP_TOP_WALK;
      
      public static const CHECKPOINT_CLIP_LEFT:Class = EmbedAssets_CHECKPOINT_CLIP_LEFT;
      
      public static const CHECKPOINT_CLIP_LEFT_WALK:Class = EmbedAssets_CHECKPOINT_CLIP_LEFT_WALK;
      
      public static const CHECKPOINT_CLIP_BOTTOM:Class = EmbedAssets_CHECKPOINT_CLIP_BOTTOM;
      
      public static const CHECKPOINT_CLIP_BOTTOM_WALK:Class = EmbedAssets_CHECKPOINT_CLIP_BOTTOM_WALK;
      
      public static const CHECKPOINT_CLIP_RIGHT:Class = EmbedAssets_CHECKPOINT_CLIP_RIGHT;
      
      public static const CHECKPOINT_CLIP_RIGHT_WALK:Class = EmbedAssets_CHECKPOINT_CLIP_RIGHT_WALK;
      
      private static const CHECKPOINT_CLIP:Class = EmbedAssets_CHECKPOINT_CLIP;
      
      private static const CHECKPOINT_CLIP_WALK:Class = EmbedAssets_CHECKPOINT_CLIP_WALK;
      
      private static const QUEST_CLIP:Class = EmbedAssets_QUEST_CLIP;
      
      private static const QUEST_REPEATABLE_CLIP:Class = EmbedAssets_QUEST_REPEATABLE_CLIP;
      
      private static const QUEST_OBJECTIVE_CLIP:Class = EmbedAssets_QUEST_OBJECTIVE_CLIP;
      
      private static const QUEST_REPEATABLE_OBJECTIVE_CLIP:Class = EmbedAssets_QUEST_REPEATABLE_OBJECTIVE_CLIP;
      
      private static const TEAM_CIRCLE_CLIP:Class = EmbedAssets_TEAM_CIRCLE_CLIP;
      
      private static const SWORDS_CLIP:Class = EmbedAssets_SWORDS_CLIP;
      
      private static const FLAG_CURSOR:Class = EmbedAssets_FLAG_CURSOR;
      
      private static var matrix:Matrix = new Matrix();
       
      
      public function EmbedAssets()
      {
         super();
      }
      
      public static function getBitmap(className:String, unique:Boolean = false, useCache:Boolean = true) : Bitmap
      {
         var bmp:Bitmap = null;
         var bmpdt:BitmapData = null;
         if(useCache && _cache[className] != null)
         {
            bmp = _cache[className];
            if(!unique)
            {
               return bmp;
            }
            bmpdt = new BitmapData(bmp.width,bmp.height,true,16711935);
            bmpdt.draw(bmp,matrix);
            return new Bitmap(bmpdt);
         }
         var ClassReference:Class = EmbedAssets[className] as Class;
         bmp = new ClassReference() as Bitmap;
         if(useCache)
         {
            saveCache(className,bmp);
         }
         return bmp;
      }
      
      public static function getSprite(className:String) : Sprite
      {
         var ClassReference:Class = EmbedAssets[className] as Class;
         return new ClassReference() as Sprite;
      }
      
      public static function getClass(className:String) : Class
      {
         return EmbedAssets[className] as Class;
      }
      
      private static function saveCache(className:String, data:*) : void
      {
         _cache[className] = data;
      }
   }
}
