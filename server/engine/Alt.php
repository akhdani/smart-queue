<?php defined('ALT_PATH') OR die('No direct access allowed.');

// php5.2 support
function array_union(){
    $args = func_get_args();

    $array1 = is_array($args[0]) ? $args[0] : array();
    $union = $array1;
    if(count($args) > 1) for($i=1; $i<count($args); $i++){
        $array2 = $args[$i];
        foreach ($array2 as $key => $value) {
            if (false === array_key_exists($key, $union)) {
                $union[$key] = $value;
            }
        }
    }

    return $union;
}

if (!function_exists('http_response_code')){
    function http_response_code($newcode = NULL) {
        static $code = 200;
        if($newcode !== NULL) {
            header('X-PHP-Response-Code: '.$newcode, true, $newcode);
            if(!headers_sent())
                $code = $newcode;
        }
        return $code;
    }
}

class Alt {
    // environment
    const ENV_DEVELOPMENT           = 1;
    const ENV_PRODUCTION            = 2;
    public static $environment      = self::ENV_PRODUCTION;

    // output type
    const OUTPUT_HTML               = 'html';
    const OUTPUT_JSON               = 'json';
    const OUTPUT_XML                = 'xml';
    public static $outputs          = array(
        self::OUTPUT_JSON           => 'application/',
        self::OUTPUT_XML            => 'application/',
        self::OUTPUT_HTML           => 'text/',
    );
    public static $output           = self::OUTPUT_JSON;

    // response status
    const STATUS_OK                 = '200';
    const STATUS_UNAUTHORIZED       = '401';
    const STATUS_FORBIDDEN          = '403';
    const STATUS_NOTFOUND           = '404';
    const STATUS_ERROR              = '500';
    public static $status           = array(
        self::STATUS_OK             => 'OK',
        self::STATUS_UNAUTHORIZED   => 'UNAUTHORIZED',
        self::STATUS_FORBIDDEN      => 'FORBIDDEN',
        self::STATUS_NOTFOUND       => 'NOTFOUND',
        self::STATUS_ERROR          => 'ERROR',
    );

    // profiler
    public static $timestart        = 0;
    public static $timestop         = 0;
    public static $config           = array();

    /**
     * Start Alt application
     * @param array $options
     */
    public static function start($options = array()){
        session_start();

        // set timestart
        self::$timestart = $_SERVER['REQUEST_TIME_FLOAT'];

        // read config
        self::$config = $options['config'] ? $options['config'] : (include_once ALT_PATH . 'config.php');

        // set environment
        self::$environment = $options['environment'] ? $options['environment'] : (self::$config['app']['environment'] ? (strtolower(self::$config['app']['environment']) == 'development' ? self::ENV_DEVELOPMENT : self::ENV_PRODUCTION) : self::$environment);

        // set log level
        Alt_Log::$level = $options['loglevel'] ? $options['loglevel'] : (self::$config['app']['loglevel'] ? self::$config['app']['loglevel'] : (self::$environment == self::ENV_PRODUCTION ? Alt_Log::LEVEL_ERROR : Alt_Log::LEVEL_LOG));

        // set default output
        self::$output = $options['output'] ? $options['output'] : (self::$config['app']['output'] ? self::$config['app']['output'] : self::$output);

        // can be used as a web app or command line
        switch(PHP_SAPI){
            case 'cli':
                $baseurl = '';
                $total = (int)$_SERVER['argc'];
                if($total > 1) for($i=1; $i<$total; $i++){
                    list($key, $value) = explode('=', trim($_SERVER['argv'][$i]));

                    switch($key){
                        case '--uri':
                            $_SERVER['REQUEST_URI'] = strtolower($value);
                            break;
                        default:
                            $_REQUEST[$key] = $value;
                            break;
                    }
                }
                $_SERVER['REQUEST_URI'] = $_SERVER['REQUEST_URI'] ? $_SERVER['REQUEST_URI'] : "";
                break;
            default:
                list($baseurl) = explode('index.php', $_SERVER['PHP_SELF']);

                if(self::$environment == self::ENV_PRODUCTION && self::$config['security']){
                    parse_str(Alt_Security::decrypt(file_get_contents('php://input'), self::$config['security']), $request);
                    if(count($request) > 0){
                        $_REQUEST = $request;
                        $_POST = $_REQUEST;
                    }
                }
                break;
        }

        // get authorization token
        if(function_exists('apache_request_headers')){
            $headers = apache_request_headers();
            if (isset($headers['Authorization'])) {
                $matches = array();
                preg_match('/Token token="(.*)"/', $headers['Authorization'], $matches);
                if (isset($matches[1])) $_REQUEST['token'] = $matches[1];
            }
        }

        // get routing and output type
        $uri = substr($_SERVER['REQUEST_URI'], strlen($baseurl)) ? substr($_SERVER['REQUEST_URI'], strlen($baseurl)) : "";
        list($route) = explode('?', $uri);
        list($routing, $ext) = explode(".", $route);
        $routing = $routing ? $routing : 'index';
        $routing = str_replace('/', DIRECTORY_SEPARATOR, $routing);

        if(isset(self::$outputs[$ext])) self::$output = $ext;

        try{
            // check routing
            $routes = explode(DIRECTORY_SEPARATOR, $routing);
            if($routes[count($routes)-1] == 'pre' || $routes[count($routes)-1] == 'post')
                throw new Alt_Exception("Request not found", self::STATUS_NOTFOUND);

            // check permission
            if(isset(self::$config['route']) && isset(self::$config['route'][$routes[0]]))
                System_Auth::set_permission(self::$config['route'][$routes[0]]);

            // pre file before controller
            $pre = ALT_PATH . 'route' . DIRECTORY_SEPARATOR . $routes[0] . DIRECTORY_SEPARATOR . 'pre.php';
            if(is_file($pre))
                include_once $pre;

            // try get file in route folder
            $controller = ALT_PATH . 'route' . DIRECTORY_SEPARATOR . $routing . '.php';
            if(!is_file($controller)) throw new Alt_Exception("Request not found", self::STATUS_NOTFOUND);

            ob_start();
            $res = (include_once $controller);

            $res = ob_get_contents() ? ob_get_contents() : $res;
            ob_end_clean();

            $GLOBALS['response'] = $res;

            // post route
            $post = ALT_PATH . 'route' . DIRECTORY_SEPARATOR . $routes[0] . DIRECTORY_SEPARATOR . 'post.php';
            if(is_file($post))
                include_once $post;

            $res = $GLOBALS['response'] = $res;
            self::response(array(
                's' => self::STATUS_OK,
                'd' => $res,
            ));
        }catch(Alt_Exception $e){
            self::response(array(
                's' => $e->getCode(),
                'm' => $e->getMessage(),
            ));
        }catch(Exception $e){
            self::response(array(
                's' => self::STATUS_ERROR,
                'm' => self::$environment == self::ENV_DEVELOPMENT ? $e->getCode() . " : " . $e->getMessage() : self::$status[self::STATUS_ERROR],
            ));
        }
    }

