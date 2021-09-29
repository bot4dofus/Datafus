package scopart.raven
{
   import com.adobe.net.URI;
   
   public class RavenConfig
   {
       
      
      private var _uriObject:URI;
      
      private var _dsn:String;
      
      private var _uri:String;
      
      private var _path:String;
      
      private var _project:String;
      
      private var _publicKey:String;
      
      private var _privateKey:String;
      
      private var _release:String;
      
      private var _environment:String;
      
      public function RavenConfig(dsn:String, release:String, environment:String)
      {
         super();
         this._dsn = dsn;
         this._release = release;
         this._environment = environment;
         this._uriObject = new URI(this._dsn);
         this.parseDSN();
      }
      
      private function parseDSN() : void
      {
         var pathPart:String = null;
         this._uri = this._uriObject.scheme + "://" + this._uriObject.authority;
         this._uri += !!this._uriObject.port ? ":" + this._uriObject.port : "";
         var rawpath:Array = this._uriObject.path.split("/");
         rawpath.shift();
         this._path = "";
         if(rawpath.length == 0)
         {
            this._project = "";
         }
         else
         {
            this._project = rawpath.pop();
            for each(pathPart in rawpath)
            {
               this._path += pathPart + "/";
            }
         }
         this._uri += "/" + this._path;
         this._privateKey = this._uriObject.password;
         this._publicKey = this._uriObject.username;
      }
      
      public function get uri() : String
      {
         return this._uri;
      }
      
      public function get publicKey() : String
      {
         return this._publicKey;
      }
      
      public function get privateKey() : String
      {
         return this._privateKey;
      }
      
      public function get projectID() : String
      {
         return this._project;
      }
      
      public function get dsn() : String
      {
         return this._dsn;
      }
      
      public function get release() : String
      {
         return this._release;
      }
      
      public function get environment() : String
      {
         return this._environment;
      }
   }
}
