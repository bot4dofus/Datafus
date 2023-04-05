package com.ankamagames.dofus.internalDatacenter.mount
{
   import com.ankamagames.dofus.datacenter.mounts.Mount;
   import com.ankamagames.dofus.datacenter.mounts.MountBehavior;
   import com.ankamagames.dofus.datacenter.mounts.MountFamily;
   import com.ankamagames.dofus.misc.ObjectEffectAdapter;
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.utils.Dictionary;
   
   public class MountData implements IDataCenter
   {
      
      private static var _dictionary_cache:Dictionary = new Dictionary();
       
      
      public var id:Number = 0;
      
      public var modelId:uint = 0;
      
      public var name:String = "";
      
      public var description:String = "";
      
      public var entityLook:TiphonEntityLook;
      
      public var colors:Array;
      
      public var sex:Boolean = false;
      
      public var level:uint = 0;
      
      public var ownerId:Number = 0;
      
      public var experience:Number = 0;
      
      public var experienceForLevel:Number = 0;
      
      public var experienceForNextLevel:Number = 0;
      
      public var xpRatio:uint;
      
      public var maxPods:uint = 0;
      
      public var isRideable:Boolean = false;
      
      public var isWild:Boolean = false;
      
      public var borning:Boolean = false;
      
      public var energy:uint = 0;
      
      public var energyMax:uint = 0;
      
      public var stamina:uint = 0;
      
      public var staminaMax:uint = 0;
      
      public var maturity:uint = 0;
      
      public var maturityForAdult:uint = 0;
      
      public var serenity:int = 0;
      
      public var serenityMax:uint = 0;
      
      public var aggressivityMax:int = 0;
      
      public var love:uint = 0;
      
      public var loveMax:uint = 0;
      
      public var fecondationTime:int = 0;
      
      public var isFecondationReady:Boolean;
      
      public var reproductionCount:int = 0;
      
      public var reproductionCountMax:uint = 0;
      
      public var boostLimiter:uint = 0;
      
      public var boostMax:Number = 0;
      
      public var harnessGID:uint = 0;
      
      public var useHarnessColors:Boolean;
      
      public var effectList:Array;
      
      public var ancestor:Object;
      
      public var ability:Array;
      
      private var _model:Mount;
      
      private var _familyHeadUri:String;
      
      public function MountData()
      {
         this.effectList = new Array();
         this.ability = new Array();
         super();
      }
      
      public static function makeMountData(o:MountClientData, cache:Boolean = true, xpRatio:uint = 0) : MountData
      {
         var ability:uint = 0;
         var nEffect:int = 0;
         var i:int = 0;
         var mountData:MountData = new MountData();
         if(_dictionary_cache[o.id] && cache)
         {
            mountData = getMountFromCache(o.id);
         }
         var mount:Mount = Mount.getMountById(o.model);
         if(!o.name)
         {
            mountData.name = I18n.getUiText("ui.common.noName");
         }
         else
         {
            mountData.name = o.name;
         }
         mountData.id = o.id;
         mountData.modelId = o.model;
         mountData.description = mount.name;
         mountData.sex = o.sex;
         mountData.ownerId = o.ownerId;
         mountData.level = o.level;
         mountData.experience = o.experience;
         mountData.experienceForLevel = o.experienceForLevel;
         mountData.experienceForNextLevel = o.experienceForNextLevel;
         mountData.xpRatio = xpRatio;
         try
         {
            mountData.entityLook = TiphonEntityLook.fromString(mount.look);
            mountData.colors = mountData.entityLook.getColors();
         }
         catch(e:Error)
         {
         }
         var a:Vector.<uint> = o.ancestor.concat();
         a.unshift(o.model);
         mountData.ancestor = makeParent(a,0,-1,0);
         mountData.ability = new Array();
         for each(ability in o.behaviors)
         {
            mountData.ability.push(MountBehavior.getMountBehaviorById(ability));
         }
         mountData.effectList = new Array();
         nEffect = o.effectList.length;
         for(i = 0; i < nEffect; i++)
         {
            mountData.effectList.push(ObjectEffectAdapter.fromNetwork(o.effectList[i]));
         }
         mountData.maxPods = o.maxPods;
         mountData.isRideable = o.isRideable;
         mountData.isWild = o.isWild;
         mountData.energy = o.energy;
         mountData.energyMax = o.energyMax;
         mountData.stamina = o.stamina;
         mountData.staminaMax = o.staminaMax;
         mountData.maturity = o.maturity;
         mountData.maturityForAdult = o.maturityForAdult;
         mountData.serenity = o.serenity;
         mountData.serenityMax = o.serenityMax;
         mountData.aggressivityMax = o.aggressivityMax;
         mountData.love = o.love;
         mountData.loveMax = o.loveMax;
         mountData.fecondationTime = o.fecondationTime;
         mountData.isFecondationReady = o.isFecondationReady;
         mountData.reproductionCount = o.reproductionCount;
         mountData.reproductionCountMax = o.reproductionCountMax;
         mountData.boostLimiter = o.boostLimiter;
         mountData.boostMax = o.boostMax;
         mountData.harnessGID = o.harnessGID;
         mountData.useHarnessColors = o.useHarnessColors;
         if(!_dictionary_cache[o.id] || !cache)
         {
            _dictionary_cache[mountData.id] = mountData;
         }
         return mountData;
      }
      
      public static function getMountFromCache(id:uint) : MountData
      {
         return _dictionary_cache[id];
      }
      
      private static function makeParent(ancestor:Vector.<uint>, generation:uint, start:int, index:uint) : Object
      {
         var nextStart:uint = start + Math.pow(2,generation - 1);
         var ancestorIndex:uint = nextStart + index;
         if(ancestor.length <= ancestorIndex)
         {
            return null;
         }
         var mount:Mount = Mount.getMountById(ancestor[ancestorIndex]);
         if(!mount)
         {
            return null;
         }
         return {
            "mount":mount,
            "mother":makeParent(ancestor,generation + 1,nextStart,0 + 2 * (ancestorIndex - nextStart)),
            "father":makeParent(ancestor,generation + 1,nextStart,1 + 2 * (ancestorIndex - nextStart)),
            "entityLook":TiphonEntityLook.fromString(mount.look)
         };
      }
      
      public function get model() : Mount
      {
         if(!this._model)
         {
            this._model = Mount.getMountById(this.modelId);
         }
         return this._model;
      }
      
      public function get familyHeadUri() : String
      {
         var family:MountFamily = null;
         if(!this._familyHeadUri)
         {
            family = MountFamily.getMountFamilyById(this.model.familyId);
            this._familyHeadUri = family.headUri;
         }
         return this._familyHeadUri;
      }
   }
}
