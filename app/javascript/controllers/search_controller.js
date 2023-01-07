import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "results"]

  connect() {

  }

  search(event) {
    // Prevent event default
    event.preventDefault();

    // Clear any previous results
    this.resultsTarget.innerHTML = "";

    // Fetch information from api using search data
    this.fetchData(this.inputTarget.value);
  }

  fetchData(query) {
    // Query api with search data
    fetch(`https://data.police.uk/api/${query}/`)
    // Extract relevant api data
  }

  displayResults() {
    // Display api data in results div
  }
}
