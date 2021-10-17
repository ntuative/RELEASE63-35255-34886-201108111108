package {
    import com.sulake.core.runtime.ILogger;
    import flash.external.ExternalInterface;

    public class Logger {

        public static var listener:ILogger;

        public function Logger() {
            super();
        }

        public static function log(...rest):void {
            ExternalInterface.call('console.log', JSON.stringify(rest));
        }
    }
}
