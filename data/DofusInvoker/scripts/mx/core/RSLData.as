package mx.core
{
   use namespace mx_internal;
   
   public class RSLData
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      private var _applicationDomainTarget:String;
      
      private var _digest:String;
      
      private var _hashType:String;
      
      private var _isSigned:Boolean;
      
      private var _moduleFactory:IFlexModuleFactory;
      
      private var _policyFileURL:String;
      
      private var _rslURL:String;
      
      private var _verifyDigest:Boolean;
      
      public function RSLData(rslURL:String = null, policyFileURL:String = null, digest:String = null, hashType:String = null, isSigned:Boolean = false, verifyDigest:Boolean = false, applicationDomainTarget:String = "default")
      {
         super();
         this._rslURL = rslURL;
         this._policyFileURL = policyFileURL;
         this._digest = digest;
         this._hashType = hashType;
         this._isSigned = isSigned;
         this._verifyDigest = verifyDigest;
         this._applicationDomainTarget = applicationDomainTarget;
         this._moduleFactory = this.moduleFactory;
      }
      
      public function get applicationDomainTarget() : String
      {
         return this._applicationDomainTarget;
      }
      
      public function get digest() : String
      {
         return this._digest;
      }
      
      public function get hashType() : String
      {
         return this._hashType;
      }
      
      public function get isSigned() : Boolean
      {
         return this._isSigned;
      }
      
      public function get moduleFactory() : IFlexModuleFactory
      {
         return this._moduleFactory;
      }
      
      public function set moduleFactory(moduleFactory:IFlexModuleFactory) : void
      {
         this._moduleFactory = moduleFactory;
      }
      
      public function get policyFileURL() : String
      {
         return this._policyFileURL;
      }
      
      public function get rslURL() : String
      {
         return this._rslURL;
      }
      
      public function get verifyDigest() : Boolean
      {
         return this._verifyDigest;
      }
   }
}
