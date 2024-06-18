package com.ankamagames.dofus.network.types.secure
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TrustCertificate implements INetworkType
   {
      
      public static const protocolId:uint = 3311;
       
      
      public var id:uint = 0;
      
      public var hash:String = "";
      
      public function TrustCertificate()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3311;
      }
      
      public function initTrustCertificate(id:uint = 0, hash:String = "") : TrustCertificate
      {
         this.id = id;
         this.hash = hash;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.hash = "";
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TrustCertificate(output);
      }
      
      public function serializeAs_TrustCertificate(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeInt(this.id);
         output.writeUTF(this.hash);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TrustCertificate(input);
      }
      
      public function deserializeAs_TrustCertificate(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._hashFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TrustCertificate(tree);
      }
      
      public function deserializeAsyncAs_TrustCertificate(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._hashFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of TrustCertificate.id.");
         }
      }
      
      private function _hashFunc(input:ICustomDataInput) : void
      {
         this.hash = input.readUTF();
      }
   }
}
