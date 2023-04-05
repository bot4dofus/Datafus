package com.ankamagames.dofus.datacenter.servers
{
   import com.ankamagames.dofus.datacenter.communication.NamingRule;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class ServerCommunity implements IDataCenter
   {
      
      public static const MODULE:String = "ServerCommunities";
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(ServerCommunity));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getServerCommunityById,getServerCommunities);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var shortId:String;
      
      public var defaultCountries:Vector.<String>;
      
      public var supportedLangIds:Vector.<int>;
      
      public var namingRulePlayerNameId:int;
      
      public var namingRuleGuildNameId:int;
      
      public var namingRuleAllianceNameId:int;
      
      public var namingRuleAllianceTagId:int;
      
      public var namingRulePartyNameId:int;
      
      public var namingRuleMountNameId:int;
      
      public var namingRuleNameGeneratorId:int;
      
      public var namingRuleAdminId:int;
      
      public var namingRuleModoId:int;
      
      public var namingRulePresetNameId:int;
      
      private var _name:String;
      
      private var _namingRulePlayerName:NamingRule;
      
      private var _namingRuleGuildName:NamingRule;
      
      private var _namingRuleAllianceName:NamingRule;
      
      private var _namingRuleAllianceTag:NamingRule;
      
      private var _namingRulePartyName:NamingRule;
      
      private var _namingRuleMountName:NamingRule;
      
      private var _namingRuleNameGenerator:NamingRule;
      
      private var _namingRuleAdmin:NamingRule;
      
      private var _namingRuleModo:NamingRule;
      
      private var _namingRulePresetName:NamingRule;
      
      public function ServerCommunity()
      {
         super();
      }
      
      public static function getServerCommunityById(id:int) : ServerCommunity
      {
         return GameData.getObject(MODULE,id) as ServerCommunity;
      }
      
      public static function getServerCommunities() : Array
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
      
      public function get namingRulePlayerName() : NamingRule
      {
         if(!this._namingRulePlayerName)
         {
            this._namingRulePlayerName = NamingRule.getNamingRuleById(this.namingRulePlayerNameId);
         }
         return this._namingRulePlayerName;
      }
      
      public function get namingRuleGuildName() : NamingRule
      {
         if(!this._namingRuleGuildName)
         {
            this._namingRuleGuildName = NamingRule.getNamingRuleById(this.namingRuleGuildNameId);
         }
         return this._namingRuleGuildName;
      }
      
      public function get namingRuleAllianceName() : NamingRule
      {
         if(!this._namingRuleAllianceName)
         {
            this._namingRuleAllianceName = NamingRule.getNamingRuleById(this.namingRuleAllianceNameId);
         }
         return this._namingRuleAllianceName;
      }
      
      public function get namingRuleAllianceTag() : NamingRule
      {
         if(!this._namingRuleAllianceTag)
         {
            this._namingRuleAllianceTag = NamingRule.getNamingRuleById(this.namingRuleAllianceTagId);
         }
         return this._namingRuleAllianceTag;
      }
      
      public function get namingRulePartyName() : NamingRule
      {
         if(!this._namingRulePartyName)
         {
            this._namingRulePartyName = NamingRule.getNamingRuleById(this.namingRulePartyNameId);
         }
         return this._namingRulePartyName;
      }
      
      public function get namingRuleMountName() : NamingRule
      {
         if(!this._namingRuleMountName)
         {
            this._namingRuleMountName = NamingRule.getNamingRuleById(this.namingRuleMountNameId);
         }
         return this._namingRuleMountName;
      }
      
      public function get namingRuleNameGenerator() : NamingRule
      {
         if(!this._namingRuleNameGenerator)
         {
            this._namingRuleNameGenerator = NamingRule.getNamingRuleById(this.namingRuleNameGeneratorId);
         }
         return this._namingRuleNameGenerator;
      }
      
      public function get namingRuleAdmin() : NamingRule
      {
         if(!this._namingRuleAdmin)
         {
            this._namingRuleAdmin = NamingRule.getNamingRuleById(this.namingRuleAdminId);
         }
         return this._namingRuleAdmin;
      }
      
      public function get namingRuleModo() : NamingRule
      {
         if(!this._namingRuleModo)
         {
            this._namingRuleModo = NamingRule.getNamingRuleById(this.namingRuleModoId);
         }
         return this._namingRuleModo;
      }
      
      public function get namingRulePresetName() : NamingRule
      {
         if(!this._namingRulePresetName)
         {
            this._namingRulePresetName = NamingRule.getNamingRuleById(this.namingRulePresetNameId);
         }
         return this._namingRulePresetName;
      }
   }
}
