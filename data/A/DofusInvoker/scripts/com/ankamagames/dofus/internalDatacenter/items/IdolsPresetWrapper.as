package com.ankamagames.dofus.internalDatacenter.items
{
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.types.Uri;
   
   public class IdolsPresetWrapper extends PresetWrapper implements IDataCenter
   {
       
      
      public var idolsIds:Vector.<uint>;
      
      public function IdolsPresetWrapper()
      {
         super();
      }
      
      public static function create(pPresetId:uint, pIconId:uint, pIdolsIds:Vector.<uint>) : IdolsPresetWrapper
      {
         var idolsPreset:IdolsPresetWrapper = new IdolsPresetWrapper();
         idolsPreset.id = pPresetId;
         idolsPreset.gfxId = pIconId;
         idolsPreset.idolsIds = pIdolsIds;
         return idolsPreset;
      }
      
      override public function getIconUri(pngMode:Boolean = true) : Uri
      {
         return new Uri(XmlConfig.getInstance().getEntry("config.gfx.path") + ("presets/idols.swf|icon_" + gfxId));
      }
   }
}
