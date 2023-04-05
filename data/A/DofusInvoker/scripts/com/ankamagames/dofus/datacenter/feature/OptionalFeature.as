package com.ankamagames.dofus.datacenter.feature
{
   import com.ankamagames.dofus.datacenter.feature.criterion.GroupFeatureCriterion;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   
   public class OptionalFeature implements IDataCenter
   {
      
      public static const MODULE:String = "OptionalFeatures";
      
      private static var _keywords:Dictionary;
      
      public static var idAccessors:IdAccessors = new IdAccessors(getOptionalFeatureById,getAllOptionalFeatures);
       
      
      public var id:int;
      
      public var keyword:String;
      
      public var isClient:Boolean;
      
      public var isServer:Boolean;
      
      public var isActivationOnLaunch:Boolean = false;
      
      public var isActivationOnServerConnection:Boolean = false;
      
      public var activationCriterions:String = null;
      
      public function OptionalFeature()
      {
         super();
      }
      
      public static function getOptionalFeatureById(id:int) : OptionalFeature
      {
         return GameData.getObject(MODULE,id) as OptionalFeature;
      }
      
      public static function getOptionalFeatureByKeyword(key:String) : OptionalFeature
      {
         var feature:OptionalFeature = null;
         if(!_keywords || !_keywords[key])
         {
            _keywords = new Dictionary();
            for each(feature in getAllOptionalFeatures())
            {
               _keywords[feature.keyword] = feature;
            }
         }
         return _keywords[key];
      }
      
      public static function getAllOptionalFeatures() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get canBeEnabled() : Boolean
      {
         if(!this.activationCriterions)
         {
            return true;
         }
         var groupFeatureCriterion:GroupFeatureCriterion = new GroupFeatureCriterion(this.activationCriterions);
         return groupFeatureCriterion.isRespected;
      }
      
      public function toString() : String
      {
         var featureTypeLabel:String = null;
         if(this.isClient && !this.isServer)
         {
            featureTypeLabel = "Client";
         }
         else if(!this.isClient && this.isServer)
         {
            featureTypeLabel = "Server";
         }
         else if(this.isClient && this.isServer)
         {
            featureTypeLabel = "Client/Server";
         }
         else
         {
            featureTypeLabel = "???";
         }
         return "Feature " + this.keyword + " (ID: " + this.id.toString() + ") [" + featureTypeLabel + "]";
      }
   }
}
