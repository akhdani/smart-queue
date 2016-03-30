define([
    'component/alt/alert',
    'component/mobel/auth'
], function(){
    return [
        '$scope', '$routeParams', '$log', '$rootScope', '$validate', '$auth', '$alert', 'Mobel_Auth',
        function($scope, $routeParams, $log, $rootScope, $validate, $auth, $alert, Mobel_Auth){
            var logout = function(){
                $auth.logout();
                store.set(alt.application + '_userdata', {});
                store.set(alt.application + '_user', {});
                $rootScope.redirect('auth/login');
            };

            Mobel_Auth.logout().then(function(response){
                $alert.add('Logout berhasil!');
                logout();
            }, function(error){
                logout();
            });
        }
    ];
});