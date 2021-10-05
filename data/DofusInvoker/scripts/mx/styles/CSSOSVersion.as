package mx.styles
{
   public class CSSOSVersion
   {
      
      private static const SEPARATOR:String = ".";
       
      
      public var major:int = 0;
      
      public var minor:int = 0;
      
      public var revision:int = 0;
      
      public function CSSOSVersion(versionString:String = "")
      {
         super();
         var versionParts:Array = versionString.split(SEPARATOR);
         var l:int = versionParts.length;
         if(l >= 1)
         {
            this.major = Number(versionParts[0]);
         }
         if(l >= 2)
         {
            this.minor = Number(versionParts[1]);
         }
         if(l >= 3)
         {
            this.revision = Number(versionParts[2]);
         }
      }
      
      public function compareTo(otherVersion:CSSOSVersion) : int
      {
         if(this.major > otherVersion.major)
         {
            return 1;
         }
         if(this.major < otherVersion.major)
         {
            return -1;
         }
         if(this.minor > otherVersion.minor)
         {
            return 1;
         }
         if(this.minor < otherVersion.minor)
         {
            return -1;
         }
         if(this.revision > otherVersion.revision)
         {
            return 1;
         }
         if(this.revision < otherVersion.revision)
         {
            return -1;
         }
         return 0;
      }
      
      public function toString() : String
      {
         return this.major.toString() + SEPARATOR + this.minor.toString() + SEPARATOR + this.revision.toString();
      }
   }
}
