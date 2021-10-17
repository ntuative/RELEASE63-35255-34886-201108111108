package mx.utils
{
    import mx.core.mx_internal;
    import flash.utils.getQualifiedClassName;
    import flash.display.DisplayObject;
    import mx.core.IRepeaterClient;

    use namespace mx_internal;

    public class NameUtil 
    {

        mx_internal static const VERSION:String = "4.1.0.16021";
        private static var counter:int = 0;


        public static function createUniqueName(param1:Object):String
        {
            if (!param1)
            {
                return (null);
            };
            var _loc2_:String = getQualifiedClassName(param1);
            var _loc3_:int = _loc2_.indexOf("::");
            if (_loc3_ != -1)
            {
                _loc2_ = _loc2_.substr((_loc3_ + 2));
            };
            var _loc4_:int = _loc2_.charCodeAt((_loc2_.length - 1));
            if (((_loc4_ >= 48) && (_loc4_ <= 57)))
            {
                _loc2_ = (_loc2_ + "_");
            };
            return (_loc2_ + counter++);
        }

        public static function displayObjectToString(displayObject:DisplayObject):String
        {
            var result:String;
            var o:DisplayObject;
            var s:String;
            var indices:Array;
            try
            {
                o = displayObject;
                while (o != null)
                {
                    if ((((o.parent) && (o.stage)) && (o.parent == o.stage))) break;
                    s = ((("id" in o) && (o["id"])) ? o["id"] : o.name);
                    if ((o is IRepeaterClient))
                    {
                        indices = IRepeaterClient(o).instanceIndices;
                        if (indices)
                        {
                            s = (s + (("[" + indices.join("][")) + "]"));
                        };
                    };
                    result = ((result == null) ? s : ((s + ".") + result));
                    o = o.parent;
                };
            }
            catch(e:SecurityError)
            {
            };
            return (result);
        }

        public static function getUnqualifiedClassName(param1:Object):String
        {
            var _loc2_:String;
            if ((param1 is String))
            {
                _loc2_ = (param1 as String);
            }
            else
            {
                _loc2_ = getQualifiedClassName(param1);
            };
            var _loc3_:int = _loc2_.indexOf("::");
            if (_loc3_ != -1)
            {
                _loc2_ = _loc2_.substr((_loc3_ + 2));
            };
            return (_loc2_);
        }


    }
}