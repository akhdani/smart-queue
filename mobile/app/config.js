// application specific
alt.appid = 'smartqueue';
alt.application = 'smartqueue';
alt.title = 'Smart Queue';
alt.description = '';
alt.version = '1.0.0';

// environment
alt.environment = 'production';
alt.serverUrl = 'http://localhost/smart-queue/php/';
alt.urlArgs = alt.environment == 'production' ? '_v=' + alt.version : '_t=' + (+new Date());
alt.timeout = 30000;
alt.defaultRoute = 'home';
alt.secure = {
    key: 'u/Gu5posvwDsXUnV5Zaq4g==',
    iv: '5D9r9ZVzEYYgha93/aUK2w=='
};

// oauth
alt.oauth = {
    google: {
        clientid: '27235824443-m1hqk0vci2nprf1no9g7jt2nj09ro14d.apps.googleusercontent.com',
        secret: 'mjhLmZZxi0qaTCRvm84W0gHp'
    }
};

// advanced configuration
alt.run(['$log', '$q', '$rootScope', '$auth', '$api', '$route', '$window', '$timeout',
    function($log, $q, $rootScope, $auth, $api, $route, $window, $timeout){
        $rootScope.back = function(num){
            if(navigator && navigator.app){
                navigator.app.backHistory(typeof num === 'undefined' ? -1 : num);
            }else{
                $window.history.go(-1);
            }
        };

        $rootScope.redirect = function(url, timeout){
            url = url || '';
            timeout = timeout || 0;

            if(timeout > 0){
                $timeout(function(){
                    $window.location.href = alt.baseUrl + url;
                }, timeout);
            }else{
                $window.location.href = alt.baseUrl + url;
            }
        };

        $rootScope.select = function(){
            $timeout(function(){
                $('select').material_select();
            });
        };

        $rootScope.$on('$routeChangeStart', function(event, currRoute, prevRoute){
            if(window.cordova && window.cordova.plugins && window.cordova.plugins.Keyboard){
                window.cordova.plugins.Keyboard.close();
            }

            $rootScope.isloading = false;
            $rootScope.select();

            /*if(currRoute.params.altcontroller != 'auth' && $auth.islogin() && $auth.token){
                $api('mobile/auth').connect('token', {appversion: alt.version, appid: alt.appid}).then(function(response){
                    var userdata = angular.copy($auth.userdata);
                    $auth.login(response.data);
                    userdata.iat = $auth.userdata.iat;
                    $auth.set_userdata(userdata);
                });
            }else if(currRoute.params.altcontroller != 'auth' && !$auth.islogin() && typeof $auth.userdata.idpel === 'undefined'){
                $rootScope.redirect('auth/login');
                event.preventDefault();
            }*/
        });
    }
]);