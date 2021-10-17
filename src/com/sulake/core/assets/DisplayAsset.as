package com.sulake.core.assets
{
    import flash.display.DisplayObject;

    public class DisplayAsset implements IAsset 
    {

        protected var var_2552:String;
        protected var var_2578:DisplayObject;
        protected var _disposed:Boolean = false;
        protected var var_2579:AssetTypeDeclaration;

        public function DisplayAsset(param1:AssetTypeDeclaration, param2:String=null)
        {
            this.var_2579 = param1;
            this.var_2552 = param2;
        }

        public function get url():String
        {
            return (this.var_2552);
        }

        public function get content():Object
        {
            return (this.var_2578);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get declaration():AssetTypeDeclaration
        {
            return (this.var_2579);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                if (this.var_2578.loaderInfo != null)
                {
                    if (this.var_2578.loaderInfo.loader != null)
                    {
                        this.var_2578.loaderInfo.loader.unload();
                    };
                };
                this.var_2578 = null;
                this.var_2579 = null;
                this._disposed = true;
                this.var_2552 = null;
            };
        }

        public function setUnknownContent(param1:Object):void
        {
            if ((param1 is DisplayObject))
            {
                this.var_2578 = (param1 as DisplayObject);
                if (this.var_2578 != null)
                {
                    return;
                };
                throw (new Error("Failed to convert DisplayObject to DisplayAsset!"));
            };
            if ((param1 is DisplayAsset))
            {
                this.var_2578 = DisplayAsset(param1).var_2578;
                this.var_2579 = DisplayAsset(param1).var_2579;
                if (this.var_2578 == null)
                {
                    throw (new Error("Failed to read content from DisplayAsset!"));
                };
            };
        }

        public function setFromOtherAsset(param1:IAsset):void
        {
            if ((param1 is DisplayAsset))
            {
                this.var_2578 = DisplayAsset(param1).var_2578;
                this.var_2579 = DisplayAsset(param1).var_2579;
            }
            else
            {
                throw (new Error("Provided asset should be of type DisplayAsset!"));
            };
        }

        public function setParamsDesc(param1:XMLList):void
        {
        }


    }
}