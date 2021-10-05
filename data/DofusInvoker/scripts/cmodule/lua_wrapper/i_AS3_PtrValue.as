package cmodule.lua_wrapper
{
   const i_AS3_PtrValue:int = exportSym("_AS3_PtrValue",new CProcTypemap(CTypemap.PtrType,[CTypemap.AS3ValType]).createC(AS3_NOP)[0]);
}
