import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    if (typeof mapboxgl === 'undefined') {
      console.error("Mapbox GL JS is not defined. Ensure it's loaded correctly.");
      return;
    }

    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [-51.5072, 0.1276], // Default center
      zoom: 12
    });

    this.map.addControl(new mapboxgl.NavigationControl());
    this.map.addControl(
      new MapboxGeocoder({
        accessToken: mapboxgl.accessToken,
        mapboxgl: mapboxgl,
        marker: false
      })
    );

    this.map.on('load', () => {
      this.#addMarkersToMap();
      this.#fitMapToMarkers();
    });
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup({ offset: 25 }).setHTML(marker.info_window_html);

      const customMarker = document.createElement("div");
      customMarker.className = "map-marker";
      customMarker.innerHTML = marker.marker_html;

      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map);
    });
  }

  #fitMapToMarkers() {
    if (this.markersValue.length === 0) return;

    const bounds = new mapboxgl.LngLatBounds();

    this.markersValue.forEach(marker => {
      bounds.extend([marker.lng, marker.lat]);
    });

    this.map.fitBounds(bounds, {
      padding: 50,
      maxZoom: 15
    });
  }
}
