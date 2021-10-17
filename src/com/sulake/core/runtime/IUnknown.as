package com.sulake.core.runtime
{
    public interface IUnknown extends IDisposable 
    {

        function queueInterface(param1:IID, param2:Function=null):IUnknown;
        function release(param1:IID):uint;

    }
}