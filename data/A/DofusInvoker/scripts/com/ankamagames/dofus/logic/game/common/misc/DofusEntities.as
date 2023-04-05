package com.ankamagames.dofus.logic.game.common.misc
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class DofusEntities
   {
      
      private static const LOCALIZER_DEBUG:Boolean = true;
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(DofusEntities));
      
      private static var _atouin:Atouin = Atouin.getInstance();
      
      private static var _localizers:Vector.<IEntityLocalizer> = new Vector.<IEntityLocalizer>();
       
      
      public function DofusEntities()
      {
         super();
      }
      
      public static function getEntity(entityId:Number) : IEntity
      {
         var localizer:IEntityLocalizer = null;
         var foundEntity:IEntity = null;
         for each(localizer in _localizers)
         {
            foundEntity = localizer.getEntity(entityId);
            if(foundEntity)
            {
               return foundEntity;
            }
         }
         return _atouin.getEntity(entityId);
      }
      
      public static function registerLocalizer(localizer:IEntityLocalizer) : void
      {
         var currentLocalizer:IEntityLocalizer = null;
         var clazz:String = getQualifiedClassName(localizer);
         var currentClazz:String = null;
         for each(currentLocalizer in _localizers)
         {
            currentClazz = getQualifiedClassName(currentLocalizer);
            if(currentClazz == clazz)
            {
               throw new Error("There\'s more than one " + currentClazz + " localizer added to DofusEntites. Nope, that won\'t work.");
            }
         }
         _localizers.push(localizer);
      }
      
      public static function reset() : void
      {
         var localizer:IEntityLocalizer = null;
         for(var i:int = 0; i < _localizers.length; i++)
         {
            localizer = _localizers[i];
            localizer.unregistered();
         }
         _localizers = new Vector.<IEntityLocalizer>();
      }
   }
}
