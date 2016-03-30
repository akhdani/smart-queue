define([
    'component/alt/alert',
    'component/mobel/auth'
], function(){
    return [
        '$scope', '$routeParams', '$log', '$http', '$rootScope', '$validate', '$alert', '$cordovaDevice', 'Mobel_Auth',
        function($scope, $routeParams, $log, $http, $rootScope, $validate, $alert, $cordovaDevice, Mobel_Auth){
            // data to register
            $scope.data = {
                username        : '',
                password        : '',
                password2       : '',
                kode            : '',
                tipe            : $routeParams['tipe'] || 'reset',
                imei            : '123',
                os              : 'browser'
            };

            if(window.device){
                var device = $cordovaDevice.getDevice();
                $scope.data.imei = device.uuid;
                $scope.data.os = device.platform;
            }
            if (window.cordova){
                $scope.data.imei = window.cordova.plugins.uid.IMEI || window.cordova.plugins.uid.UUID || $scope.data.imei;
            }

            $scope.submit = function(){
                var isvalid = $validate()
                    .rule($validate.required($scope.data.username) || $scope.data.tipe == 'aktivasi', 'Isi Email / ID Pel / Nomor Meter terlebih dahulu!')
                    .rule($validate.required($scope.data.password) || $scope.data.tipe == 'aktivasi', 'Isi Kata Sandi terlebih dahulu!')
                    .rule($validate.required($scope.data.password2) || $scope.data.tipe == 'aktivasi', 'Isi Konfirmasi Kata Sandi terlebih dahulu!')
                    .rule($validate.required($scope.data.kode), 'Isi Kode '+($scope.data.tipe=='aktivasi'?'Aktivasi':'Reset Password')+' terlebih dahulu!')
                    .rule(($scope.data.kode + '').length == 6, 'Kode '+($scope.data.tipe=='aktivasi'?'Aktivasi':'Reset Password')+' harus 6 digit!')
                    .check();

                if(!isvalid) return;

                if ($scope.data.tipe == 'aktivasi'){
                    Mobel_Auth.activate($scope.data).then(function(response){
                        if (response == "Kode aktivasi tidak sesuai!"){
                            $alert.add("Kode aktivasi tidak sesuai!");
                        }else{
                            $alert.add('Aktivasi akun berhasil! Silahkan login dengan menggunakan akun anda!');
                            $rootScope.redirect('auth/login');
                        }
                    }, function(response){
                        if (response == 'User tidak ditemukan!'){
                            $alert.add('Aktivasi akun gagal! Pastikan anda melakukan aktivasi dengan menggunakan perangkat yang sama pada saat pendaftaran. Atau jika mengalami kesulitan silahkan hubungi helpdesk kami');
                        }else{
                            $alert.add('Aktivasi akun gagal! Silahkan periksa kembali kode aktivasi yang anda masukan.');
                        }
                    });
                }else {
                    Mobel_Auth.resetpassword($scope.data).then(function(response){
                        $alert.add('Reset password berhasil! Silahkan login dengan menggunakan akun anda!');
                        $rootScope.redirect('auth/login');
                    }, function(response){
                        $alert.add('Reset password gagal! Silahkan periksa kembali data yang anda masukan!');
                    });
                }
            };
        }
    ];
});