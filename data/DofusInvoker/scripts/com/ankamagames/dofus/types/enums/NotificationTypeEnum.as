package com.ankamagames.dofus.types.enums
{
   public class NotificationTypeEnum
   {
      
      public static const TUTORIAL:uint = 0;
      
      public static const ERROR:uint = 1;
      
      public static const INVITATION:uint = 2;
      
      public static const PRIORITY_INVITATION:uint = 3;
      
      public static const INFORMATION:uint = 4;
      
      public static const SERVER_INFORMATION:uint = 5;
      
      public static const SURVEY_INVITATION:uint = 6;
      
      public static const WARNING:uint = 7;
      
      public static const NOTIFICATION_PRIORITY:Array = [NotificationTypeEnum.ERROR,NotificationTypeEnum.WARNING,NotificationTypeEnum.PRIORITY_INVITATION,NotificationTypeEnum.INVITATION,NotificationTypeEnum.SERVER_INFORMATION,NotificationTypeEnum.INFORMATION,NotificationTypeEnum.TUTORIAL,NotificationTypeEnum.SURVEY_INVITATION];
       
      
      public function NotificationTypeEnum()
      {
         super();
      }
   }
}