    public static function autoload($class){
        // Transform the class name according to PSR-0
        $class     = ltrim($class, '\\');
        $file      = ALT_PATH . 'engine' . DIRECTORY_SEPARATOR . str_replace('_', DIRECTORY_SEPARATOR, $class) . '.php';

        if (is_file($file)) {
            require $file;
            return TRUE;
        }
        return FALSE;
    }

    public static function response($output = array(), $options = array()){
        // set response header
        header('Access-Control-Allow-Origin: *');
        header('Access-Control-Allow-Methods: *');
        header('Access-Control-Allow-Headers: *');
        header('Content-Type: ' . self::$outputs[self::$output] . self::$output . '; charset=UTF-8');
        http_response_code($output['s']);

        // adding benchmark time and memory
        self::$timestop = microtime(true);
        if(self::$environment == self::ENV_DEVELOPMENT) $output['t'] = round(self::$timestop - self::$timestart, 6);
        if(self::$environment == self::ENV_DEVELOPMENT) $output['u'] = memory_get_peak_usage(true) / 1000;

        // switch by output type
        switch(self::$output){
            case self::OUTPUT_JSON:
            default:
                $output = $output['s'] == self::STATUS_OK && $output['d']? $output['d'] : $output['m'];
                $output = json_encode($output);
                break;
            case self::OUTPUT_XML:
                $text = $output['s'] == self::STATUS_OK && $output['d']? $output['d'] : $output['m'];
                $output  = '<?xml version="1.0" encoding="UTF-8"?>';
                $output .= '<xml>';
                $output .= self::xml_encode($text);
                $output .= '</xml>';
                break;
            case self::OUTPUT_HTML:
                $output = $output['s'] == self::STATUS_OK && $output['d'] ? $output['d'] : $output['m'];
                break;
        }

        if(self::$environment == self::ENV_PRODUCTION && self::$config['security'])
            $output = Alt_Security::encrypt($output, self::$config['security']);

        header('Content-length: ' . strlen($output));
        echo $output;
    }

    public static function xml_encode($data){
        $str = '';
        switch(gettype($data)){
            case 'string':
            case 'number':
            case 'integer':
            case 'double':
            default:
                $str .= $data;
                break;
            case 'array':
            case 'object':
                foreach($data as $key => $value){
                    $str .= '<' . $key . '>';
                    $str .= self::xml_encode($value);
                    $str .= '</' . $key . '>';
                }
                break;
        }
        return $str;
    }
}