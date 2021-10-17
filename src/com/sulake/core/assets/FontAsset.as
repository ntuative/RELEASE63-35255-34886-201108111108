package com.sulake.core.assets
{
    import flash.text.Font;
    import com.sulake.core.utils.FontEnum;

    public class FontAsset implements IAsset 
    {

        protected var var_2576:AssetTypeDeclaration;
        protected var var_2578:Font;
        protected var _disposed:Boolean = false;

        public function FontAsset(param1:AssetTypeDeclaration, param2:String=null)
        {
            this.var_2576 = param1;
        }

        public function get url():String
        {
            return (null);
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
                this.var_2576 = null;
                this.var_2578 = null;
                this._disposed = true;
            };
        }

        public function setUnknownContent(unknown:Object):void
        {
            try
            {
                if ((unknown is Class))
                {
                    this.var_2578 = Font(FontEnum.registerFont((unknown as Class)));
                };
            }
            catch(e:Error)
            {
                throw (new Error(("Failed to register font from resource: " + unknown.toString())));
            };
        }

        public function setFromOtherAsset(param1:IAsset):void
        {
            if ((param1 is FontAsset))
            {
                this.var_2578 = FontAsset(param1).var_2578;
            }
            else
            {
                throw (new Error("Provided asset should be of type FontAsset!"));
            };
        }

        public function setParamsDesc(param1:XMLList):void
        {
            var _loc3_:String;
            var _loc4_:String;
            var _loc2_:uint;
            while (_loc2_ < param1.length())
            {
                _loc3_ = param1[_loc2_].attribute("key");
                _loc4_ = param1[_loc2_].attribute("value");
                _loc2_++;
            };
        }


    }
}