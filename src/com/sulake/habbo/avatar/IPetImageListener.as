package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.IDisposable;

    public interface IPetImageListener extends IDisposable 
    {

        function petImageReady(param1:String):void;

    }
}