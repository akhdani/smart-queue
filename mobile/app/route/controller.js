define([

], function(){
    return [
        '$rootScope', '$log',
        function($rootScope, $log){
            $rootScope.redirect($auth.islogin() ? 'home' : 'auth/login');
        }
    ];
});