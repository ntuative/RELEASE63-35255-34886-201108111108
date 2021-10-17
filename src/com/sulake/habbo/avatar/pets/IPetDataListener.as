package com.sulake.habbo.avatar.pets
{
    import com.sulake.core.runtime.IDisposable;

    public interface IPetDataListener extends IDisposable 
    {

        function petDataReady():void;

    }
}