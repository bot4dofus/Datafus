package com.ankamagames.dofus.internalDatacenter.alterations
{
   import com.ankamagames.dofus.datacenter.alterations.Alteration;
   import com.ankamagames.dofus.datacenter.alterations.AlterationCategory;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDate;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.ObjectEffectAdapter;
   import com.ankamagames.dofus.network.enums.AlterationExpirationTypeEnum;
   import com.ankamagames.dofus.network.types.game.character.alteration.AlterationInfo;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.system.LoaderContext;
   
   public class AlterationWrapper implements ISlotData
   {
      
      public static const MAX_FAVORITE_COUNT:uint = 3;
       
      
      public var isFavorite:Boolean = false;
      
      private var _id:Number = NaN;
      
      private var _bddId:uint = 0;
      
      private var _creationTime:Number = 0;
      
      private var _alterationSourceType:uint = 0;
      
      private var _data:Alteration = null;
      
      private var _name:String = null;
      
      private var _description:String = null;
      
      private var _parentCategoryId:Number = NaN;
      
      private var _categoryId:Number = NaN;
      
      private var _parentCategory:String = null;
      
      private var _category:String = null;
      
      private var _expiration:Number = 0;
      
      private var _expirationType:uint = 0;
      
      private var _nameWithoutAccents:String = null;
      
      private var _descriptionWithoutAccents:String = null;
      
      private var _categoryWithoutAccents:String = null;
      
      private var _subCategoryWithoutAccents:String = null;
      
      private var _iconId:uint = 0;
      
      private var _iconUri:Uri = null;
      
      private var _fullSizeIconUri:Uri = null;
      
      private var _errorIconUri:Uri = null;
      
      private var _uriLoaderContext:LoaderContext = null;
      
      private var _effects:Vector.<EffectInstance>;
      
      public function AlterationWrapper()
      {
         this._effects = new Vector.<EffectInstance>();
         super();
      }
      
      private static function createInternal(data:*, creationDate:Number, expirationType:uint = 1, expiration:Number = 0, isFavorite:Boolean = false, effects:Vector.<EffectInstance> = null) : AlterationWrapper
      {
         var alterationData:Alteration = null;
         var category:AlterationCategory = null;
         var parentCategory:AlterationCategory = null;
         var itemData:ItemWrapper = null;
         var alteration:AlterationWrapper = new AlterationWrapper();
         if(!(data is ItemWrapper || data is Alteration))
         {
            throw new Error("data provided should be an ItemWrapper or an Alteration");
         }
         var isDataAlteration:* = data is Alteration;
         alteration._bddId = data.id;
         alteration._creationTime = creationDate;
         alteration._alterationSourceType = !!isDataAlteration ? uint(AlterationSourceTypeEnum.ALTERATION) : uint(AlterationSourceTypeEnum.ITEM);
         alteration._data = !!isDataAlteration ? data : null;
         alteration._name = data.name;
         alteration._description = data.description;
         if(isDataAlteration)
         {
            alterationData = data as Alteration;
            category = AlterationCategory.getAlterationCategoryById(alterationData.categoryId);
            parentCategory = category !== null ? AlterationCategory.getAlterationCategoryById(category.parentId) : null;
            if(parentCategory !== null)
            {
               alteration._parentCategoryId = parentCategory.id;
               alteration._parentCategory = parentCategory.name;
            }
            else
            {
               alteration._parentCategoryId = Number.NaN;
               alteration._parentCategory = "";
            }
            alteration._categoryId = alterationData.categoryId;
            alteration._category = alterationData.category;
         }
         else
         {
            itemData = data as ItemWrapper;
            alteration._parentCategoryId = itemData.typeId;
            alteration._parentCategory = itemData.type.name;
            alteration._categoryId = Number.NaN;
            alteration._category = null;
         }
         alteration._iconId = data.iconId;
         alteration.isFavorite = isFavorite;
         alteration._nameWithoutAccents = alteration._name !== null ? StringUtils.noAccent(alteration._name) : null;
         alteration._descriptionWithoutAccents = alteration._description !== null ? StringUtils.noAccent(alteration._description) : null;
         alteration._categoryWithoutAccents = alteration._parentCategory !== null ? StringUtils.noAccent(alteration._parentCategory) : null;
         alteration._subCategoryWithoutAccents = alteration._category !== null ? StringUtils.noAccent(alteration._category) : null;
         var typeId:Number = alteration._alterationSourceType * Math.pow(2,32);
         alteration._id = typeId + alteration._bddId;
         alteration._expirationType = expirationType;
         alteration._expiration = expiration;
         if(effects !== null)
         {
            alteration._effects = effects;
         }
         else if(isDataAlteration && alterationData.possibleEffects !== null)
         {
            alteration._effects = alterationData.possibleEffects;
         }
         return alteration;
      }
      
      public static function create(alteration:Alteration, creationDate:Number, expirationType:uint = 1, expiration:Number = 0, isFavorite:Boolean = false, effects:Vector.<EffectInstance> = null) : AlterationWrapper
      {
         return createInternal(alteration,creationDate,expirationType,expiration,isFavorite,effects);
      }
      
      public static function createFromAlterationInfo(alterationInfo:AlterationInfo, isFavorite:Boolean) : AlterationWrapper
      {
         var effect:ObjectEffect = null;
         var effects:Vector.<EffectInstance> = new Vector.<EffectInstance>(0);
         for each(effect in alterationInfo.effects)
         {
            effects.push(ObjectEffectAdapter.fromNetwork(effect));
         }
         return createInternal(Alteration.getAlterationById(alterationInfo.alterationId),alterationInfo.creationTime,alterationInfo.expirationType,alterationInfo.expirationValue,isFavorite,effects);
      }
      
      public static function createFromItem(item:ItemWrapper) : AlterationWrapper
      {
         var effect:EffectInstance = null;
         var possibleEffect:EffectInstance = null;
         var dateEffect:EffectInstanceDate = null;
         var date:Date = null;
         var expirationType:uint = AlterationExpirationTypeEnum.ALTERATION_INFINITE;
         var expiration:Number = 0;
         var itemData:Item = Item.getItemById(item.id);
         if(itemData !== null)
         {
            for each(effect in item.effects)
            {
               if(effect is EffectInstanceDate)
               {
                  dateEffect = effect as EffectInstanceDate;
                  date = new Date(dateEffect.year - TimeManager.getInstance().dofusTimeYearLag,dateEffect.month - 1,dateEffect.day,dateEffect.hour,dateEffect.minute);
                  expirationType = AlterationExpirationTypeEnum.ALTERATION_DATE;
                  expiration = date.getTime();
                  break;
               }
               if(effect is EffectInstanceDice)
               {
                  for each(possibleEffect in itemData.possibleEffects)
                  {
                     if(effect.effectUid === possibleEffect.effectUid)
                     {
                        if(possibleEffect.baseEffectId === DataEnum.BASE_EFFECT_CATEGORY_ANNOYING_THING || possibleEffect.baseEffectId === DataEnum.BASE_EFFECT_CATEGORY_GOOD_THING)
                        {
                           expirationType = AlterationExpirationTypeEnum.ALTERATION_FIGHT_COUNT;
                           expiration = (effect as EffectInstanceDice).value;
                           break;
                        }
                     }
                  }
               }
            }
         }
         return createInternal(item,TimeManager.getInstance().getUtcTimestamp(),expirationType,expiration,false,item.effects);
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function get bddId() : uint
      {
         return this._bddId;
      }
      
      public function get creationTime() : Number
      {
         return this._creationTime;
      }
      
      public function get sourceType() : uint
      {
         return this._alterationSourceType;
      }
      
      public function get data() : Alteration
      {
         return this._data;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function get parentCategory() : String
      {
         return this._parentCategory;
      }
      
      public function get category() : String
      {
         return this._category;
      }
      
      public function get parentCategoryId() : Number
      {
         return this._parentCategoryId;
      }
      
      public function get categoryId() : Number
      {
         return this._categoryId;
      }
      
      public function get expiration() : Number
      {
         return this._expiration;
      }
      
      public function get expirationType() : uint
      {
         return this._expirationType;
      }
      
      public function get isExpiration() : Boolean
      {
         return this._alterationSourceType === AlterationSourceTypeEnum.ITEM && this._parentCategoryId == DataEnum.ITEM_TYPE_ROLEPLAY_BUFF || this._expirationType !== AlterationExpirationTypeEnum.ALTERATION_UNKNOWN && this._expirationType !== AlterationExpirationTypeEnum.ALTERATION_INFINITE;
      }
      
      public function get hasExpired() : Boolean
      {
         if(!this.isExpiration)
         {
            return false;
         }
         if(this._alterationSourceType === AlterationSourceTypeEnum.ITEM)
         {
            return false;
         }
         if(this._expirationType === AlterationExpirationTypeEnum.ALTERATION_DATE)
         {
            return this._expiration - TimeManager.getInstance().getUtcTimestamp() < 1000;
         }
         return this._expiration <= 0;
      }
      
      public function get nameWithoutAccents() : String
      {
         return this._nameWithoutAccents;
      }
      
      public function get descriptionWithoutAccents() : String
      {
         return this._descriptionWithoutAccents;
      }
      
      public function get categoryWithoutAccents() : String
      {
         return this._categoryWithoutAccents;
      }
      
      public function get subCategoryWithoutAccents() : String
      {
         return this._subCategoryWithoutAccents;
      }
      
      public function get iconId() : uint
      {
         return this._iconId;
      }
      
      public function get effects() : Vector.<EffectInstance>
      {
         return this._effects;
      }
      
      public function get iconUri() : Uri
      {
         if(this._iconUri === null)
         {
            this._iconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat(this._iconId).concat(".png"));
         }
         return this._iconUri;
      }
      
      public function get fullSizeIconUri() : Uri
      {
         if(this._fullSizeIconUri === null)
         {
            this._fullSizeIconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.vector").concat(this._iconId).concat(".swf"));
            if(this._uriLoaderContext == null)
            {
               this._uriLoaderContext = new LoaderContext();
               AirScanner.allowByteCodeExecution(this._uriLoaderContext,true);
            }
            this._fullSizeIconUri.loaderContext = this._uriLoaderContext;
         }
         return this._fullSizeIconUri;
      }
      
      public function get errorIconUri() : Uri
      {
         if(this._errorIconUri === null)
         {
            this._errorIconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat("error.png"));
         }
         return this._errorIconUri;
      }
      
      public function get info1() : String
      {
         return null;
      }
      
      public function get active() : Boolean
      {
         return true;
      }
      
      public function get timer() : int
      {
         return 0;
      }
      
      public function get startTime() : int
      {
         return 0;
      }
      
      public function get endTime() : int
      {
         return 0;
      }
      
      public function set endTime(t:int) : void
      {
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function clone() : AlterationWrapper
      {
         var clone:AlterationWrapper = new AlterationWrapper();
         clone._id = this._id;
         clone._bddId = this._bddId;
         clone._creationTime = this._creationTime;
         clone._alterationSourceType = this._alterationSourceType;
         clone._data = this._data;
         clone._name = this._name;
         clone._description = this._description;
         clone._parentCategoryId = this._parentCategoryId;
         clone._categoryId = this._categoryId;
         clone._parentCategory = this._parentCategory;
         clone._category = this._category;
         clone._expiration = this._expiration;
         clone._expirationType = this._expirationType;
         clone.isFavorite = this.isFavorite;
         clone._nameWithoutAccents = this._nameWithoutAccents;
         clone._descriptionWithoutAccents = this._descriptionWithoutAccents;
         clone._categoryWithoutAccents = this._categoryWithoutAccents;
         clone._subCategoryWithoutAccents = this._subCategoryWithoutAccents;
         clone._iconId = this._iconId;
         clone._iconUri = this._iconUri;
         clone._fullSizeIconUri = this._fullSizeIconUri;
         clone._errorIconUri = this._errorIconUri;
         clone._uriLoaderContext = this._uriLoaderContext;
         clone._effects = this._effects;
         return clone;
      }
   }
}
