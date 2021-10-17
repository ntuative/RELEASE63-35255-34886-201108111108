package com.sulake.core.assets
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.loaders.IAssetLoader;

    public class AssetLoaderStruct extends EventDispatcher implements IDisposable 
    {

        private var var_2569:IAssetLoader;
        private var var_2568:String;

        public function AssetLoaderStruct(param1:String, param2:IAssetLoader)
        {
            this.var_2568 = param1;
            this.var_2569 = param2;
        }

        public function get assetName():String
        {
            return (this.var_2568);
        }

        public function get assetLoader():IAssetLoader
        {
            return (this.var_2569);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (this.var_2569 != null)
                {
                    if (!this.var_2569.disposed)
                    {
                        this.var_2569.dispose();
                        this.var_2569 = null;
                    };
                };
                super.dispose();
            };
        }


    }
}