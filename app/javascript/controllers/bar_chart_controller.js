import { Controller } from "@hotwired/stimulus"
import Chart from "chart.js/auto"

export default class extends Controller {
  static targets = ["frequency", "quantity", "duration", "interval"]

  connect() {
    this.frequencyTarget && this.buildFrequencyChart()
    this.quantityTarget  && this.buildQuantityChart()
    this.durationTarget  && this.buildDurationChart()
    this.intervalTarget  && this.buildIntervalChart()
  }

  // 1 ─ feeds / day (stacked bar)
  buildFrequencyChart() {
    const ctx = this.frequencyTarget
    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: JSON.parse(ctx.dataset.dayLabels),
        datasets: [
          { label: 'Tétée',  data: JSON.parse(ctx.dataset.tetee),  backgroundColor: '#E1585A' },
          { label: 'Tirage', data: JSON.parse(ctx.dataset.tirage), backgroundColor: '#F4978E' }
        ]
      },
      options: { responsive: true, plugins: { title: { text: 'Sessions par jour', display: true } }, scales: { x: { stacked: true }, y: { stacked: true, beginAtZero:true } } }
    })
  }

  // 2 ─ quantity pumped
  buildQuantityChart() {
    const ctx = this.quantityTarget
    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: JSON.parse(ctx.dataset.dayLabels),
        datasets: [
          { label: 'ml tirées', data: JSON.parse(ctx.dataset.quantity), backgroundColor: '#F4978E' }
        ]
      },
      options: { plugins: { title: { text: 'Quantité tirée (ml)', display: true } }, scales: { y: { beginAtZero: true } } }
    })
  }

  // 3 ─ average duration
  buildDurationChart() {
    const ctx = this.durationTarget
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: JSON.parse(ctx.dataset.dayLabels),
        datasets: [
          { label: 'Durée moyenne (min)', data: JSON.parse(ctx.dataset.duration), borderColor: '#F4978E', fill: false }
        ]
      },
      options: { plugins: { title: { text: 'Durée moyenne par jour', display: true } }, scales: { y: { beginAtZero: true } } }
    })
  }

  // 4 ─ interval between feeds
  buildIntervalChart() {
    const ctx = this.intervalTarget
    const intervals = JSON.parse(ctx.dataset.intervals)
    const target    = Number(ctx.dataset.targetHour)
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: JSON.parse(ctx.dataset.intervalLabels),
        datasets: [
          { label: 'Intervalle réel (h)', data: intervals, borderColor: '#F4978E', fill: false },
          { label: `Objectif ${target}h`, data: Array(intervals.length).fill(target),
            borderColor: '#D4A574', borderDash: [5,5], pointRadius: 0, fill: false }
        ]
      },
      options: { plugins: { title: { text: 'Intervalle entre les sessions', display: true } }, scales: { y: { beginAtZero:true } } }
    })
  }
}
