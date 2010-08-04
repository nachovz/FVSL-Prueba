
    function load() {
        if (GBrowserIsCompatible()) {
            if (!map) var map = new GMap2(document.getElementById("map"));
            map.setUIToDefault();
            var center = new GLatLng(6.42375, -66.58973);
            map.setCenter(center, 5);
            geocoder = new GClientGeocoder();
            var marker = new GMarker(center, { draggable: true });
            map.addOverlay(marker);
            document.getElementById("lat").innerHTML = center.lat().toFixed(5);
            document.getElementById("lng").innerHTML = center.lng().toFixed(5);
            $('#' + latitud).val(center.lat().toFixed(5));
            $('#' + longitud).val(center.lng().toFixed(5));

            GEvent.addListener(marker, "dragend", function() {
                var point = marker.getPoint();
                map.panTo(point);
                document.getElementById("lat").innerHTML = point.lat().toFixed(5);
                document.getElementById("lng").innerHTML = point.lng().toFixed(5);
                $('#' + latitud).val(point.lat().toFixed(5));
                $('#' + longitud).val(point.lng().toFixed(5));

            });


            GEvent.addListener(map, "moveend", function() {
                var center = map.getCenter();
                var marker = new GMarker(center, { draggable: true });

                map.clearOverlays();
                map.addOverlay(marker);

                document.getElementById("lat").innerHTML = center.lat().toFixed(5);
                document.getElementById("lng").innerHTML = center.lng().toFixed(5);
                $('#' + latitud).val(center.lat().toFixed(5));
                $('#' + longitud).val(center.lng().toFixed(5));


                GEvent.addListener(marker, "dragend", function() {
                    var point = marker.getPoint();
                    map.panTo(point);
                    document.getElementById("lat").innerHTML = point.lat().toFixed(5);
                    document.getElementById("lng").innerHTML = point.lng().toFixed(5);
                    $('#' + latitud).val(point.lat().toFixed(5));
                    $('#' + longitud).val(point.lng().toFixed(5));

                });

            });
        }
    }

    function showAddress(address) {
        var map = new GMap2(document.getElementById("map"));
        map.addControl(new GSmallMapControl());
        //map.addControl(new GMapTypeControl());
        if (geocoder) {
            geocoder.getLatLng(
          		address,
          function(point) {
              if (!point) {
                  alert(address + " not found");
              } else {
                  document.getElementById("lat").innerHTML = point.lat().toFixed(5);
                  document.getElementById("lng").innerHTML = point.lng().toFixed(5);
                  $('#latitud').val(point.lat().toFixed(5));
                  $('#longitud').val(point.lng().toFixed(5));
                  map.clearOverlays()
                  map.setCenter(point, 14);
                  var marker = new GMarker(point, { draggable: true });
                  map.addOverlay(marker);

                  GEvent.addListener(marker, "dragend", function() {
                      var pt = marker.getPoint();
                      map.panTo(pt);
                      document.getElementById("lat").innerHTML = pt.lat().toFixed(5);
                      document.getElementById("lng").innerHTML = pt.lng().toFixed(5);
                      $('#latitud').val(pt.lat().toFixed(5));
                      $('#longitud').val(pt.lng().toFixed(5));
                  });


                  GEvent.addListener(map, "moveend", function() {
                      map.clearOverlays();
                      var center = map.getCenter();
                      var marker = new GMarker(center, { draggable: true });
                      map.addOverlay(marker);
                      document.getElementById("lat").innerHTML = center.lat().toFixed(5);
                      document.getElementById("lng").innerHTML = center.lng().toFixed(5);
                      $('#latitud').val(center.lat().toFixed(5));
                      $('#longitud').val(center.lng().toFixed(5));

                      GEvent.addListener(marker, "dragend", function() {
                          var pt = marker.getPoint();
                          map.panTo(pt);
                          document.getElementById("lat").innerHTML = pt.lat().toFixed(5);
                          document.getElementById("lng").innerHTML = pt.lng().toFixed(5);
                          $('#latitud').val(pt.lat().toFixed(5));
                          $('#longitud').val(pt.lng().toFixed(5));
                      });
                  });

              }
          }
        );
        }
  }

  function habilitarPopup() {
      $('#'+button).click(function(event) {

      $('#content').css({
        top:	getPageScroll()[1] + (getPageHeight() / 10),
        left:	$(window).width() / 2 - 605
      });

          if ($('#content').html() == "") {
              $.ajax({
                  url: 'getlatlong.html',
                  dataType: "html",
                  success: function(data) {
                      $('#content').html(data);
                      $('#content').show();
                      $('#modalBackground').show();
                      load();
                      GUnload();

                      $('#content').click(function() {
                          return false;
                      });
                      $('#modalBackground,#aceptar-image,#close-image').click(function() {
                          $('#modalBackground').hide();
                          $('#content').hide();
                          return false;
                      });
                      $('#search-button').click(function() {
                          showAddress($('#address').val());
                          return false;
                      });
                  }
              });
          }
          else {
              $('#content').show();
              $('#modalBackground').show();
          }

          return false;
      });
  }

  // getPageScroll() by quirksmode.com
  function getPageScroll() {
    var xScroll, yScroll;
    if (self.pageYOffset) {
      yScroll = self.pageYOffset;
      xScroll = self.pageXOffset;
    } else if (document.documentElement && document.documentElement.scrollTop) {	 // Explorer 6 Strict
      yScroll = document.documentElement.scrollTop;
      xScroll = document.documentElement.scrollLeft;
    } else if (document.body) {// all other Explorers
      yScroll = document.body.scrollTop;
      xScroll = document.body.scrollLeft;
    }
    return new Array(xScroll,yScroll)
  }


  // Adapted from getPageSize() by quirksmode.com
  function getPageHeight() {
    var windowHeight
    if (self.innerHeight) {	// all except Explorer
      windowHeight = self.innerHeight;
    } else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
      windowHeight = document.documentElement.clientHeight;
    } else if (document.body) { // other Explorers
      windowHeight = document.body.clientHeight;
    }
    return windowHeight
  }