<!DOCTYPE html>
<html>
<head>
    <title>Geocoding service</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        #map {
            height: 100%;
        }

        #floating-panel {
            position: absolute;
            top: 10px;
            left: 25%;
            z-index: 5;
            background-color: #fff;
            padding: 5px;
            border: 1px solid #999;
            text-align: center;
            font-family: 'Roboto', 'sans-serif';
            line-height: 30px;
            padding-left: 10px;
        }

    </style>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>

        var xmlhttp = new XMLHttpRequest();

        function initMap() {
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 8,
                center: {lat: -34.397, lng: 150.644}
            });
            var geocoder = new google.maps.Geocoder();

            document.getElementById('submit').addEventListener('click', function () {
                geocodeAddress(geocoder, map);
            });
        }

        function geocodeAddress(geocoder, resultsMap) {
            var address = document.getElementById('address').value;
            geocoder.geocode({'address': address}, function (results, status) {
                if (status === google.maps.GeocoderStatus.OK) {
                    resultsMap.setCenter(results[0].geometry.location);
                    var marker = new google.maps.Marker({
                        map: resultsMap,
                        position: results[0].geometry.location
                    });
                    xmlhttp.onreadystatechange = null;
                    xmlhttp.open("POST", "/servlet", true);
                    xmlhttp.setRequestHeader('location', results[0].geometry.location.toString());
                    xmlhttp.send(null);
                } else {
                    alert('Geocode was not successful for the following reason: ' + status);
                }
            });
        }

        function callServlet() {
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    alert(xmlhttp.responseText);
                }
            };
            xmlhttp.open("GET", "/servlet", true);
            xmlhttp.send(null);
        }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAhyDbMEZ9wjZtzJ3ScTAhZJyNolAS7jVg&signed_in=true&callback=initMap"
            async defer></script>
</head>
<body>
<div id="floating-panel">
    <input id="address" type="textbox" value="Sydney, NSW">
    <input id="submit" type="button" value="Geocode">
    <input id="show" type="button" value="Show" onclick="callServlet()">
</div>

<div id="map"></div>

</body>
</html>