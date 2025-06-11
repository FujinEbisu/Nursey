import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chatbot-links"
export default class extends Controller {

  openDoctorModal(event) {
    event.preventDefault()

    // Create modal HTML
    const modalHTML = `
      <div id="doctor-modal" class="modal-overlay" data-controller="doctor-modal" data-action="click->doctor-modal#closeOnOverlay">
        <div class="modal-content" data-doctor-modal-target="content">
          <div class="modal-header">
            <h3>Docteurs Disponibles</h3>
            <button class="modal-close" data-action="click->doctor-modal#close">&times;</button>
          </div>
          <div class="modal-body">
            <% @dispo.each do |doctor| %>
              <%=  render "chats/card_doctor", doctor: doctor %>
            <% end %>
          </div>
        </div>
      </div>
    `

    // Insert modal into DOM
    document.body.insertAdjacentHTML('beforeend', modalHTML)

    // Load doctors via Turbo Frame or fetch
    this.loadDoctors()
  }

  async loadDoctors() {
    try {
      const response = await fetch('/doctors/available', {
        headers: {
          'Accept': 'text/html',
          'X-Requested-With': 'XMLHttpRequest'
        }
      })

      if (response.ok) {
        const html = await response.text()
        document.getElementById('doctors-list').innerHTML = html
      } else {
        document.getElementById('doctors-list').innerHTML = '<p>Erreur lors du chargement des docteurs.</p>'
      }
    } catch (error) {
      console.error('Error loading doctors:', error)
      document.getElementById('doctors-list').innerHTML = '<p>Erreur lors du chargement des docteurs.</p>'
    }
  }
}
