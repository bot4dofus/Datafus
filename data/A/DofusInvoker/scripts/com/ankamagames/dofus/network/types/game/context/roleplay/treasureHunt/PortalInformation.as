package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PortalInformation implements INetworkType
   {
      
      public static const protocolId:uint = 2561;
       
      
      public var portalId:int = 0;
      
      public var areaId:int = 0;
      
      public function PortalInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2561;
      }
      
      public function initPortalInformation(portalId:int = 0, areaId:int = 0) : PortalInformation
      {
         this.portalId = portalId;
         this.areaId = areaId;
         return this;
      }
      
      public function reset() : void
      {
         this.portalId = 0;
         this.areaId = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PortalInformation(output);
      }
      
      public function serializeAs_PortalInformation(output:ICustomDataOutput) : void
      {
         output.writeInt(this.portalId);
         output.writeShort(this.areaId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PortalInformation(input);
      }
      
      public function deserializeAs_PortalInformation(input:ICustomDataInput) : void
      {
         this._portalIdFunc(input);
         this._areaIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PortalInformation(tree);
      }
      
      public function deserializeAsyncAs_PortalInformation(tree:FuncTree) : void
      {
         tree.addChild(this._portalIdFunc);
         tree.addChild(this._areaIdFunc);
      }
      
      private function _portalIdFunc(input:ICustomDataInput) : void
      {
         this.portalId = input.readInt();
      }
      
      private function _areaIdFunc(input:ICustomDataInput) : void
      {
         this.areaId = input.readShort();
      }
   }
}
