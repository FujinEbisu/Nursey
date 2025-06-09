import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2';

// Connects to data-controller="feed"
export default class extends Controller {
  connect() {
  }

  supprimer(event) {
    event.preventDefault()
    const url = event.currentTarget.href
    Swal.fire({
  title: "Vous-voulez vraiment supprimer ?",
  showDenyButton: true,
  confirmButtonText: "Oui",
  denyButtonText: `Non`,
   customClass: {
    confirmButton: "button-standard-dark me-2",
    denyButton: "button-standard-dark me-2",
    title: "color: "
  },
  buttonsStyling: false
}).then((result) => {
  /* Read more about isConfirmed, isDenied below */
  if (result.isConfirmed) {
  fetch(url, {
          method: "DELETE",
          headers: {
            "X-CSRF-Token": this.getCsrfToken(),
            "Accept": "text/vnd.turbo-stream.html"
  }
})
    Swal.fire("Supprimé", "", "success").then(() => {
              window.location.reload()
               })
  } else if (result.isDenied) {
    Swal.fire("Aucune modification", "", "info");
  }
});
}
getCsrfToken() {
    return document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  }
}
