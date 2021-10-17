package com.sulake.core.assets
{
    import flash.media.Sound;
    import flash.utils.ByteArray;

    public class SoundAsset implements IAsset 
    {

        private var _disposed:Boolean = false;
        private var var_2578:Sound = null;
        private var var_2576:AssetTypeDeclaration;
        private var var_2552:String;

        public function SoundAsset(param1:AssetTypeDeclaration, param2:String=null)
        {
            this.var_2576 = param1;
            this.var_2552 = param2;
        }

        public function get url():String
        {
            return (this.var_2552);
        }

        public function get content():Object
        {
            return (this.var_2578 as Object);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get declaration():AssetTypeDeclaration
        {
            return (this.var_2576);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                this.var_2578 = null;
                this.var_2576 = null;
                this.var_2552 = null;
            };
        }

        public function setUnknownContent(param1:Object):void
        {
            if ((param1 is Sound))
            {
                if (this.var_2578)
                {
                    this.var_2578.close();
                };
                this.var_2578 = (param1 as Sound);
                return;
            };
            if ((param1 is ByteArray))
            {
            };
            if ((param1 is Class))
            {
                if (this.var_2578)
                {
                    this.var_2578.close();
                };
                this.var_2578 = (new (param1)() as Sound);
                return;
            };
            if ((param1 is SoundAsset))
            {
                if (this.var_2578)
                {
                    this.var_2578.close();
                };
                this.var_2578 = SoundAsset(param1).var_2578;
                return;
            };
        }

        public function setFromOtherAsset(param1:IAsset):void
        {
            if ((param1 is SoundAsset))
            {
                this.var_2578 = SoundAsset(param1).var_2578;
            };
        }

        public function setParamsDesc(param1:XMLList):void
        {
        }


    }
}