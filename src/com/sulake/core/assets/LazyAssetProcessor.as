package com.sulake.core.assets
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.Core;

    public class LazyAssetProcessor implements IUpdateReceiver 
    {

        private var var_2580:Array = new Array();
        private var var_2581:Boolean = false;
        private var _disposed:Boolean = false;


        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                Core.instance.removeUpdateReceiver(this);
                this.var_2580 = null;
                this.var_2581 = false;
                this._disposed = true;
            };
        }

        public function push(param1:ILazyAsset):void
        {
            if (param1)
            {
                this.var_2580.push(param1);
                if (!this.var_2581)
                {
                    Core.instance.registerUpdateReceiver(this, 2);
                    this.var_2581 = true;
                };
            };
        }

        public function flush():void
        {
            var _loc1_:ILazyAsset;
            for each (_loc1_ in this.var_2580)
            {
                if (!_loc1_.disposed)
                {
                    _loc1_.prepareLazyContent();
                };
            };
            this.var_2580 = new Array();
            if (this.var_2581)
            {
                Core.instance.removeUpdateReceiver(this);
                this.var_2581 = false;
            };
        }

        public function update(param1:uint):void
        {
            var _loc2_:ILazyAsset = this.var_2580.shift();
            if (!_loc2_)
            {
                if (this.var_2581)
                {
                    Core.instance.removeUpdateReceiver(this);
                    this.var_2581 = false;
                };
            }
            else
            {
                if (!_loc2_.disposed)
                {
                    _loc2_.prepareLazyContent();
                };
            };
        }


    }
}