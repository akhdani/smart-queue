define([
    'component/alt/alert',
    'component/mobel/info',
    'component/mobel/auth'
], function(){
    return [
        '$scope', '$routeParams', '$log', '$http', '$rootScope', 'Mobel_Info', 'Mobel_Auth', '$cordovaDevice', '$cordovaGeolocation', '$alert', '$validate', '$auth', '$timeout',
        function($scope, $routeParams, $log, $http, $rootScope, Mobel_Info, Mobel_Auth, $cordovaDevice, $cordovaGeolocation, $alert, $validate, $auth, $timeout){
            // data to register
            $scope.data = {
                RegId           : store.get(alt.application+'_gcmregid') || '',
                gcm_regid       : store.get(alt.application+'_gcmregid') || '',
                latitude        : '',
                longitude       : '',
                manufacturer    : '',
                model           : '',
                os              : '',
                sdk             : '',
                screen          : '',
                vcode           : '',
                vname           : '',
                imei            : '123',
                operator        : '',
                msisdn          : '',
                imsi            : '',
                name            : '',
                address         : '',
                telp            : '',
                idpel           : '',
                no_meter        : '',
                email           : '',
                password        : '',
                password2       : '',
                nomor_referensi : '',
                unitap          : '',
                unitup          : '',
                unitupi         : ''
            };

            if(window.device){
                $scope.data.imei = window.device.uuid;
            }

            if (window.cordova){
                if (!$scope.data.gcm_regid || $scope.data.gcm_regid == ''){
                    var push = PushNotification.init(alt.gcm);

                    push.on('registration', function(data) {
                        $scope.data.gcm_regid = data.registrationId;
                        store.set(alt.application+'_gcmregid', data.registrationId);
                    });
                }

                var device = $cordovaDevice.getDevice();
                 $scope.data.manufacturer = device.manufacturer;
                 $scope.data.os = device.platform;
                 $scope.data.model = device.model;
                 $scope.data.vname = $cordovaDevice.getVersion();
                 $scope.data.imei = window.cordova.plugins.uid.IMEI || window.cordova.plugins.uid.UUID || $scope.data.imei;
                 $scope.data.imsi = window.cordova.plugins.uid.IMSI;

                window.plugins.DeviceAccounts.getEmails(function(emails){
                    $scope.data.email = emails[0] || '';
                }, function(err){
                    $log.debug('Error : '+angular.toJson(emails));
                });
            }

            /*$cordovaGeolocation.getCurrentPosition({timeout: 10000, enableHighAccuracy: false}).then(function(pos){
                $scope.data.latitude = pos.coords.latitude;
                $scope.data.longitude = pos.coords.longitude;
            });*/

            var options = {
                timeout: 10000,
                enableHighAccuracy: true
            };

            navigator.geolocation.getCurrentPosition(function(position){
                    $scope.data.latitude = position.coords.latitude;
                    $scope.data.longitude = position.coords.longitude;
                },
                function(error){

                },
                options);

            $scope.openMap = function () {
                requirejs([
                    'async!https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places,visualization'
                ], function(){
                    $('#modal-maps').openModal();
                    if(window && window.google && window.google.maps){
                        $scope.load();
                        $scope.$apply();
                    }
                }, function(){
                    $alert.add('Unable to load google map!');
                    $('#modal-maps').closeModal();
                });

                $scope.load = function(){
                    var options = {
                        timeout: 10000,
                        enableHighAccuracy: true
                    };

                    navigator.geolocation.getCurrentPosition(function(position){
                            $scope.loadMap(position);
                        },
                        function(error){
                            $scope.loadMap();
                        },
                        options);

                    /*$cordovaGeolocation.getCurrentPosition(options).then(function(position){
                        $scope.loadMap(position);
                    }, function(error){
                        $log.debug('Geo location err : '+error.message);
                        $scope.load();
                    });*/
                };
            };

            $scope.loadMap = function(position){
                position = position || {coords : {latitude: $auth.userdata.latitude, longitude: $auth.userdata.longitude} } || {coords: {latitude: '-6.240817', longitude: '106.799477'}};

                if (document.getElementById("map")){
                    var latLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                    var mapOptions = {
                        center: latLng,
                        zoom: 15,
                        mapTypeId: google.maps.MapTypeId.ROADMAP,
                        mapTypeControl: false
                    };

                    window.SCREEN_HEIGHT = Math.max(document.documentElement["clientHeight"], document.body["scrollHeight"], document.documentElement["scrollHeight"], document.body["offsetHeight"], document.documentElement["offsetHeight"], window.innerHeight);
                    window.SCREEN_WIDTH  = Math.max(document.documentElement["clientWidth"], document.body["scrollWidth"], document.documentElement["scrollWidth"], document.body["offsetWidth"], document.documentElement["offsetWidth"], window.innerWidth);

                    var mapHeight = Math.round( 3 / 5 * window.SCREEN_HEIGHT);
                    mapHeight = ( window.SCREEN_HEIGHT < 500 ) ? 240 : mapHeight;

                    document.getElementById("map").setAttribute("style", "min-height: 220px; height: "+mapHeight+"px; position: relative; background-color: rgb(229, 227, 223); overflow: hidden; -webkit-transform: translateZ(0px);");

                    $scope.map = new google.maps.Map(document.getElementById("map"), mapOptions);
                    $('<div/>').addClass('centerMarker').appendTo($scope.map.getDiv())
                        //do something onclick
                        .click(function(){
                            var that=$(this);
                            if(!that.data('win')){
                                that.data('win').bindTo('position',$scope.map,'center');
                            }
                            that.data('win').open($scope.map);
                        });

                    // Create the search box and link it to the UI element.
                    var input = document.createElement('input');
                    input.setAttribute("placeholder", "Cari lokasi");
                    input.setAttribute("class", "form-controls");
                    input.setAttribute("style", "background: white; padding: 10px;");

                    var searchBox = new google.maps.places.SearchBox(input);
                    $scope.map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

                    $scope.map.addListener('bounds_changed', function() {
                        searchBox.setBounds($scope.map.getBounds());
                    });

                    searchBox.addListener('places_changed', function() {
                        var places = searchBox.getPlaces();

                        if (places.length == 0) {
                            return;
                        }

                        // For each place, get the icon, name and location.
                        var bounds = new google.maps.LatLngBounds();
                        places.forEach(function(place) {
                            var icon = {
                                url: place.icon,
                                size: new google.maps.Size(71, 71),
                                origin: new google.maps.Point(0, 0),
                                anchor: new google.maps.Point(17, 34),
                                scaledSize: new google.maps.Size(25, 25)
                            };

                            if (place.geometry.viewport) {
                                // Only geocodes have viewport.
                                bounds.union(place.geometry.viewport);
                            } else {
                                bounds.extend(place.geometry.location);
                            }
                        });
                        $scope.map.fitBounds(bounds);
                    });
                }else{
                    $timeout(function () {
                        $scope.loadMap(position);
                    }, 1000);
                }
            };

            $scope.closeMap = function () {
                $('#modal-maps').closeModal();
            };

            $scope.setLocation = function () {
                var latLng = $scope.map.getCenter();
                $scope.data.latitude_persil = latLng.lat();
                $scope.data.longitude_persil = latLng.lng();
                $scope.islocationset = true;
                $alert.add('Lokasi telah tersimpan!', $alert.success);
            };

            $scope.submit = function(){
                var isvalid = $validate()
                    .rule($validate.required($scope.data.name), 'Isi nama terlebih dahulu!')
                    .rule(($scope.data.name + '').length <= 25, 'Nama tidak boleh lebih dari 25 karakter!')
                    .rule(($scope.data.address + '').length <= 100, 'Alamat tidak boleh lebih dari 100 karakter!')
                    .rule($validate.required($scope.islocationset), 'Pilih lokasi alamat terlebih dahulu!')
                    .rule($validate.required($scope.data.telp), 'Isi nomor telepon terlebih dahulu!')
                    .rule(($scope.data.telp + '').length > 0 && ($scope.data.telp + '').length >= 9, 'Nomor telepon minimal 9 karakter!')
                    .rule(($scope.data.telp + '').length > 0 && ($scope.data.telp + '').length <= 15, 'Nomor telepon tidak boleh lebih dari 15 karakter!')
                    .rule($validate.required($scope.data.idpel), 'Isi id pelanggan/nomor meter terlebih dahulu!')
                    .rule($validate.required($scope.data.nomor_referensi), 'Isi kode referensi terlebih dahulu!')
                    .rule(($scope.data.nomor_referensi + '').length == 6, 'Nomor referensi pembayaran harus 6 karakter!')
                    .rule($validate.required($scope.data.email), 'Isi email terlebih dahulu!')
                    .rule($validate.required($scope.data.password), 'Isi kata sandi terlebih dahulu!')
                    .rule($validate.equals($scope.data.password, $scope.data.password2), 'Kata sandi tidak sesuai!')
                    //.rule($validate.required($scope.data.gcm_regid), 'Gagal mendapatkan GCM registration id!')
                    .check();

                if(!isvalid) return;

                Mobel_Info.data_pelanggan({idpel: $scope.data.idpel}).then(function(response){
                    if(typeof response.data === "undefined")
                        return {message: "ID Pelanggan atau Nomor Meter tidak ditemukan!"};

                    var isvalid = $validate()
                        .rule($validate.equals($scope.data.nomor_referensi, response.data.refnum), 'Kode referensi tidak sesuai!')
                        .check();

                    if(!isvalid) return false;

                    $scope.data.idpel = response.data.idpel;
                    $scope.data.no_meter = response.data.nometer_kwh;
                    $scope.data.unitap = response.data.unitap;
                    $scope.data.unitup = response.data.unitup;
                    $scope.data.unitupi = response.data.unitupi;

                    // register to mobile server
                    return Mobel_Auth.register($scope.data);
                }).then(function(response){
                    if(response.data > 0){
                        $alert.add('Pendaftaran berhasil! Silahkan lakukan aktivasi akun dengan menggunakan kode aktivasi yang dikirim melalui email!');
                        $rootScope.redirect('auth/login');
                    }else{
                        $alert.add(response.message, $alert.danger);
                    }
                });
            };
        }
    ];
});