package com.ankamagames.dofus.datacenter.communication
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.utils.getQualifiedClassName;
   
   public class Emoticon implements IDataCenter
   {
      
      public static const MODULE:String = "Emoticons";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Emoticon));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getEmoticonById,getEmoticons);
       
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var shortcutId:uint;
      
      public var order:uint;
      
      public var defaultAnim:String;
      
      public var persistancy:Boolean;
      
      public var eight_directions:Boolean;
      
      public var aura:Boolean;
      
      public var anims:Vector.<String>;
      
      public var cooldown:uint = 1000;
      
      public var duration:uint = 0;
      
      public var weight:uint;
      
      public var spellLevelId:uint = 0;
      
      private var _name:String;
      
      private var _shortcut:String;
      
      public function Emoticon()
      {
         super();
      }
      
      public static function getEmoticonById(id:int) : Emoticon
      {
         return GameData.getObject(MODULE,id) as Emoticon;
      }
      
      public static function getEmoticons() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get shortcut() : String
      {
         if(!this._shortcut)
         {
            this._shortcut = I18n.getText(this.shortcutId);
         }
         if(!this._shortcut || this._shortcut == "")
         {
            return this.defaultAnim;
         }
         return this._shortcut;
      }
      
      public function getAnimName(look:TiphonEntityLook) : String
      {
         var lookBoneId:uint = 0;
         var i:int = 0;
         var anim:String = null;
         var animCase:Array = null;
         var caseBoneId:uint = 0;
         var caseSkins:Array = null;
         var skin:String = null;
         var skinId:uint = 0;
         var lookSkin:uint = 0;
         if(this.spellLevelId != 0 && !this.defaultAnim && this.anims.length == 0)
         {
            return null;
         }
         if(look)
         {
            lookBoneId = look.getBone();
            for(i = this.anims.length - 1; i >= 0; i--)
            {
               anim = this.anims[i];
               animCase = anim.split(";");
               caseBoneId = parseInt(animCase[0]);
               if(caseBoneId == lookBoneId)
               {
                  caseSkins = animCase[1].split(",");
                  for each(skin in caseSkins)
                  {
                     skinId = parseInt(skin);
                     for each(lookSkin in look.skins)
                     {
                        if(skinId == lookSkin)
                        {
                           return "AnimEmote" + animCase[2];
                        }
                     }
                  }
               }
            }
         }
         return "AnimEmote" + this.defaultAnim.charAt(0).toUpperCase() + this.defaultAnim.substr(1).toLowerCase() + "_0";
      }
   }
}
