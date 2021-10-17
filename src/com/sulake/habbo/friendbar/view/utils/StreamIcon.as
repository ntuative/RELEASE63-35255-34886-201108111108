package com.sulake.habbo.friendbar.view.utils
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    public class StreamIcon extends Icon 
    {

        private static const var_2112:int = 500;

        private var _assets:IAssetLibrary;

        public function StreamIcon(param1:IAssetLibrary, param2:IBitmapWrapperWindow)
        {
            this._assets = param1;
            alignment = (var_2106 | var_2107);
            image = (param1.getAssetByName("icon_stream_png") as BitmapDataAsset);
            canvas = param2;
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                this._assets = null;
                super.dispose();
            };
        }

        override public function hover(param1:Boolean):void
        {
            if (param1)
            {
                image = (this._assets.getAssetByName(((var_2113) ? "icon_stream_new_hover_png" : "icon_stream_hover_png")) as BitmapDataAsset);
            }
            else
            {
                image = (this._assets.getAssetByName(((var_2113) ? "icon_stream_new_png" : "icon_stream_png")) as BitmapDataAsset);
            };
            super.hover(param1);
        }

        override public function notify(param1:Boolean):void
        {
            super.notify(param1);
            image = (this._assets.getAssetByName(((param1) ? "icon_stream_new_png" : "icon_stream_png")) as BitmapDataAsset);
        }


    }
}