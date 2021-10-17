package com.sulake.core.runtime
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import flash.utils.getQualifiedClassName;

    internal final class InterfaceStruct implements IDisposable 
    {

        private var var_2630:IID;
        private var var_2631:String;
        private var var_2577:IUnknown;
        private var var_2617:uint;

        public function InterfaceStruct(param1:IID, param2:IUnknown)
        {
            this.var_2630 = param1;
            this.var_2631 = getQualifiedClassName(this.var_2630);
            this.var_2577 = param2;
            this.var_2617 = 0;
        }

        public function get iid():IID
        {
            return (this.var_2630);
        }

        public function get iis():String
        {
            return (this.var_2631);
        }

        public function get unknown():IUnknown
        {
            return (this.var_2577);
        }

        public function get references():uint
        {
            return (this.var_2617);
        }

        public function get disposed():Boolean
        {
            return (this.var_2577 == null);
        }

        public function dispose():void
        {
            this.var_2630 = null;
            this.var_2631 = null;
            this.var_2577 = null;
            this.var_2617 = 0;
        }

        public function reserve():uint
        {
            return (++this.var_2617);
        }

        public function release():uint
        {
            return ((this.references > 0) ? --this.var_2617 : 0);
        }


    }
}