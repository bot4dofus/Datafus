package com.ankama.haapi.client.model
{
   public class Account
   {
      
      public static const TypeEnum_ANKAMA:String = "ANKAMA";
      
      public static const TypeEnum_EXTERNAL:String = "EXTERNAL";
      
      public static const TypeEnum_GUEST:String = "GUEST";
      
      public static const TypeEnum_GHOST:String = "GHOST";
      
      public static const Array_SHIELD:String = "SHIELD";
      
      public static const Array_AUTHENTICATOR:String = "AUTHENTICATOR";
      
      public static const CommunityEnum_COMMUNITY_0:String = "COMMUNITY_0";
      
      public static const CommunityEnum_COMMUNITY_1:String = "COMMUNITY_1";
      
      public static const CommunityEnum_COMMUNITY_2:String = "COMMUNITY_2";
      
      public static const CommunityEnum_COMMUNITY_3:String = "COMMUNITY_3";
      
      public static const CommunityEnum_COMMUNITY_4:String = "COMMUNITY_4";
      
      public static const CommunityEnum_COMMUNITY_5:String = "COMMUNITY_5";
      
      public static const CommunityEnum_COMMUNITY_6:String = "COMMUNITY_6";
      
      public static const CommunityEnum_COMMUNITY_7:String = "COMMUNITY_7";
      
      public static const CommunityEnum_COMMUNITY_8:String = "COMMUNITY_8";
      
      public static const CommunityEnum_COMMUNITY_9:String = "COMMUNITY_9";
      
      public static const CommunityEnum_COMMUNITY_10:String = "COMMUNITY_10";
      
      public static const CommunityEnum_COMMUNITY_11:String = "COMMUNITY_11";
      
      public static const CommunityEnum_COMMUNITY_12:String = "COMMUNITY_12";
      
      public static const CommunityEnum_COMMUNITY_13:String = "COMMUNITY_13";
      
      public static const CommunityEnum_COMMUNITY_14:String = "COMMUNITY_14";
      
      public static const LockedEnum_0:String = "0";
      
      public static const LockedEnum_1:String = "1";
      
      public static const LockedEnum_2:String = "2";
      
      public static const ParentEmailStatusEnum_ACCEPTED:String = "ACCEPTED";
      
      public static const ParentEmailStatusEnum_REFUSED:String = "REFUSED";
      
      public static const ParentEmailStatusEnum_PENDING:String = "PENDING";
       
      
      public var id:Number = 0;
      
      public var type:String = null;
      
      public var login:String = null;
      
      public var nickname:String = null;
      
      public var tag:String = null;
      
      public var firstname:String = null;
      
      public var lastname:String = null;
      
      private var _security_obj_class:Array = null;
      
      public var security:Vector.<String>;
      
      public var lang:String = null;
      
      public var community:String = null;
      
      public var added_date:Date = null;
      
      public var added_ip:String = null;
      
      public var login_date:Date = null;
      
      public var login_ip:String = null;
      
      public var locked:Number = 0;
      
      public var birth_date:Date = null;
      
      public var parent_email_status:String = null;
      
      public var secure:Boolean = false;
      
      public var secure_info:String = null;
      
      public var email:String = null;
      
      public var gsm:String = null;
      
      public var avatar_url:String = null;
      
      public function Account()
      {
         this.security = new Vector.<String>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "Account: ";
         str += " (id: " + this.id + ")";
         str += " (type: " + this.type + ")";
         str += " (login: " + this.login + ")";
         str += " (nickname: " + this.nickname + ")";
         str += " (tag: " + this.tag + ")";
         str += " (firstname: " + this.firstname + ")";
         str += " (lastname: " + this.lastname + ")";
         str += " (security: " + this.security + ")";
         str += " (lang: " + this.lang + ")";
         str += " (community: " + this.community + ")";
         str += " (added_date: " + this.added_date + ")";
         str += " (added_ip: " + this.added_ip + ")";
         str += " (login_date: " + this.login_date + ")";
         str += " (login_ip: " + this.login_ip + ")";
         str += " (locked: " + this.locked + ")";
         str += " (birth_date: " + this.birth_date + ")";
         str += " (parent_email_status: " + this.parent_email_status + ")";
         str += " (secure: " + this.secure + ")";
         str += " (secure_info: " + this.secure_info + ")";
         str += " (email: " + this.email + ")";
         str += " (gsm: " + this.gsm + ")";
         return str + (" (avatar_url: " + this.avatar_url + ")");
      }
   }
}
