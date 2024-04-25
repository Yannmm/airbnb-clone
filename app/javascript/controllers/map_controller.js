import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ['property', 'good']

  connect() {


    const properties = this.propertyTargets;


    // Initialize and add the map
    let map;

    async function initMap() {
        // The location of Uluru
        const position = { lat: 30.6594136, lng: 104.0570819 };
        // Request needed libraries.
        //@ts-ignore
        const { Map } = await google.maps.importLibrary("maps");
        const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

        // The map, centered at Uluru
        map = new Map(document.getElementById("map"), {
            zoom: 4,
            center: position,
            mapId: "DEMO_MAP_ID",
        });




        properties.forEach((e) => {
            const priceTag = document.createElement('span')

            priceTag.className = "inline-flex items-center px-2 py-1 text-sm font-medium text-white bg-red-500 rounded-md ring-1 ring-inset ring-green-600/20"
    
            priceTag.textContent = e.dataset.price
            const marker = new AdvancedMarkerElement({
                map: map,
                position: { lat: parseFloat(e.dataset.latitude), lng: parseFloat(e.dataset.longitude) },
                content: priceTag
                // title: 'haha'
            });
        });

    }

    initMap();

    }
}
