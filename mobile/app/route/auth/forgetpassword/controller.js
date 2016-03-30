define([
    'component/alt/alert',
    'component/mobel/auth'
], function(){
    return [
        '$scope', '$routeParams', '$log', '$http', '$rootScope', '$validate', '$alert', 'Mobel_Auth',
        function($scope, $routeParams, $log, $http, $rootScope, $validate, $alert, Mobel_Auth){
            // data to register
            $scope.data = {
                username        : '',
                imei            : ''
            };

            if(window.device){
                $scope.data.imei = window.device.uuid;
            }
            if (window.cordova){
                $scope.data.imei = window.cordova.plugins.uid.IMEI || window.cordova.plugins.uid.UUID || $scope.data.imei;
            }

            $scope.submit = function(){
                var isvalid = $validate()
                    .rule($validate.required($scope.data.username), 'Isi Email / ID Pel / Nomor Meter terlebih dahulu!')
                    .check();

                if(!isvalid) return;

                Mobel_Auth.forget($scope.data).then(function(response){
                    $alert.add('Silahkan periksa email anda untuk memperoleh kode reset password!');
                    $rootScope.redirect('auth/login');
                }, function(response){
                    $alert.add('Permohonan kode reset password gagal!');
                });
            };
        }
    ];
});