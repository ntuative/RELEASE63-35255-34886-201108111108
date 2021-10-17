package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindow;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.display.Bitmap;
    import com.sulake.core.assets.BitmapDataAsset;

    public class PendingImage implements IDisposable 
    {

        private var var_4407:HabboQuestEngine;
        private var var_4444:IWindow;

        public function PendingImage(param1:HabboQuestEngine, param2:IWindow, param3:String)
        {
            this.var_4407 = param1;
            this.var_4444 = param2;
            this.setImageFromAsset(param2, param3, this.onPreviewImageReady);
        }

        public static function retrievePreviewAsset(param1:HabboQuestEngine, param2:String, param3:Function):void
        {
            if (((!(param2)) || (!(param1.assets))))
            {
                return;
            };
            var _loc4_:String = param1.configuration.getKey("image.library.questing.url");
            var _loc5_:* = ((_loc4_ + param2) + ".png");
            Logger.log(("[HabboQuestEngine] Retrieve Product Preview Asset: " + _loc5_));
            var _loc6_:URLRequest = new URLRequest(_loc5_);
            var _loc7_:AssetLoaderStruct = param1.assets.loadAssetFromFile(param2, _loc6_, "image/png");
            if (!_loc7_)
            {
                return;
            };
            _loc7_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, param3);
        }

        public static function setElementImage(param1:IWindow, param2:BitmapData, param3:int=0):void
        {
            var _loc7_:IBitmapWrapperWindow;
            var _loc8_:IDisplayObjectWrapper;
            if (param2 == null)
            {
                return;
            };
            if (param1 == null)
            {
                return;
            };
            if (param1.disposed)
            {
                return;
            };
            var _loc4_:int = ((param3 > 0) ? param3 : param1.height);
            var _loc5_:int = int(((param1.width - param2.width) / 2));
            var _loc6_:int = int(((_loc4_ - param2.height) / 2));
            if ((param1 as IBitmapWrapperWindow) != null)
            {
                _loc7_ = IBitmapWrapperWindow(param1);
                if (((_loc7_.bitmap == null) || (param3 > 0)))
                {
                    _loc7_.bitmap = new BitmapData(param1.width, _loc4_, true, 0xFFFFFF);
                };
                _loc7_.bitmap.fillRect(_loc7_.bitmap.rect, 0xFFFFFF);
                _loc7_.bitmap.copyPixels(param2, param2.rect, new Point(_loc5_, _loc6_), null, null, false);
                param1.invalidate();
            }
            else
            {
                if ((param1 as IDisplayObjectWrapper) != null)
                {
                    _loc8_ = IDisplayObjectWrapper(param1);
                    _loc8_.setDisplayObject(new Bitmap(param2));
                };
            };
        }


        public function dispose():void
        {
            this.var_4444 = null;
            this.var_4407 = null;
        }

        public function get disposed():Boolean
        {
            return (this.var_4407 == null);
        }

        private function onPreviewImageReady(param1:AssetLoaderEvent):void
        {
            var _loc2_:AssetLoaderStruct;
            if (!this.disposed)
            {
                _loc2_ = (param1.target as AssetLoaderStruct);
                if (_loc2_ != null)
                {
                    this.setImageFromAsset(this.var_4444, _loc2_.assetName, null);
                };
            };
            this.dispose();
        }

        public function setImageFromAsset(param1:IWindow, param2:String, param3:Function):void
        {
            if (((!(param2)) || (!(this.var_4407.assets))))
            {
                return;
            };
            var _loc4_:BitmapDataAsset = (this.var_4407.assets.getAssetByName(param2) as BitmapDataAsset);
            if (_loc4_ == null)
            {
                retrievePreviewAsset(this.var_4407, param2, param3);
                return;
            };
            if (param1)
            {
                setElementImage(param1, (_loc4_.content as BitmapData));
            };
        }


    }
}