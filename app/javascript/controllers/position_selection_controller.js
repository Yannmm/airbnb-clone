import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['latitude', 'longitude'];

  

  connect() {
    const latitudeField = this.latitudeTarget;
    const longitudeField = this.longitudeTarget;

    const markers = [];

    async function initMap() {
      // Request needed libraries.
      const { Map } = await google.maps.importLibrary("maps");
      const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
      const myLatlng = { lat: parseFloat(latitudeField.value), lng: parseFloat(longitudeField.value) };
      const map = new google.maps.Map(document.getElementById("map"), {
        zoom: 3,
        center: myLatlng,
        mapId: "DEMO_MAP_ID",
      });
      
      const marker = new AdvancedMarkerElement({
        map: map,
        position: myLatlng,
      });
      markers.push(marker);

      // Configure the click listener.
      map.addListener("click", (mapsMouseEvent) => {
        // const text = JSON.stringify(mapsMouseEvent.latLng.toJSON(), null, 2);

        latitudeField.value = mapsMouseEvent.latLng.lat()
        longitudeField.value = mapsMouseEvent.latLng.lng()

        const marker = new AdvancedMarkerElement({
          map: map,
          position: mapsMouseEvent.latLng,
        });

        for (let i = 0; i < markers.length; i++) {
          markers[i].setMap(null);
        }
        markers.push(marker);
      });
    }

    initMap();
  }
}
