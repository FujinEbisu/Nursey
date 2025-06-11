import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    userLocation: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      zoom: 12
    })
    
    // Get user's current location first, then add markers
    this.#getCurrentLocation()
  }

  #getCurrentLocation() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const latitude = position.coords.latitude
          const longitude = position.coords.longitude
          
          // Store user location
          this.userLocation = [longitude, latitude]
          
          // Add user location marker
          this.#addUserLocationMarker(longitude, latitude)
          
          // Add other markers
          this.#addMarkersToMap()
          
          // Fit map to show user location and nearby places
          this.#fitMapToUserAndMarkers()
          
          // Optionally refresh the page with precise location for backend filtering
          this.#updatePageWithLocation(latitude, longitude)
        },
        (error) => {
          console.log("Geolocation error:", error.message)
          // Fallback to showing markers without user location
          this.#addMarkersToMap()
          
          if (this.userLocationValue && this.userLocationValue.length > 0) {
            this.#fitMapToUserLocation()
          } else {
            this.#fitMapToMarkers()
          }
        },
        {
          enableHighAccuracy: true,
          timeout: 10000,
          maximumAge: 300000 // 5 minutes
        }
      )
    } else {
      // Geolocation not supported, fallback to existing behavior
      this.#addMarkersToMap()
      
      if (this.userLocationValue && this.userLocationValue.length > 0) {
        this.#fitMapToUserLocation()
      } else {
        this.#fitMapToMarkers()
      }
    }
  }

  #addUserLocationMarker(lng, lat) {
    // Create user location marker with different style
    const userMarkerElement = document.createElement("div")
    userMarkerElement.innerHTML = `
      <div style="
        background-color: #007bff;
        width: 20px;
        height: 20px;
        border-radius: 50%;
        border: 3px solid white;
        box-shadow: 0 2px 4px rgba(0,0,0,0.3);
      "></div>
    `
    
    new mapboxgl.Marker(userMarkerElement)
      .setLngLat([lng, lat])
      .addTo(this.map)
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
      
      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToUserLocation() {
    if (this.userLocationValue && this.userLocationValue.length > 0) {
      const bounds = new mapboxgl.LngLatBounds(this.userLocationValue, this.userLocationValue)
      this.map.fitBounds(bounds, { padding: 20, maxZoom: 12, duration: 0 })
    }
  }

  #fitMapToMarkers() {
    if (this.markersValue.length > 0) {
      const bounds = new mapboxgl.LngLatBounds()
      this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))
      this.map.fitBounds(bounds, { padding: 20, maxZoom: 12, duration: 0 })
    }
  }

  #fitMapToUserAndMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    
    // Add user location to bounds
    if (this.userLocation) {
      bounds.extend(this.userLocation)
    }
    
    // Add all markers to bounds
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))
    
    // Fit map to show everything
    this.map.fitBounds(bounds, { padding: 20, maxZoom: 12, duration: 0 })
  }

  #updatePageWithLocation(latitude, longitude) {
    // Only refresh if we don't already have location params
    const urlParams = new URLSearchParams(window.location.search)
    
    if (!urlParams.has('latitude') || !urlParams.has('longitude')) {
      const url = new URL(window.location.href)
      url.searchParams.set('latitude', latitude)
      url.searchParams.set('longitude', longitude)
      
      // Use Turbo to navigate instead of window.location for better UX
      if (window.Turbo) {
        window.Turbo.visit(url.toString())
      } else {
        window.location.href = url.toString()
      }
    }
  }
}