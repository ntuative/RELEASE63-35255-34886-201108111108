package com.sulake.core.window.graphics
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.BitmapData;
    import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;

    public class DrawBufferAllocator implements IDisposable 
    {

        private var _disposed:Boolean;
        private var var_2739:Array;

        public function DrawBufferAllocator()
        {
            this._disposed = false;
            this.var_2739 = new Array();
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get allocatedByteCount():uint
        {
            var bitmap:BitmapData;
            var bytes:uint;
            var index:uint = this.var_2739.length;
            try
            {
                while (index > 0)
                {
                    index--;
                    bitmap = BitmapData(this.var_2739[index]);
                    bytes = (bytes + ((bitmap.width * bitmap.height) * 4));
                };
            }
            catch(e:Error)
            {
                Logger.log("Disposed bitmap in DrawBufferAllocator!");
            };
            return (bytes);
        }

        public function dispose():void
        {
            var _loc1_:uint;
            if (!this._disposed)
            {
                this._disposed = true;
                _loc1_ = this.var_2739.length;
                while (_loc1_ > 0)
                {
                    BitmapData(this.var_2739.pop()).dispose();
                    _loc1_--;
                };
            };
        }

        public function allocate(width:int, height:int, transparent:Boolean=true, fillColor:uint=0xFFFFFFFF):BitmapData
        {
            var bitmap:BitmapData;
            try
            {
                bitmap = new TrackedBitmapData(this, width, height, transparent, fillColor);
            }
            catch(error:ArgumentError)
            {
                Logger.log((((("Failed to allocate draw buffer of size " + width) + "x") + height) + "!"));
                bitmap = new TrackedBitmapData(this, 1, 1, transparent, fillColor);
            };
            this.var_2739.push(bitmap);
            return (bitmap);
        }

        public function free(param1:BitmapData):void
        {
            var _loc2_:uint = this.var_2739.indexOf(param1);
            if (_loc2_ < 0)
            {
                throw (new ArgumentError("Provided bitmap data is not managed by this instance!"));
            };
            this.var_2739.splice(_loc2_, 1);
            param1.dispose();
        }


    }
}